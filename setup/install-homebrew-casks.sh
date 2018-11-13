#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

brew tap caskroom/cask

brew cask install \
  atom \
  audio-hijack \
  divvy \
  dropbox \
  google-chrome \
  grandperspective \
  iterm2 \
  lilypond
