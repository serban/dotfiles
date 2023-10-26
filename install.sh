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
ln -si ${DOTFILES}/gdbearlyinit         ~/.gdbearlyinit
ln -si ${DOTFILES}/gdbinit              ~/.gdbinit
ln -si ${DOTFILES}/hushlogin            ~/.hushlogin
ln -si ${DOTFILES}/inputrc              ~/.inputrc
ln -si ${DOTFILES}/lesskey              ~/.lesskey
ln -si ${DOTFILES}/screenrc             ~/.screenrc
ln -si ${DOTFILES}/sqliterc             ~/.sqliterc
ln -si ${DOTFILES}/xsession             ~/.xsession
ln -si ${DOTFILES}/Xresources           ~/.Xresources

mkdir -p ~/.config/alacritty
ln -si ${DOTFILES}/alacritty.yml        ~/.config/alacritty/alacritty.yml

mkdir -p ~/.config/bat
ln -si ${DOTFILES}/bat-config           ~/.config/bat/config

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

mkdir -p ~/.config/git
ln -si ${DOTFILES}/git/config           ~/.config/git/config
ln -si ${DOTFILES}/git/ignore           ~/.config/git/ignore

mkdir -p ~/.config/hg
ln -si ${DOTFILES}/hgrc                 ~/.config/hg/hgrc

mkdir -p ~/.config/i3
ln -si ${DOTFILES}/i3-config            ~/.config/i3/config

mkdir -p ~/.config/i3status
ln -si ${DOTFILES}/i3status-config      ~/.config/i3status/config

mkdir -p ~/.config/kitty
ln -si ${DOTFILES}/kitty.conf           ~/.config/kitty/kitty.conf

mkdir -p ~/.config/lf
ln -si ${DOTFILES}/lfrc                 ~/.config/lf/lfrc

mkdir -p ~/.config/newsboat
ln -si ${DOTFILES}/newsboat-config      ~/.config/newsboat/config

mkdir -p ~/.config/nitrogen
ln -si ${DOTFILES}/bg-saved.cfg         ~/.config/nitrogen/bg-saved.cfg

mkdir -p ~/.config/nvim
ln -si ${DOTFILES}/vim/vimrc            ~/.config/nvim/init.vim

mkdir -p ~/.config/procs
ln -si ${DOTFILES}/procs.toml           ~/.config/procs/config.toml

mkdir -p ~/.config/tmux
ln -si ${DOTFILES}/tmux.conf            ~/.config/tmux/tmux.conf

mkdir -p ~/.hammerspoon
ln -si ${DOTFILES}/init.lua             ~/.hammerspoon/init.lua

mkdir -p ~/.ipython/profile_default
ln -si ${DOTFILES}/ipython_config.py    ~/.ipython/profile_default/ipython_config.py

mkdir -p ~/.moc
ln -si ${DOTFILES}/moc/config           ~/.moc/config
ln -si ${DOTFILES}/moc/themes           ~/.moc/themes

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
mkdir -p -m 700 ~/.local/state/sqlite

root || darwin || freebsd && {
  ln -si ${DOTFILES}/bashrc ~/.bash_profile
}

darwin && {
  mkdir -p ~/bin
  ln -si  /Applications/kitty.app/Contents/MacOS/kitten                         ~/bin/
  ln -si  /Applications/kitty.app/Contents/MacOS/kitty                          ~/bin/
  ln -si  /Applications/LilyPond.app/Contents/Resources/bin/lilypond            ~/bin/
  ln -si  /Applications/MacVim.app/Contents/bin/mvim                            ~/bin/
  ln -si '/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge'    ~/bin/
  ln -si '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'       ~/bin/
  ln -si '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code' ~/bin/
}

darwin && {
  mkdir -p "${ITERM}"
  ln -si ${DOTFILES}/iterm2/DynamicProfiles "${ITERM}/DynamicProfiles"
  ln -si ${DOTFILES}/iterm2/Scripts         "${ITERM}/Scripts"
}

darwin || linux && {
  mkdir -p "${SUBLIME_TEXT}"
  ln -si  ${DOTFILES}/sublime/Preferences.sublime-settings      "${SUBLIME_TEXT}/"
  ln -si "${DOTFILES}/sublime/Package Control.sublime-settings" "${SUBLIME_TEXT}/"
}

darwin || linux && {
  mkdir -p "${VSCODE}"
  ln -si ${DOTFILES}/vscode/settings.json "${VSCODE}/"
}
