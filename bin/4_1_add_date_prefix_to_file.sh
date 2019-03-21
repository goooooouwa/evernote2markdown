#!/bin/bash

# parse date prefix from front matter and add it to filename
# date prefix in front matter -> date_prefix-filename

for filename in $PATH_TO_MD/*; do
  title_line=$(sed '3q;d' $filename)
  title=$(echo $title_line | cut -c 9- | rev | cut -c 2- | rev)   # cut front and back

  date_line=$(sed '4q;d' $filename)
  date_prefix=$(echo $date_line | cut -c 7-)
  
  echo "cp $filename $date_prefix$title.md"
  cp $filename "$date_prefix$title.md"
done
