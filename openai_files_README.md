# OpenAI Files Script

The OpenAI Files script (`openai_files.sh`) is a Bash utility used to interface with the OpenAI Files API. It simplifies the process of uploading, listing, deleting, and retrieving files and their contents on OpenAI's servers, which can be essential for features like Assistants and Fine-tuning.

## Requirements

- Bash shell (Unix/Linux/Mac)
- `curl` command-line tool to make API requests
- `jq` command-line tool to process JSON data
- OpenAI API key set as an environment variable `OPENAI_API_KEY`

## Usage

Before using the script, you must export your OpenAI API key as a shell variable:

```bash
export OPENAI_API_KEY='your_api_key_here'
```

Make sure the script is executable:

```bash
chmod +x openai_files.sh
```

### Commands

- **List Files**: Lists all files uploaded under the user's organization.

  ```bash
  ./openai_files.sh -l
  ```

- **Upload File**: Uploads a new file. The default purpose is `assistants`. For `fine-tune` purposes, the file must be in JSONL format.

  ```bash
  ./openai_files.sh -u path/to/yourfile -p "purpose"
  ```

  where `purpose` is either `assistants` or `fine-tune`.

- **Delete File**: Deletes a file with the specified ID.

  ```bash
  ./openai_files.sh -d "file-id"
  ```

- **Retrieve File Info**: Retrieves metadata about a file with the specified ID.

  ```bash
  ./openai_files.sh -r "file-id"
  ```

- **Retrieve File Content**: Retrieves the contents of a file with the specified ID.

  ```bash
  ./openai_files.sh -c "file-id"
  ```

## Installation

Clone or download this repository, and run the script in your shell:

```bash
./openai_files.sh [option]
```

The script accepts several options for different operations. Use `-l` to list files, `-u` with a file path to upload (`-p` to specify purpose), `-d` followed by a file ID to delete a file, `-r` followed by an ID to retrieve file info, or `-c` with an ID to get the file contents.

## Contributing

If you'd like to contribute, please fork the repository and use a feature branch. Pull requests are warmly welcome.

## Support

For support with using the script or to report issues, please submit an issue in the repository.

## License

This script is provided "as-is" with no warranty. By using this script, you agree to OpenAI's terms and conditions. The user assumes full responsibility for using this script in compliance with the OpenAI usage policies.
