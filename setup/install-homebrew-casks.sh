#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cat ~/src/dotfiles/packages/homebrew-casks.txt | xargs brew install --cask
