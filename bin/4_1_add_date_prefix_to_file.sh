#!/bin/bash

# parse date prefix from front matter and add it to filename
# date prefix in front matter -> date_prefix-filename

for filename in $PATH_TO_MD/[^0-9]*; do
  title_line=$(sed '2q;d' "$filename")
  title=$(echo $title_line | cut -c 8-)

  date_line=$(sed '4q;d' $filename)
  date_prefix=$(echo $date_line | cut -c 8- | rev | cut -c 2- | rev)   # cut front and back
  
  echo "cp $filename $PATH_TO_MD/$date_prefix-$title.md"
  cp "$filename" "$PATH_TO_MD/$date_prefix-$title.md"
done
