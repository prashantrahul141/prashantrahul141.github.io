for f in *.svg; do
    cairosvg -s 4 "$f" -o "$(basename "$f").png"
done
