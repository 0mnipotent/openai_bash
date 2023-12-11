# Image Inspector Script

The Image Inspector is a Bash script that utilizes the OpenAI's GPT-4 with vision capabilities to understand and describe images. The script can process both local images and images available at a URL.

## Requirements

- Bash shell (Unix/Linux/Mac)
- `curl` command-line tool to make API requests
- `jq` command-line tool to process JSON data
- `base64` command for encoding local files
- `identify` from the ImageMagick suite for image analysis
- OpenAI API key set as an environment variable `OPENAI_API_KEY`

## Usage

The script can be invoked with various flags to customize the OpenAI API request:

- `-u`: Specify the URL of the image to be described (if both `-u` and `-f` are used, `-u` takes precedence)
- `-f`: Specify the filepath of the image to be encoded and sent to the API
- `-p`: Custom prompt to be used for the request (default is "Describe this image")
- `-t`: Maximum number of tokens to use for the API request (default is 1024)
- `-q`: Calculate a quote for the number of tokens that would be used based on the dimensions of the image (actual request will not be sent)

Note: To use the `-q` option, the `identify` command must be available on your system.

### Examples

1. To describe an image from a URL:

    ```bash
    ./image_inspector.sh -u "http://example.com/image.jpg" -p "What is this an image of?" -t 50
    ```

2. To describe a local image:

    ```bash
    ./image_inspector.sh -f "/path/to/image.png" -p "What is this an image of?" -t 50
    ```

3. To compare two local images:

    ```bash
    ./image_inspector.sh -f "image1.png" -f "image2.png" -p "Compare these images" -t 150
    ```

4. To get a quote for token usage for the local image:

    ```bash
    ./image_inspector.sh -f "/path/to/image.png" -q
    ```

## Installation

1. Clone or download this repository to your machine.

2. Ensure you have the required tools installed (`curl`, `jq`, `base64`, and `identify`).

3. Set your OpenAI API Key as an environment variable:

    ```bash
    export OPENAI_API_KEY='your_api_key_here'
    ```

4. Make the script executable:

    ```bash
    chmod +x image_inspector.sh
    ```

5. You're all set! Use the script as described in the "Usage" section.

## Deployment

This script can be deployed to any system that has a Bash shell and the necessary tools installed. It can also be incorporated into larger automation systems or workflows that require image analysis capabilities.

## Contributing

Contributions to improve the script are welcome. Please ensure that your contributions adhere to best practices and are thoroughly tested. To contribute:

1. Fork the repository.
2. Create a new branch for each feature or improvement.
3. Submit a pull request with a clear description of the changes.

## Limitations

While the script leverages GPT-4 with vision capabilities, there are several known limitations:

- Not suitable for interpreting specialized medical images like CT scans.
- May not perform optimally for images containing non-Latin alphabets or small text.
- Rotated or upside-down text or images may be misinterpreted.
- Struggles to understand graphs or text where colors or styles vary significantly.
- Not ideal for tasks requiring precise spatial localization, such as identifying specific chess positions.

## Support

If you encounter any issues or have questions about using the script, please create an issue in the repository, and we will address it as soon as possible.

## License

This script is provided 'as-is', without any warranty or support. Users should use it at their own risk, and the author(s) are not responsible for any damage caused by the use of this script.
