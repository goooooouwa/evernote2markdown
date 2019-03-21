#!/bin/bash

# remove the line immediately after front matter
for filename in $TEMP/*; do
  echo $filename
  sed '8d' $filename > tmpfile; mv tmpfile $filename
done

