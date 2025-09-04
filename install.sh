#!/usr/bin/env bash

# GNU ln › What's the difference between --no-dereference and --no-target-directory?
# ↳ https://serverfault.com/questions/147787/how-to-update-a-symbolic-link-target-ln-f-s-not-working

set -o errexit
set -o nounset
set -o pipefail

readonly OS="$(uname -s)"
readonly WHOAMI="$(whoami)"

readonly DOTS0='src/dotfiles'
readonly DOTS1='../src/dotfiles'
readonly DOTS2='../../src/dotfiles'
readonly DOTS3='../../../src/dotfiles'
readonly DOTFILES="${HOME}/src/dotfiles"

function darwin {
  [ "${OS}" = 'Darwin' ]
}

function freebsd {
  [ "${OS}" = 'FreeBSD' ]
}

function linux {
  [ "${OS}" = 'Linux' ]
}

function root {
  [ "${WHOAMI}" = 'root' ]
}

function debian {
  [ -f /etc/debian_version ]
}

darwin && {
  readonly         ITERM="${HOME}/Library/Application Support/iTerm2"
  readonly SUBLIME_MERGE="${HOME}/Library/Application Support/Sublime Merge/Packages/User"
  readonly  SUBLIME_TEXT="${HOME}/Library/Application Support/Sublime Text 3/Packages/User"
  readonly        VSCODE="${HOME}/Library/Application Support/Code/User"
}

linux && {
  readonly SUBLIME_MERGE="${HOME}/.config/sublime_merge/Packages/User"
  readonly  SUBLIME_TEXT="${HOME}/.config/sublime-text-3/Packages/User"
  readonly        VSCODE="${HOME}/.config/Code/User"
}

umask u=rwx,g=,o=  # umask 077

mkdir -p -m 700 ~/.cache
mkdir -p -m 700 ~/.config
mkdir -p -m 700 ~/.local
mkdir -p -m 700 ~/.local/bin
mkdir -p -m 700 ~/.local/share
mkdir -p -m 700 ~/.local/state

chmod 700 ~/.cache
chmod 700 ~/.config
chmod 700 ~/.local
chmod 700 ~/.local/bin
chmod 700 ~/.local/share
chmod 700 ~/.local/state

mkdir -p -m 700 ~/.cache/grip

mkdir -p -m 700 ~/.local/share/bookmarks
mkdir -p -m 700 ~/.local/share/gnupg

mkdir -p -m 700 ~/.local/state/bash
mkdir -p -m 700 ~/.local/state/bash/history
mkdir -p -m 700 ~/.local/state/bpython
mkdir -p -m 700 ~/.local/state/less
mkdir -p -m 700 ~/.local/state/postgresql
mkdir -p -m 700 ~/.local/state/python
mkdir -p -m 700 ~/.local/state/sqlite
mkdir -p -m 700 ~/.local/state/vim
mkdir -p -m 700 ~/.local/state/vim/swap

root || darwin || freebsd && {
  ln -si ${DOTS0}/bashrc                ~/.bash_profile
}

ln -si ${DOTS0}/bash_logout             ~/.bash_logout
ln -si ${DOTS0}/bashrc                  ~/.bashrc
ln -si ${DOTS0}/bazelrc                 ~/.bazelrc
ln -si ${DOTS0}/blazerc                 ~/.blazerc
ln -si ${DOTS0}/hushlogin               ~/.hushlogin

mkdir -p ~/.config/alacritty
ln -si ${DOTS2}/alacritty.yml           ~/.config/alacritty/alacritty.yml

mkdir -p ~/.config/bat
ln -si ${DOTS2}/bat-config              ~/.config/bat/config

mkdir -p ~/.config/bpython
ln -si ${DOTS2}/bpython-config          ~/.config/bpython/config

mkdir -p ~/.config/colordiff
ln -si ${DOTS2}/colordiffrc             ~/.config/colordiff/colordiffrc

mkdir -p ~/.config/conky
ln -si ${DOTS2}/conky.conf              ~/.config/conky/conky.conf

mkdir -p ~/.config/dust
ln -si ${DOTS2}/dust-config.toml        ~/.config/dust/config.toml

mkdir -p ~/.config/emacs
ln -si ${DOTS2}/emacs/early-init.el     ~/.config/emacs/early-init.el
ln -si ${DOTS2}/emacs/init.el           ~/.config/emacs/init.el

mkdir -p ~/.config/fish
ln -si ${DOTS2}/fish/conf.d             ~/.config/fish/conf.d
ln -si ${DOTS2}/fish/completions        ~/.config/fish/completions
ln -si ${DOTS2}/fish/functions          ~/.config/fish/functions
ln -si ${DOTS2}/fish/config.fish        ~/.config/fish/config.fish

mkdir -p ~/.config/gdb
ln -si ${DOTS2}/gdbearlyinit            ~/.config/gdb/gdbearlyinit
ln -si ${DOTS2}/gdbinit                 ~/.config/gdb/gdbinit

mkdir -p ~/.config/ghostty
ln -si ${DOTS2}/ghostty-config          ~/.config/ghostty/config

mkdir -p ~/.config/git
ln -si ${DOTS2}/git-config              ~/.config/git/config
ln -si ${DOTS2}/git-ignore              ~/.config/git/ignore

mkdir -p ~/.config/hammerspoon
ln -si ${DOTS2}/hammerspoon/serban      ~/.config/hammerspoon/serban
ln -si ${DOTS2}/hammerspoon/init.lua    ~/.config/hammerspoon/init.lua

mkdir -p ~/.config/helix
ln -si ${DOTS2}/helix-config.toml       ~/.config/helix/config.toml
ln -si ${DOTS2}/helix-languages.toml    ~/.config/helix/languages.toml

