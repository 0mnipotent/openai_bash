#!/bin/bash

DESC=$(/bin/bash /Users/jackson/ai/openai_gui/image_inspector.sh -f "$1" -p "Describe this image" | sed 's/"//g')
echo $DESC
/bin/bash /Users/jackson/ai/openai_gui/tts_generator.sh -p "$DESC"
