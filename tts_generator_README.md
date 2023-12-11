# TTS Generator Script

The TTS Generator is a Bash script that leverages OpenAI's Text-to-Speech (TTS) API to convert written text into lifelike spoken audio. The script supports various voices and output formats, and can cater to a range of applications from narrating blog posts to producing audio in multiple languages.

## Requirements

- Bash shell (Unix/Linux/Mac)
- `curl` command-line tool to make API requests
- OpenAI API key set as an environment variable `OPENAI_API_KEY`

## Usage

The script must be used with either a prompt supplied with `-p` or a text file specified with `-f`. It supports several optional parameters to customize the TTS output.

### Mandatory Arguments

- `-p` : The text prompt for the TTS input.
- `-f` : The file path for the text input. If both `-p` and `-f` are provided, the text file content will be appended to the prompt text.

### Optional Arguments

- `-hd` : Use the high-definition model (`tts-1-hd`). By default, the model is `tts-1`.
- `-v` : Voice option (choices: "alloy", "echo", "fable", "onyx", "nova", "shimmer"). Default is "onyx".
- `-r` : Response format (choices: "mp3", "opus", "aac", "flac"). Default is "mp3".
- `-s` : Speech speed (range: 0.25 to 4.0). Default is 1.0.

### Examples

1. Generate speech using a text prompt:

    ```bash
    ./tts_generator.sh -p "Welcome to our podcast."
    ```

2. Generate speech from a text file:

    ```bash
    ./tts_generator.sh -f "intro.txt"
    ```

3. Append text file content to a prompt:

    ```bash
    ./tts_generator.sh -p "Hi, my name is " -f "name.txt"
    ```

4. Use the high-definition model with a specific voice:

    ```bash
    ./tts_generator.sh -p "I can speak with different voices." -hd -v "nova"
    ```

5. Generate an audio file in Opus format and adjust the speed:

    ```bash
    ./tts_generator.sh -p "The quick brown fox jumps over the lazy dog." -r "opus" -s "1.25"
    ```

## Installation

1. Clone or download this repository to your machine.

2. Set your OpenAI API Key as an environment variable:

    ```bash
    export OPENAI_API_KEY='your_api_key_here'
    ```

3. Make the script executable:

    ```bash
    chmod +x tts_generator.sh
    ```

4. The script is now ready to run as per the usage above.

## Deployment

This script can be deployed to any system that has a Bash shell and `curl`. It can be part of automated systems, workflows, or services where TTS functionality is required.

## Contributing

Contributions to this script are welcome. Please ensure your contributions are well-tested and adherent to best practices.

To contribute:

1. Fork the repository.
2. Create a feature or bugfix branch.
3. Submit a pull request with a clear description of the changes.

## Limitations

The API and script follow the language support of the Whisper model. While the current voices are optimized for English, they can generate audio in supported languages.

Please be aware that the emotional range of the generated audio cannot be directly controlled, and there may be variations based on grammar and capitalization.

## Support

For issues or questions concerning the script, please open an issue in the repository.

## License

This script is provided "as-is" with no warranty or support. Users employ it at their own risk. Authors are not liable for any damage caused by its use.

Please adhere to OpenAI's usage policies when using the script, including providing a disclosure that the voice is AI-generated.
