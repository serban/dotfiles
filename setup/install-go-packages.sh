#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cat ~/src/dotfiles/packages/go-core.txt | sed 's/$/@latest/' | xargs go install
