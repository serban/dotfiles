#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

set -o errexit
set -o nounset
set -o pipefail

# python   (canonical) = python3 = python@3
# python@2 (canonical) = python2

brew install \
  homebrew/dupes/grep \
  homebrew/dupes/rsync \
  colordiff \
  coreutils \
  editorconfig \
  findutils \
  gawk \
  git \
  gnu-sed \
  gnu-tar \
  go \
  macvim \
  python \
  python@2 \
  tmux \
  vim \
  watch

brew tap caskroom/cask

brew cask install \
  dropbox
