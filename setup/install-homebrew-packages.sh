#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cat ~/src/dotfiles/packages/homebrew-core.txt | xargs brew install --formula
