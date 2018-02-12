#!/bin/bash

ruby ./bin/evernote_to_jekyll.rb > ./out/rename_commands.sh
cp ./out/rename_commands.sh $PATH_TO_HTML
