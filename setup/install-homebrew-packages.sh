#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

brew tap \
  heroku/brew

cat homebrew-core.txt | xargs brew install
