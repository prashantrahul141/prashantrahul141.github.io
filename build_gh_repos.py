#!/usr/bin/env python

import os
import sys
import json
import urllib.request
import urllib.parse
import toml


def fetch_repos():
    # make sure github token exist
    GITHUB_TOKEN = os.getenv("GRAPHQL_GITHUB_TOKEN")
    if GITHUB_TOKEN is None:
        print("GRAPHQL_GITHUB_TOKEN does not exist")
        sys.exit(-1)

    QUERY = """
    {
      user(login: "prashantrahul141") {
        pinnedItems(first: 6, types: [REPOSITORY]) {
          edges {
            node {
              ... on Repository {
                name
                primaryLanguage {
                  name
                }
                description
                url
                stargazerCount
                repositoryTopics(first: 3) {
                  edges {
                    node {
                      topic {
                        name
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }"""

    # create request
    data = json.dumps({"query": QUERY}).encode("utf-8")
    req = urllib.request.Request(
        "https://api.github.com/graphql",
        data=data,
        headers={
            "Authorization": f"Bearer {GITHUB_TOKEN}",
            "Content-Type": "application/json",
        },
        method="POST",
    )

    # make request
    with urllib.request.urlopen(req) as res:
        if res.getcode() != 200:
            print(f"WARN: Status code is {res.getcode()=}")
        return res.read().decode("utf-8")


if __name__ == "__main__":
    OUTPUT_FILE = "repos.toml"

    # clear output file
    print("Refetching pinned repos...")
    try:
        os.remove(OUTPUT_FILE)
    except FileNotFoundError:
        print("Removing output file failed as it does not exist")

    response_raw = fetch_repos()
    print(response_raw)

    # convert to toml
    response_body = json.loads(response_raw)
    toml_response = toml.dumps(response_body)

    # write to file
    with open(OUTPUT_FILE, "w", encoding="utf-8") as out_file:
        out_file.write(toml_response)

    print("Done fetching repos")
