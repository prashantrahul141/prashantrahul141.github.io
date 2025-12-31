#!/usr/bin/env python


import os
import subprocess
import json
import sys
from build_gh_repos import fetch_repos

PRE_PROJ_FILE = "./static/resume-typst/01-pre-proj.typ"
POST_PROJ_FILE = "./static/resume-typst/02-post-proj.typ"
OUT_FILENAME = "Prashant-Rahul-CV.pdf"
OUT_TYPST_FILEPATH = "./static/resume-typst/resume.typ"
OUT_FILEPATH = f"./static/{OUT_FILENAME}"

if not os.path.exists(PRE_PROJ_FILE):
    print(f"ERROR: Pre proj file does not exist, {PRE_PROJ_FILE=}")
    sys.exit(-1)

if not os.path.exists(POST_PROJ_FILE):
    print(f"ERROR: Post proj file does not exist, {POST_PROJ_FILE=}")
    sys.exit(-1)

# write pre proj file
with open(PRE_PROJ_FILE, "r", encoding="utf-8") as pre_file:
    with open(OUT_TYPST_FILEPATH, "w", encoding="utf-8") as out_file:
        out_file.write(pre_file.read())


# fetch repos
response = fetch_repos()

# create projects section
data = json.loads(response)
edges = data["data"]["user"]["pinnedItems"]["edges"]

out = []
for edge in edges:
    node = edge["node"]
    name = node["name"]
    url = node["url"]
    desc = node["description"]
    topics = [t["node"]["topic"]["name"] for t in node["repositoryTopics"]["edges"]]
    topics_str = ", ".join(topics)

    block = f"""
#project_entry(\"{name}\", \"{topics_str}\", \"{url}\", \"{desc}\")
"""
    out.append(block)

# write projs
with open(OUT_TYPST_FILEPATH, "a", encoding="utf-8") as out_file:
    out_file.write("#list_vspace\n".join(out))

    # post proj file
    with open(POST_PROJ_FILE, "r", encoding="utf-8") as post_proj_file:
        out_file.write(post_proj_file.read())

# generate file
subprocess.run(
    ["typst", "compile", "--format", "pdf", OUT_TYPST_FILEPATH, OUT_FILEPATH],
    check=True,
)

print("Finished building resume....")
print(f"Produces = {OUT_FILEPATH}")
