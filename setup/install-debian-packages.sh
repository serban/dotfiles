#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

set -o errexit
set -o nounset
set -o pipefail

sudo apt-get install \
  bzip2 \
  dnsutils \
  git \
  htop \
  psmisc \
  python3 \
  tmux \
  unzip \
  vim
