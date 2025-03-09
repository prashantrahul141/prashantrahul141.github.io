curl -s -X POST -H "Authorization: Bearer $GITHUB_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"query": "{ user(login: \"prashantrahul141\") { pinnedItems(first: 6, types: [REPOSITORY]) { totalCount edges { node { ... on Repository { name repositoryTopics(first: 3) { edges { node { id topic { id name } } } } primaryLanguage { id name color } description url stargazerCount owner { login } } } } } } }"}' \
     https://api.github.com/graphql | yq -t > repos.toml
