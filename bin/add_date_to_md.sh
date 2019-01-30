#!/bin/bash

# PATH_TO_HTML=/path/to/evernote/html/files
# MD_PATH=/path/to/markdown/files

gfind "$MD_PATH" -name "*.md" -type f -exec basename {} .md ';' > ./out/md_filenames.txt

file="./out/md_filenames.txt"
while IFS= read -r line
do
  md_filename=$(gfind "$PATH_TO_HTML" -name "*$line.html" -type f -printf "%f\n")

  if [ -n "$md_filename" ]
  then
    echo "match found: $md_filename"
    echo "mv $line.md $md_filename" >> ./out/rename_markdown.sh
    cp ./out/rename_markdown.sh "$MD_PATH"
  fi
done <"$file"

echo ""
echo "saved in ./out/rename_markdown.sh"
