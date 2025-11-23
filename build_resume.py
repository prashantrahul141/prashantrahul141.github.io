#!/usr/bin/env python

import os
import subprocess
import sys
import json
import re
from build_gh_repos import fetch_repos

PRE_PROJ_FILE = "./static/resume/pre-proj.tex"
POST_PROJ_FILE = "./static/resume/post-proj.tex"
OUTPUT_FILE = "./static/resume/output.tex"
CV_NAME = "Prashant-Rahul-CV"

# make sure pre and post proj files exist
if not os.path.exists(PRE_PROJ_FILE):
    print(f"ERROR: Pre proj file does not exist, {PRE_PROJ_FILE=}")
    sys.exit(-1)


if not os.path.exists(POST_PROJ_FILE):
    print(f"ERROR: Post proj file does not exist, {POST_PROJ_FILE=}")
    sys.exit(-1)

# write pre proj file
with open(PRE_PROJ_FILE, "r", encoding="utf-8") as pre_file:
    with open(OUTPUT_FILE, "w", encoding="utf-8") as out_file:
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

    block = (
        "\\noindent\\textbf{" + name + "} "
        "\\textit{\\footnotesize (" + topics_str + ") } "
        "\\hfill \\texttt{\\href{" + url + "}{[link]}} \\\\ \n"
        "\\parbox{0.88\\textwidth}{" + desc + "}  \\vspace{0.8em} \n"
    )

    block = re.sub(r"([#_])", r"\\\1", block)
    out.append(block)

with open(OUTPUT_FILE, "a", encoding="utf-8") as out_file:
    out_file.write("\n".join(out))
    out_file.write("\\vspace{-0.5em}")
    with open(POST_PROJ_FILE, "r", encoding="utf-8") as post_proj_file:
        out_file.write(post_proj_file.read())


# generate file
subprocess.run(
    [
        "pdflatex",
        "--output-directory=./static",
        f"-jobname={CV_NAME}",
        f"{OUTPUT_FILE}",
    ]
)

print("Finished building resume....")
