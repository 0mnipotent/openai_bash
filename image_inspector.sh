#!/bin/bash

# Default values
prompt="Describe this image"
max_tokens=1024

# Function to encode image to base64
encode_image() {
  if [[ -f "$1" ]]; then
    base64 -i "$1" | tr -d '\n'
  else
    echo "File $1 does not exist" >&2
    exit 1
  fi
}


# Create request payload with image URL
create_payload_url() {
  cat <<EOF
{
  "model": "gpt-4-vision-preview",
  "messages": [
    {
      "role": "user",
      "content": [
        {
          "type": "text",
          "text": "$prompt"
        },
        {
          "type": "image_url",
          "image_url": {
            "url": "$image_url"
          }
        }
      ]
    }
  ],
  "max_tokens": $max_tokens
}
EOF
}

create_payload_base64() {
  json_images_array_part=""

  for image_path in "${image_paths[@]}"; do
    base64_image=$(encode_image "$image_path")
    # Construct JSON part for each image
    if [[ -z "$json_images_array_part" ]]; then
      # First image doesn't need a comma at the start
      json_images_array_part+='{"type": "image_url","image_url":{"url":"data:image/jpeg;base64,'"$base64_image"'"}}'
    else
      # Subsequent images do need a comma at the start
      json_images_array_part+=',{"type": "image_url","image_url":{"url":"data:image/jpeg;base64,'"$base64_image"'"}}'
    fi
  done

  # Complete JSON payload with text and images
  payload='{
    "model": "gpt-4-vision-preview",
    "messages": [
      {
        "role": "user",
        "content": [
          {"type": "text", "text": "'"$prompt"'"},
          '"$json_images_array_part"'
        ]
      }
    ],
    "max_tokens": '"$max_tokens"'
  }'

  echo "$payload"
}

calculate_quote() {
  if [[ -z "$1" ]]; then
    echo "No image file provided for quote calculation."
    exit 1
  fi

  # Tokens for low and high detail settings
  local low_detail_cost=85
  local high_detail_tokens_per_tile=170
  local high_detail_base_cost=85
  local total_cost=0

  for image_path in "$@"; do
    # Extract image dimensions using 'identify' from the ImageMagick package
    local dimensions=$(identify -ping -format '%w %h' "$image_path")
    local width=$(cut -d' ' -f1 <<< "$dimensions")
    local height=$(cut -d' ' -f2 <<< "$dimensions")

    # Assume high detail first
    local tiles=0
    local short_side=$width

    # Determine the number of tiles after scaling
    if [[ $width -le $height ]]; then
      short_side=$width
    else
      short_side=$height
    fi

    # Scale down to the shorter side being 768px, if necessary
    if [[ $short_side -gt 2048 ]]; then
      local scale_factor=$(bc -l <<< "768 / $short_side")
      width=$(bc <<< "scale=0; $width * $scale_factor / 1")  # Convert to integer
      height=$(bc <<< "scale=0; $height * $scale_factor / 1")  # Convert to integer
    fi

    local width_tiles=$(( (width + 511) / 512 ))  # ceil division
    local height_tiles=$(( (height + 511) / 512 ))  # ceil division
    tiles=$(( width_tiles * height_tiles ))

    local image_cost=$(( tiles * high_detail_tokens_per_tile + high_detail_base_cost ))
    total_cost=$(( total_cost + image_cost ))
  done

  echo "Total estimated token cost for provided images: $total_cost"
}



# Parse arguments
while getopts "u:f:p:t:q" opt; do
  case $opt in
    u) image_url=$OPTARG ;;
    f) image_paths+=("$OPTARG") ;;
    p) prompt=$OPTARG ;;
    t) max_tokens=$OPTARG ;;
    q) calculate_quote "${image_paths[@]}"
     exit 0 ;;
    \?) echo "Invalid option -$OPTARG" >&2; exit 1 ;;
  esac
done

# Check for quote mode
if [ "$quote_mode" = true ]; then
  calculate_quote "${image_paths[@]}"
  exit 0
fi

# Check if URL or filepath is provided and set payload accordingly
if [ -n "$image_url" ]; then
  payload=$(create_payload_url)
elif [ "${#image_paths[@]}" -ne 0 ]; then
  payload=$(create_payload_base64)
else
  echo "Error: You must provide an image URL or a filepath."
  exit 1
fi

# Make the API call if not in quote mode
if [ -z "$quote_mode" ]; then
  response=$(curl -s -X POST "https://api.openai.com/v1/chat/completions" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$payload")

  echo "$response" | jq '.choices[0].message.content'
fi
