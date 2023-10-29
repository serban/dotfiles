#!/usr/bin/env bash

# GNU ln › What's the difference between --no-dereference and --no-target-directory?
# ↳ https://serverfault.com/questions/147787/how-to-update-a-symbolic-link-target-ln-f-s-not-working

set -o errexit
set -o nounset
set -o pipefail

readonly DOTFILES="${HOME}/src/dotfiles"
readonly OS="$(uname -s)"
readonly WHOAMI="$(whoami)"

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
  readonly        ITERM="${HOME}/Library/Application Support/iTerm2"
  readonly SUBLIME_TEXT="${HOME}/Library/Application Support/Sublime Text 3/Packages/User"
  readonly       VSCODE="${HOME}/Library/Application Support/Code/User"
}

linux && {
  readonly SUBLIME_TEXT="${HOME}/.config/sublime-text-3/Packages/User"
  readonly       VSCODE="${HOME}/.config/Code/User"
}

ln -si ${DOTFILES}/bash_logout          ~/.bash_logout
ln -si ${DOTFILES}/bashrc               ~/.bashrc
ln -si ${DOTFILES}/bazelrc              ~/.bazelrc
ln -si ${DOTFILES}/blazerc              ~/.blazerc
ln -si ${DOTFILES}/colordiffrc          ~/.colordiffrc
ln -si ${DOTFILES}/hushlogin            ~/.hushlogin
ln -si ${DOTFILES}/xsession             ~/.xsession

mkdir -p ~/.config/alacritty
ln -si ${DOTFILES}/alacritty.yml        ~/.config/alacritty/alacritty.yml

mkdir -p ~/.config/bat
ln -si ${DOTFILES}/bat-config           ~/.config/bat/config

mkdir -p ~/.config/bpython
ln -si ${DOTFILES}/bpython-config       ~/.config/bpython/config

mkdir -p ~/.config/conky
ln -si ${DOTFILES}/conky.conf           ~/.config/conky/conky.conf

mkdir -p ~/.config/emacs
ln -si ${DOTFILES}/emacs/early-init.el  ~/.config/emacs/early-init.el
ln -si ${DOTFILES}/emacs/init.el        ~/.config/emacs/init.el

mkdir -p ~/.config/fish
ln -si ${DOTFILES}/fish/conf.d          ~/.config/fish/conf.d
ln -si ${DOTFILES}/fish/completions     ~/.config/fish/completions
ln -si ${DOTFILES}/fish/functions       ~/.config/fish/functions
ln -si ${DOTFILES}/fish/config.fish     ~/.config/fish/config.fish

mkdir -p ~/.config/gdb
ln -si ${DOTFILES}/gdbearlyinit         ~/.config/gdb/gdbearlyinit
ln -si ${DOTFILES}/gdbinit              ~/.config/gdb/gdbinit

mkdir -p ~/.config/git
ln -si ${DOTFILES}/git-config           ~/.config/git/config
ln -si ${DOTFILES}/git-ignore           ~/.config/git/ignore

mkdir -p ~/.config/hammerspoon
ln -si ${DOTFILES}/init.lua             ~/.config/hammerspoon/init.lua

mkdir -p ~/.config/hg
ln -si ${DOTFILES}/hgrc                 ~/.config/hg/hgrc

mkdir -p ~/.config/i3
ln -si ${DOTFILES}/i3-config            ~/.config/i3/config

mkdir -p ~/.config/i3status
ln -si ${DOTFILES}/i3status-config      ~/.config/i3status/config

mkdir -p ~/.config/ipython/profile_default
ln -si ${DOTFILES}/ipython_config.py    ~/.config/ipython/profile_default/ipython_config.py

mkdir -p ~/.config/less
ln -si ${DOTFILES}/lesskey              ~/.config/less/lesskey

mkdir -p ~/.config/readline
ln -si ${DOTFILES}/inputrc              ~/.config/readline/inputrc

mkdir -p ~/.config/kitty
ln -si ${DOTFILES}/kitty.conf           ~/.config/kitty/kitty.conf

mkdir -p ~/.config/lf
ln -si ${DOTFILES}/lfrc                 ~/.config/lf/lfrc

mkdir -p ~/.config/moc/themes
ln -si ${DOTFILES}/moc-config           ~/.config/moc/config
ln -si ${DOTFILES}/moc-theme            ~/.config/moc/themes/serban

mkdir -p ~/.config/newsboat
ln -si ${DOTFILES}/newsboat-config      ~/.config/newsboat/config

mkdir -p ~/.config/nitrogen
ln -si ${DOTFILES}/bg-saved.cfg         ~/.config/nitrogen/bg-saved.cfg

mkdir -p ~/.config/nvim
ln -si ${DOTFILES}/vim/vimrc            ~/.config/nvim/init.vim

mkdir -p ~/.config/procs
ln -si ${DOTFILES}/procs-config.toml    ~/.config/procs/config.toml

mkdir -p ~/.config/screen
ln -si ${DOTFILES}/screenrc             ~/.config/screen/screenrc

mkdir -p ~/.config/sqlite3
ln -si ${DOTFILES}/sqliterc             ~/.config/sqlite3/sqliterc

mkdir -p ~/.config/tmux
ln -si ${DOTFILES}/tmux.conf            ~/.config/tmux/tmux.conf

mkdir -p ~/.vim
ln -si ${DOTFILES}/vim/after            ~/.vim/after
ln -si ${DOTFILES}/vim/pack             ~/.vim/pack
ln -si ${DOTFILES}/vim/ultisnips        ~/.vim/UltiSnips
ln -si ${DOTFILES}/vim/gvimrc           ~/.vim/gvimrc
ln -si ${DOTFILES}/vim/vimrc            ~/.vim/vimrc

mkdir -p -m 700 ~/.local/share
mkdir -p -m 700 ~/.local/share/bookmarks

mkdir -p -m 700 ~/.local/state
mkdir -p -m 700 ~/.local/state/bash
mkdir -p -m 700 ~/.local/state/bash/history
mkdir -p -m 700 ~/.local/state/bpython
mkdir -p -m 700 ~/.local/state/less
mkdir -p -m 700 ~/.local/state/postgresql
mkdir -p -m 700 ~/.local/state/sqlite

mkdir -p -m 700 ~/.cache
mkdir -p -m 700 ~/.cache/grip

root || darwin || freebsd && {
  ln -si ${DOTFILES}/bashrc             ~/.bash_profile
}

darwin && {
  ln -si ~/.config/gdb                  ~/Library/Preferences/gdb
}

debian && {
  mkdir -p ~/.local/bin
  ln -si /usr/bin/batcat                ~/.local/bin/bat
}

darwin && {
  mkdir -p ~/.local/bin
  ln -si  /Applications/kitty.app/Contents/MacOS/kitten                         ~/.local/bin/kitten
  ln -si  /Applications/kitty.app/Contents/MacOS/kitty                          ~/.local/bin/kitty
  ln -si  /Applications/MacVim.app/Contents/bin/mvim                            ~/.local/bin/mvim
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
  mkdir -p "${SUBLIME_TEXT}"
  ln -si "${DOTFILES}/sublime/Preferences.sublime-settings"     "${SUBLIME_TEXT}/Preferences.sublime-settings"
  ln -si "${DOTFILES}/sublime/Package Control.sublime-settings" "${SUBLIME_TEXT}/Package Control.sublime-settings"
}

darwin || linux && {
  mkdir -p "${VSCODE}"
  ln -si ${DOTFILES}/vscode/settings.json "${VSCODE}/settings.json"
}
