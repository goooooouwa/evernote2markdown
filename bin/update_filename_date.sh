#!/bin/bash

for filename in $TEMP/*; do
  date_line=$(sed '4q;d' $filename)
  date_prefix=$(echo $date_line | cut -c 7-)
  filebase=$(echo $filename | cut -c 13-)
  echo "cp $filename $date_prefix$filebase"
  cp $filename "$date_prefix$filebase"
done
