#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

brew tap \
  heroku/brew

cat ~/src/dotfiles/packages/homebrew-core.txt | xargs brew install --formula
