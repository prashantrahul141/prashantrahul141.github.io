#!/usr/bin/env bash
set -e

./build-gh-repos.sh
zola build
