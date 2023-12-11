#!/bin/bash

# Default values
model="tts-1"
voice="onyx"
format="mp3"
speed=1.0

# Function to read input from a file
read_input_from_file() {
  local file_content=$(<"$1")
  echo "$file_content"
}

# Helper function to add speed modification to the prompt if necessary
add_speed_to_prompt() {
  if [[ "$speed" != "1.0" ]]; then
    echo "<speak><prosody rate=\"${speed}\">${1}</prosody></speak>"
  else
    echo "$1"
  fi
}

# Parse arguments
while getopts "p:f:hdv:r:s:" opt; do
  case $opt in
    p) prompt=$OPTARG ;;
    f) file=$OPTARG ;;
    hd) model="tts-1-hd" ;;
    v) voice=$OPTARG ;;
    r) format=$OPTARG ;;
    s) speed=$OPTARG ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

# Check for mandatory arguments and prepare input
if [[ -z "$prompt" ]] && [[ -z "$file" ]]; then
  echo "Error: You must provide either a prompt (-p) or a file (-f)."
  exit 1
fi

# Read from the file if it's provided
if [[ -n "$file" ]]; then
  file_input=$(read_input_from_file "$file")
  input_text=$(add_speed_to_prompt "${prompt}${file_input}")
else
  input_text=$(add_speed_to_prompt "$prompt")
fi

# Prepare JSON payload
json_payload=$(cat <<EOF
{
  "model": "$model",
  "voice": "$voice",
  "input": "$input_text",
  "response_format": "$format"
}
EOF
)

# Make the API call
response=$(curl -s -X POST "https://api.openai.com/v1/audio/speech" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$json_payload" \
  --output speech.$format)

echo "Generated audio file: speech.$format"

