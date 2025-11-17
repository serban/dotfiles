#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cd ~/src/dotfiles/terminfo

tic -x -o ~/.local/share/terminfo xterm-ghostty.src
