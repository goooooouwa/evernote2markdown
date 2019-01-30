#!/bin/bash

./bin/convert.rb > ./out/rename_commands.sh
cp ./out/rename_commands.sh $PATH_TO_HTML
