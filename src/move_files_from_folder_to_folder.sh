for d in */ ; do
    echo "$d"
    mkdir -p ../_notes/$d
  mv $d/* ../_notes/$d
done
