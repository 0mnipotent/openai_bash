#!/bin/bash

# API base URL
API_BASE_URL="https://api.openai.com/v1/files"

# Default purpose
purpose="assistants"

# Function to validate JSONL
is_valid_jsonl_file() {
    local line
    local error_msg="Expected file to have JSONL format, where every line is a valid JSON dictionary."
    while IFS= read -r line; do
        if ! jq empty <<< "$line"; then
            echo "$error_msg Line starts with: ${line:0:40}"
            return 1
        fi
    done < "$1"
    return 0
}

# Function to list files
list_files() {
    curl -s -H "Authorization: Bearer $OPENAI_API_KEY" "$API_BASE_URL" | jq
}

# Function to upload file
upload_file() {
    if [[ "$purpose" == "fine-tune" ]] && ! is_valid_jsonl_file "$file_path"; then
        return 1
    fi
    curl -s -X POST "$API_BASE_URL" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -F purpose="$purpose" \
        -F file=@"$file_path" | jq
}

# Function to delete file
delete_file() {
    curl -s -X DELETE "$API_BASE_URL/$file_id" \
        -H "Authorization: Bearer $OPENAI_API_KEY" | jq
}

# Function to retrieve file information
retrieve_file_info() {
    curl -s -H "Authorization: Bearer $OPENAI_API_KEY" "$API_BASE_URL/$file_id" | jq
}

# Function to retrieve file content
retrieve_file_content() {
    curl -s -H "Authorization: Bearer $OPENAI_API_KEY" "$API_BASE_URL/$file_id/content" | jq
}

# Parse arguments
action=""
file_path=""
file_id=""

while getopts ":lu:d:r:c:p:" opt; do
    case $opt in
        l) action="list" ;;
        u) action="upload"
           file_path="$OPTARG" ;;
        d) action="delete"
           file_id="$OPTARG" ;;
        r) action="retrieve"
           file_id="$OPTARG" ;;
        c) action="retrieve_content"
           file_id="$OPTARG" ;;
        p) purpose="$OPTARG"
           if [[ "$purpose" != "assistants" && "$purpose" != "fine-tune" ]]; then
               echo "Error: Purpose must be 'assistants' or 'fine-tune'."
               exit 1
           fi
           ;;
        \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    esac
done

# Check if OPENAI_API_KEY is set
if [ -z "$OPENAI_API_KEY" ]; then
    echo "Error: OPENAI_API_KEY is not set."
    exit 1
fi

# Execute the action
case $action in
    list)
        list_files
        ;;
    upload)
        if [[ -z "$file_path" ]]; then
            echo "Error: File path for upload not provided."
            exit 1
        fi
        upload_file
        ;;
    delete)
        if [[ -z "$file_id" ]]; then
            echo "Error: File ID for deletion not provided."
            exit 1
        fi
        delete_file
        ;;
    retrieve)
        if [[ -z "$file_id" ]]; then
            echo "Error: File ID for retrieval not provided."
            exit 1
        fi
        retrieve_file_info
        ;;
    retrieve_content)
        if [[ -z "$file_id" ]]; then
            echo "Error: File ID for content retrieval not provided."
            exit 1
        fi
        retrieve_file_content
        ;;
    *)
        echo "No action or invalid action specified."
        exit 1
        ;;
esac
