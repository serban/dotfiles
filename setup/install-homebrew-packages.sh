#!/usr/bin/env bash

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
  less \
  macvim \
  pipenv \
  python \
  python@2 \
  rsync \
  sqlite \
  the_silver_searcher \
  tmux \
  vim \
  watch \
  watchman
