#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

brew tap \
  homebrew/cask-fonts \
  #

cat ~/src/dotfiles/packages/homebrew-casks.txt | xargs brew install --cask
