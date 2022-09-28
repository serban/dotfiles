#!/usr/bin/env bash

# • https://github.com/tmux/tmux/issues/2262
#   ↳ Getting "WARNING: terminal is not fully functional" when using tmux-256color on macOS Catalina
# • https://github.com/tmux/tmux/issues/3218
#   ↳ 3.3a questions and comments
# • https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos
#   ↳ The definitive guide to using tmux-256color on macOS

set -o errexit
set -o nounset
set -o pipefail

readonly out=$(gmktemp --tmpdir tmux-256color.XXXXXX)

/opt/homebrew/Cellar/ncurses/*/bin/infocmp -x tmux-256color > $out
/usr/bin/tic -x $out  # Writes to ~/.terminfo/*/tmux-256color
rm $out
