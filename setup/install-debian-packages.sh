#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

set -o errexit
set -o nounset
set -o pipefail

sudo apt-get install \
  bzip2 \
  colortest \
  dnsutils \
  git \
  htop \
  psmisc \
  python3 \
  tmux \
  unzip \
  vim

# Optionally add Debian testing to /etc/apt/sources.list and then run:
# sudo apt-get install --only-upgrade git tmux vim
