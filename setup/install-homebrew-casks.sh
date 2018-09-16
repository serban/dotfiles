#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

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
