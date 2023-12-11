# OpenAI Fine-tuning Script

This script provides easy command-line access to the OpenAI Fine-tuning API, allowing you to manage fine-tuning jobs to tailor a model to your specific training data.

## Requirements

- Bash shell (Unix/Linux/Mac)
- `curl` command-line tool for making API requests
- `jq` command-line tool for formatting JSON output
- OpenAI API key set as an environment variable `OPENAI_API_KEY`

## Installation

First, clone or download this repository to your machine. Then, set your OpenAI API key as an environment variable:

```bash
export OPENAI_API_KEY='your_openai_api_key'
```
Make the script executable:

```bash
chmod +x fine_tuning.sh
```

## Usage

The script can execute several actions, which are outlined below along with their respective flags.

### Commands

- **Create Fine-tuning Job** `(-c)`

Create a new fine-tuning job by specifying the model and the file containing the training data:

```bash
./fine_tuning.sh -c -m "model_name" -f "training_file_id"
```

- **List Fine-tuning Jobs** `(-l)`

List fine-tuning jobs under your organization:

```bash
./fine_tuning.sh -l
```

- **Retrieve Fine-tuning Job** `(-r)`

Retrieve a specific fine-tuning job using its ID:

```bash
./fine_tuning.sh -r -e "fine_tuning_job_id"
```

- **Cancel Fine-tuning Job** `(-t)`

Cancel an ongoing fine-tuning job:

```bash
./fine_tuning.sh -t -e "fine_tuning_job_id"
```

- **List Fine-tuning Events** `(-g)`

Fetch the list of events or updates for a fine-tuning job:

```bash
./fine_tuning.sh -g -e "fine_tuning_job_id"
```

### Optional Parameters

- `(-m)`: Model name (required for creating a job).
- `(-f)`: Training file ID (required for creating a job).
- `(-s)`: Suffix for the fine-tuned model name (optional).
- `(-h)`: Validation file ID (optional).
- `(-v)`: The limit on the number of jobs or events to retrieve (default 20).
- `(-e)`: Fine-tuning job ID (required for retrieve, cancel, and list events).

## Contributing

Contributions are welcome. Please fork the repository, create a feature branch, and submit a pull request for review.

## Support

For support with the script or to report issues, please open an issue in this repository.

## License

This script is shared "as-is," without warranty. Users assume full responsibility for their usage within the terms of service defined by OpenAI.
