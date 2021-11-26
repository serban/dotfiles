#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cat autopintab.json       | jq             | sponge autopintab.json
cat dark-reader.json      | jq --sort-keys | sponge dark-reader.json
cat toolkit-for-ynab.json | jq --sort-keys | sponge toolkit-for-ynab.json