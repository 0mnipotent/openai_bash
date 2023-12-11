#!/bin/bash

API_BASE_URL="https://api.openai.com/v1/fine_tuning/jobs"

# Function to create a fine-tuning job
create_fine_tuning_job() {
    curl -s -X POST "$API_BASE_URL" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d "{\"model\": \"$model\", \"training_file\": \"$training_file\", \"suffix\": \"$suffix\", \"validation_file\": \"$validation_file\"}" | jq
}

# Function to list fine-tuning jobs
list_fine_tuning_jobs() {
    curl -s "$API_BASE_URL?limit=$limit" \
        -H "Authorization: Bearer $OPENAI_API_KEY" | jq
}

# Function to retrieve a fine-tuning job
retrieve_fine_tuning_job() {
    curl -s "$API_BASE_URL/$fine_tuning_job_id" \
        -H "Authorization: Bearer $OPENAI_API_KEY" | jq
}

# Function to cancel a fine-tuning job
cancel_fine_tuning_job() {
    curl -s -X POST "$API_BASE_URL/$fine_tuning_job_id/cancel" \
        -H "Authorization: Bearer $OPENAI_API_KEY" | jq
}

# Function to list fine-tuning events
list_fine_tuning_events() {
    curl -s "$API_BASE_URL/$fine_tuning_job_id/events?limit=$limit" \
        -H "Authorization: Bearer $OPENAI_API_KEY" | jq
}

# Parse arguments
action=""
model=""
training_file=""
suffix=""
validation_file=""
limit=20
fine_tuning_job_id=""

while getopts ":crlgt:v:s:h:e:m:f:" opt; do
    case $opt in
        c) action="create" ;;
        r) action="retrieve" ;;
        l) action="list" ;;
        t) action="cancel" ;;
        g) action="list_events" ;;
        m) model="$OPTARG" ;;
        f) training_file="$OPTARG" ;;
        s) suffix="$OPTARG" ;;
        h) validation_file="$OPTARG" ;;
        e) fine_tuning_job_id="$OPTARG" ;;
        v) limit="$OPTARG" ;;
        \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    esac
done

# Execute the action
case $action in
    create)
        if [[ -z "$model" || -z "$training_file" ]]; then
            echo "Error: Model and Training file are required."
            exit 1
        fi
        create_fine_tuning_job
        ;;
    list)
        list_fine_tuning_jobs
        ;;
    retrieve)
        if [[ -z "$fine_tuning_job_id" ]]; then
            echo "Error: Fine-tuning Job ID is required."
            exit 1
        fi
        retrieve_fine_tuning_job
        ;;
    cancel)
        if [[ -z "$fine_tuning_job_id" ]]; then
            echo "Error: Fine-tuning Job ID is required."
            exit 1
        fi
        cancel_fine_tuning_job
        ;;
    list_events)
        if [[ -z "$fine_tuning_job_id" ]]; then
            echo "Error: Fine-tuning Job ID is required for listing events."
            exit 1
        fi
        list_fine_tuning_events
        ;;
    *)
        echo "Error: No action specified."
        exit 1
        ;;
esac