mkdir -p ~/.config/hg
ln -si ${DOTS2}/hgrc                    ~/.config/hg/hgrc

mkdir -p ~/.config/i3
ln -si ${DOTS2}/i3-config               ~/.config/i3/config

mkdir -p ~/.config/i3status
ln -si ${DOTS2}/i3status-config         ~/.config/i3status/config

mkdir -p ~/.config/ipython/profile_default
ln -si ${DOTS3}/ipython_config.py       ~/.config/ipython/profile_default/ipython_config.py

mkdir -p ~/.config/less
ln -si ${DOTS2}/lesskey                 ~/.config/less/lesskey

mkdir -p ~/.config/readline
ln -si ${DOTS2}/inputrc                 ~/.config/readline/inputrc

mkdir -p ~/.config/kitty
ln -si ${DOTS2}/kitty.conf              ~/.config/kitty/kitty.conf
ln -si ${DOTS2}/kitty-paste-actions.py  ~/.config/kitty/paste-actions.py

mkdir -p ~/.config/lf
ln -si ${DOTS2}/lfrc                    ~/.config/lf/lfrc

mkdir -p ~/.config/moc/themes
ln -si ${DOTS2}/moc-config              ~/.config/moc/config
ln -si ${DOTS3}/moc-theme               ~/.config/moc/themes/serban

mkdir -p ~/.config/newsboat
ln -si ${DOTS2}/newsboat-config         ~/.config/newsboat/config

mkdir -p ~/.config/nitrogen
ln -si ${DOTS2}/bg-saved.cfg            ~/.config/nitrogen/bg-saved.cfg

mkdir -p ~/.config/nvim
ln -si ${DOTS2}/vim/vimrc               ~/.config/nvim/init.vim

mkdir -p ~/.config/procs
ln -si ${DOTS2}/procs-config.toml       ~/.config/procs/config.toml

mkdir -p ~/.config/screen
ln -si ${DOTS2}/screenrc                ~/.config/screen/screenrc

mkdir -p ~/.config/sqlite3
ln -si ${DOTS2}/sqliterc                ~/.config/sqlite3/sqliterc

mkdir -p ~/.config/tmux
ln -si ${DOTS2}/tmux.conf               ~/.config/tmux/tmux.conf

mkdir -p ~/.config/vim
ln -si ${DOTS2}/vim/after               ~/.config/vim/after
ln -si ${DOTS2}/vim/pack                ~/.config/vim/pack
ln -si ${DOTS2}/vim/ultisnips           ~/.config/vim/UltiSnips
ln -si ${DOTS2}/vim/gvimrc              ~/.config/vim/gvimrc
ln -si ${DOTS2}/vim/vimrc               ~/.config/vim/vimrc

mkdir -p ~/.config/wezterm
ln -si ${DOTS2}/wezterm.lua             ~/.config/wezterm/wezterm.lua

mkdir -p ~/.config/zed
ln -si ${DOTS2}/zed/snippets            ~/.config/zed/snippets
ln -si ${DOTS2}/zed/keymap.json         ~/.config/zed/keymap.json
ln -si ${DOTS2}/zed/settings.json       ~/.config/zed/settings.json

darwin && {
  ln -si ~/.config/gdb                  ~/Library/Preferences/gdb
}

debian && {
  ln -si /usr/bin/batcat                ~/.local/bin/bat
}

darwin && {
  ln -si  /Applications/kitty.app/Contents/MacOS/kitten                         ~/.local/bin/kitten
  ln -si  /Applications/kitty.app/Contents/MacOS/kitty                          ~/.local/bin/kitty
  ln -si  /Applications/Ghostty.app/Contents/MacOS/ghostty                      ~/.local/bin/ghostty
  ln -si  /Applications/MacVim.app/Contents/bin/mvim                            ~/.local/bin/mvim
  ln -si  /Applications/WezTerm.app/Contents/MacOS/wezterm                      ~/.local/bin/wezterm
  ln -si  /Applications/WezTerm.app/Contents/MacOS/wezterm-gui                  ~/.local/bin/wezterm-gui
  ln -si  /Applications/Zed.app/Contents/MacOS/cli                              ~/.local/bin/zed
  ln -si '/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge'    ~/.local/bin/smerge
  ln -si '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'       ~/.local/bin/subl
  ln -si '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code' ~/.local/bin/code
}

darwin && {
  mkdir -p "${ITERM}"
  ln -si ${DOTFILES}/iterm2/DynamicProfiles "${ITERM}/DynamicProfiles"
  ln -si ${DOTFILES}/iterm2/Scripts         "${ITERM}/Scripts"
}

darwin || linux && {
  mkdir -p "${SUBLIME_MERGE}"
  ln -si "${DOTFILES}/sublime-merge/Commit.sublime-menu"          "${SUBLIME_MERGE}/Commit.sublime-menu"
  ln -si "${DOTFILES}/sublime-merge/Default.sublime-keymap"       "${SUBLIME_MERGE}/Default.sublime-keymap"
  ln -si "${DOTFILES}/sublime-merge/Preferences.sublime-settings" "${SUBLIME_MERGE}/Preferences.sublime-settings"
}

darwin || linux && {
  mkdir -p "${SUBLIME_TEXT}"
  ln -si "${DOTFILES}/sublime/Preferences.sublime-settings"     "${SUBLIME_TEXT}/Preferences.sublime-settings"
  ln -si "${DOTFILES}/sublime/Package Control.sublime-settings" "${SUBLIME_TEXT}/Package Control.sublime-settings"
}

darwin || linux && {
  mkdir -p "${VSCODE}"
  ln -si ${DOTFILES}/vscode/settings.json "${VSCODE}/settings.json"
}
