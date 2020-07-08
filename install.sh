#!/usr/bin/env bash

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

ln -si ${DOTFILES}/bash_logout        ~/.bash_logout
ln -si ${DOTFILES}/bashrc             ~/.bashrc
ln -si ${DOTFILES}/bazelrc            ~/.bazelrc
ln -si ${DOTFILES}/blazerc            ~/.blazerc
ln -si ${DOTFILES}/colordiffrc        ~/.colordiffrc
ln -si ${DOTFILES}/conkyrc            ~/.conkyrc
ln -si ${DOTFILES}/dir_colors         ~/.dir_colors
ln -si ${DOTFILES}/en.utf-8.add       ~/.en.utf-8.add
ln -si ${DOTFILES}/gdbinit            ~/.gdbinit
ln -si ${DOTFILES}/gitconfig          ~/.gitconfig
ln -si ${DOTFILES}/gitignore          ~/.gitignore
ln -si ${DOTFILES}/gvimrc             ~/.gvimrc
ln -si ${DOTFILES}/hgrc               ~/.hgrc
ln -si ${DOTFILES}/hushlogin          ~/.hushlogin
ln -si ${DOTFILES}/i3status.conf      ~/.i3status.conf
ln -si ${DOTFILES}/inputrc            ~/.inputrc
ln -si ${DOTFILES}/screenrc           ~/.screenrc
ln -si ${DOTFILES}/sqliterc           ~/.sqliterc
ln -si ${DOTFILES}/tmux.conf          ~/.tmux.conf
ln -si ${DOTFILES}/vimrc              ~/.vimrc
ln -si ${DOTFILES}/xsession           ~/.xsession
ln -si ${DOTFILES}/Xresources         ~/.Xresources

mkdir -p ~/.config/fish
ln -si ${DOTFILES}/fish/conf.d        ~/.config/fish/conf.d
ln -si ${DOTFILES}/fish/completions   ~/.config/fish/completions
ln -si ${DOTFILES}/fish/functions     ~/.config/fish/functions
ln -si ${DOTFILES}/fish/config.fish   ~/.config/fish/config.fish

mkdir -p ~/.config/nitrogen
ln -si ${DOTFILES}/bg-saved.cfg       ~/.config/nitrogen/bg-saved.cfg

mkdir -p ~/.i3
ln -si ${DOTFILES}/i3-config          ~/.i3/config

mkdir -p ~/.moc
ln -si ${DOTFILES}/moc/config         ~/.moc/config
ln -si ${DOTFILES}/moc/themes         ~/.moc/themes

mkdir -p ~/.vim
ln -si ${DOTFILES}/ultisnips          ~/.vim/UltiSnips

# Make the bash history folder
mkdir -p -m 700 ~/.history

root || darwin || freebsd && {
  ln -si ${DOTFILES}/bashrc ~/.bash_profile
}

darwin && {
  mkdir -p ~/.hammerspoon
  ln -si ${DOTFILES}/init.lua ~/.hammerspoon/init.lua
}

darwin && {
  mkdir -p ~/bin
  ln -si  /Applications/LilyPond.app/Contents/Resources/bin/lilypond            ~/bin/
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

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +quitall
vim +GoInstallBinaries +quitall
