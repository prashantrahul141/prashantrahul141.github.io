#!/usr/bin/env bash

PRE_PROJ_FILE="./static/resume/pre-proj.tex"
POST_PROJ_FILE="./static/resume/post-proj.tex"
OUTPUT_FILE="./static/resume/output.tex"
CV_FILE="./static/Prashant-Rahul-CV.pdf"

QUERY='{"query": "{ user(login: \"prashantrahul141\") { pinnedItems(first: 6, types: [REPOSITORY]) { edges { node { ... on Repository { name primaryLanguage { name } description url stargazerCount repositoryTopics(first: 3) { edges { node { topic { name } } } } } } } } } }"}'

RESPONSE=$(curl -s -X POST -H "Authorization: Bearer $GRAPHQL_GITHUB_TOKEN" \
     -H "Content-Type: application/json" \
     -d "$QUERY" \
     https://api.github.com/graphql)

test -f "$PRE_PROJ_FILE" && cat "$PRE_PROJ_FILE" > "$OUTPUT_FILE"

echo "$RESPONSE" | jq -r '
  .data.user.pinnedItems.edges[] | .node |
  "\\noindent\\textbf{" + .name + "} \\textit{\\footnotesize (" +
  ( [(.repositoryTopics.edges[].node.topic.name)] | join(", ") ) +
  ") } \\hfill \\texttt{\\href{" + .url + "}{[link]}} \\\\ \n" +
  (.description // "No description available") + " \\\\ \n"
' | sed 's/C#/C\\#/g' >> "$OUTPUT_FILE"

test -f "$POST_PROJ_FILE" && cat "$POST_PROJ_FILE" >> "$OUTPUT_FILE"

pdflatex -output-directory=./static/ -jobname="Prashant-Rahul-CV" "$OUTPUT_FILE"

printf "\n\nFinished building resume....\n"
