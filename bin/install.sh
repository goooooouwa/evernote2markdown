#!/bin/bash

./bin/add_date_to_en.rb > ./out/rename.sh
cp ./out/rename.sh "$PATH_TO_HTML"
