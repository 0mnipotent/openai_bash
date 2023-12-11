# OpenAI Utility Scripts

This repository contains two utility scripts that leverage OpenAI's powerful APIs to perform different tasks: image analysis and text-to-speech synthesis.

## Scripts

### Image Inspector (`image_inspector.sh`)

The `image_inspector.sh` script uses OpenAI's GPT-4 with Vision capabilities to analyze images and provide descriptions or answers to questions about the content of the images. It supports handling images from URLs or local files and includes options for multiple image processing and cost estimation based on image dimensions.

For detailed usage and examples, refer to `image_inspector_README.md`.

### TTS Generator (`tts_generator.sh`)

The `tts_generator.sh` script turns text into lifelike spoken audio using OpenAI's TTS model. It features built-in voices and multiple output formats, suited for various applications such as narrating written content or producing spoken language in supported languages.

For comprehensive usage instructions and examples, see `tts_generator_README.md`.

## Usage

Each script is standalone and can be used by executing it with the appropriate command-line arguments to perform the desired action. They support mandatory arguments for basic functionality, as well as optional arguments to customize the output.

Refer to the individual README files for each script for specific details on the required and optional arguments, examples of how to run the scripts, and information on their limitations and support.

## Installation

To use these scripts:

1. Clone this repository or download the scripts to your machine.
2. Ensure you have the necessary prerequisites installed (`curl`, `jq`, `identify` for `image_inspector.sh`; `curl` only for `tts_generator.sh`).
3. Set your OpenAI API key as an environment variable `OPENAI_API_KEY`.
4. Make the scripts executable (`chmod +x image_inspector.sh tts_generator.sh`).

Please comply with OpenAI's usage policies when utilizing these scripts, including informing end-users of the AI-generated content where applicable.

## Contributing

Contributions are welcome. To contribute, fork the repository, create a new branch for your feature or improvement, and submit a pull request with a clear description of your changes.

## Support

If you encounter any issues or have questions about the scripts, open an issue in this repository.

## License

These scripts are provided "as-is" without any warranty. Users should use the scripts at their own risk, and the author(s) are not responsible for any damage or incorrect use.
