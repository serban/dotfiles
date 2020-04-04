#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# python   (canonical) = python3 = python@3
# python@2 (canonical) = python2

brew install \
  bazel \
  colordiff \
  coreutils \
  editorconfig \
  findutils \
  fish \
  gawk \
  git \
  gnu-sed \
  gnu-tar \
  go \
  graphviz \
  grep \
  hashdeep \
  hexyl \
  httpie \
  hugo \
  jq \
  less \
  macvim \
  pastel \
  pipenv \
  python \
  python@2 \
  rsync \
  sqlite \
  the_silver_searcher \
  tmux \
  watch \
  watchman
