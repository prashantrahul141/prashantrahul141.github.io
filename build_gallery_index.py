#!/usr/bin/env python

import os
import sys
import pathlib
import re

print("Building gallery images index...")

DIRECTORY = "./static/gallery-images"
OUTPUT_FILE = "gallery-images.toml"

# remove old file first
try:
    os.remove(OUTPUT_FILE)
except Exception:
    print(f"Failed trying to remove: {OUTPUT_FILE}")

# make sure gallery directory exists
if not os.path.exists(DIRECTORY):
    print("Gallery images directory not found.")
    sys.exit(-1)

# get image files, sort them
files = os.listdir(DIRECTORY)
files.sort()

out_text = "[gallery]\nimages = [\n"

# create entries for each image
for filename in files:
    basename = pathlib.Path(filename).stem
    alt = re.sub(r"[_]", " ", re.sub(r"[0-9\-]", "", basename))
    out_text += f'    {{ filename  = "{filename}", alt = "{alt}" }},\n'
out_text += "]\n"

# write to file
with open(OUTPUT_FILE, "w", encoding="utf-8") as out_file:
    out_file.write(out_text)

print(f"{out_text}")
print("Finished building gallery images index")
