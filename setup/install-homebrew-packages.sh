#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

set -o errexit
set -o nounset
set -o pipefail

brew install \
  caskroom/cask/brew-cask \
  colordiff \
  coreutils \
  findutils \
  gawk \
  git \
  gnu-sed \
  gnu-tar \
  go \
  grep \
  python \
  python3 \
  rsync \
  tmux \
  vim \
  watch

brew cask install \
  dropbox \
  macvim
