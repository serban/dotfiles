#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

set -o errexit
set -o nounset
set -o pipefail

readonly DOTFILES="${HOME}/src/dotfiles"
readonly PREFERENCES="${HOME}/Library/Preferences"

readonly PLISTS="com.mizage.Divvy.plist"

binary_to_xml() {
  plutil -convert xml1 -o "${DOTFILES}/$1" "${PREFERENCES}/$1"
}

xml_to_binary() {
  plutil -convert binary1 -o "${PREFERENCES}/$1" "${DOTFILES}/$1"
}
