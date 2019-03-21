#!/bin/bash

./bin/generate_html_rename_commands.rb > ./out/rename_html.sh
cp ./out/rename_html.sh "$PATH_TO_HTML"
