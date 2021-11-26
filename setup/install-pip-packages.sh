#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly PIP_REQUIRE_VIRTUALENV=false

if [[ "$(uname -s)" == Darwin ]]; then
  cat ~/src/dotfiles/packages/pip.txt | xargs pip3 install
else
  cat ~/src/dotfiles/packages/pip.txt | xargs pip3 install --user
fi

fish -c 'vf install auto_activation'
