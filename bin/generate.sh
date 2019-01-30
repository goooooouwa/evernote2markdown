#!/bin/bash

./bin/convert.rb > ./out/rename.sh
echo $PATH_TO_HTML
cp ./out/rename.sh $PATH_TO_HTML
