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
  firefox \
  flux \
  google-chrome \
  grandperspective \
  hammerspoon \
  iterm2 \
  karabiner-elements \
  lilypond \
  obsidian \
  signal \
  spotify \
  sublime-merge
