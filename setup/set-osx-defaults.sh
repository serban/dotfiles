#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

set -o errexit
set -o nounset
set -o pipefail

# System Preferences > Keyboard > Key Repeat
defaults write -g KeyRepeat -int 2

# System Preferences > Keyboard > Delay Until Repeat
defaults write -g InitialKeyRepeat -int 15

# Clear defaults cache
killall cfprefsd
