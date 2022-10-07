#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cat settings.json | jq --sort-keys | sponge settings.json
