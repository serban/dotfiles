#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cat ~/src/dotfiles/packages/debian-{core,py-libs,py-repls,py-tools}.txt | xargs sudo apt-get install --yes
