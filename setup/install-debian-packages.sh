#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

set -o errexit
set -o nounset
set -o pipefail

sudo apt-get install \
  git \
  htop \
  python3 \
  tmux \
  vim
