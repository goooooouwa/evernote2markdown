#!/bin/bash

ruby ./bin/run.rb > ./out/rename_commands.sh
cp ./out/rename_commands.sh $PATH_TO_HTML
