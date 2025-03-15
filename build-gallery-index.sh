#!/usr/bin/env bash

echo "Building gallery images index..."
directory="./static/gallery-images"
output_file="gallery-images.toml"

rm -f $output_file

# Check if directory exists
if [ ! -d "$directory" ]; then
    echo "Gallery images directory not found!"
    exit 1
fi

printf "[gallery]\nimages = [\n" >> "$output_file"
for file_path in "$directory"/*; do
    if [ -f "$file_path" ]; then
        filename=$(basename "$file_path")
        IFS='-' read -ra file_properties <<< "$(basename "$file_path")"
        alt_text=$(echo "${file_properties[1]}" | tr "_" " " | sed 's/\.[^.]*$//')
        item="{ filename = \"$filename\", alt = \"$alt_text\" },"
        echo "    $item" >> "$output_file"
    fi
done
printf "]\n" >> "$output_file"


echo "Finished building gallery images index"

printf "\n"
cat gallery-images.toml
printf "\n\n"
