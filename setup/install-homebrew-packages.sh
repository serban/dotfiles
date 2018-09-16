#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

set -o errexit
set -o nounset
set -o pipefail

# python   (canonical) = python3 = python@3
# python@2 (canonical) = python2

brew install \
  colordiff \
  coreutils \
  editorconfig \
  findutils \
  gawk \
  git \
  gnu-sed \
  gnu-tar \
  go \
  grep \
  graphviz \
  httpie \
  hugo \
  macvim \
  python \
  python@2 \
  rsync \
  sqlite \
  tmux \
  vim \
  watch \
  watchman

brew tap caskroom/cask

brew cask install \
  dropbox
