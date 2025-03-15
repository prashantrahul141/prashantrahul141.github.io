#!/usr/bin/env bash

echo "Refetching pinned repos..."

output_file="repos.toml"
rm -f $output_file

curl -s -X POST -H "Authorization: Bearer $GRAPHQL_GITHUB_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"query": "{ user(login: \"prashantrahul141\") { pinnedItems(first: 6, types: [REPOSITORY]) { edges { node { ... on Repository { name primaryLanguage { name } description url stargazerCount } } } } } }"}' \
     https://api.github.com/graphql | yq -t > $output_file

echo "Done fetching..."

printf "\n"
cat repos.toml
printf "\n\n"
