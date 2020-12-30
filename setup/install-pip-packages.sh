#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly PIP_REQUIRE_VIRTUALENV=false

cat ~/src/dotfiles/packages/pip.txt | xargs pip3 install
