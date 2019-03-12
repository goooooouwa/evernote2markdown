for filename in $TEMP/*; do
  echo $filename
  sed '8d' $filename > tmpfile; mv tmpfile $filename
done

