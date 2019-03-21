#!/bin/bash

# copy date prefixes from html note files to corresponding markdown files

# PATH_TO_HTML=/path/to/evernote/html/files
# PATH_TO_MD=/path/to/markdown/files

gfind "$PATH_TO_MD" -name "*.md" -type f -exec basename {} .md ';' > ./out/md_filenames.txt

file="./out/md_filenames.txt"
while IFS= read -r line
do
  html_note_filename=$(gfind "$PATH_TO_HTML" -name "*$line.html" -type f -printf "%f\n")

  if [ -n "$html_note_filename" ]
  then
    echo "match found: $html_note_filename"
    echo "mv $line.md $html_note_filename" >> ./out/rename_markdown.sh
    cp ./out/rename_markdown.sh "$PATH_TO_MD"
  fi
done <"$file"

echo ""
echo "saved in ./out/rename_markdown.sh"
