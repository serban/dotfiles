#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly DOTFILES="${HOME}/src/dotfiles"

ln -si ${DOTFILES}/bash_logout        ~/.bash_logout
ln -si ${DOTFILES}/bashrc             ~/.bashrc
ln -si ${DOTFILES}/colordiffrc        ~/.colordiffrc
ln -si ${DOTFILES}/conkyrc            ~/.conkyrc
ln -si ${DOTFILES}/dir_colors         ~/.dir_colors
ln -si ${DOTFILES}/en.utf-8.add       ~/.en.utf-8.add
ln -si ${DOTFILES}/gdbinit            ~/.gdbinit
ln -si ${DOTFILES}/gitconfig          ~/.gitconfig
ln -si ${DOTFILES}/gitignore          ~/.gitignore
ln -si ${DOTFILES}/gvimrc             ~/.gvimrc
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

# Silence the message of the day and last login info
touch ~/.hushlogin

OS="$(uname -s)"

if [[ "$(whoami)" = 'root' ]] || \
   [[ "${OS}" = 'Darwin' ]] || \
   [[ "${OS}" = 'FreeBSD' ]]; then
  ln -si ${DOTFILES}/bashrc ~/.bash_profile
fi

if [[ "${OS}" = 'Darwin' ]]; then
  mkdir -p ~/bin
  ln -si  /Applications/LilyPond.app/Contents/Resources/bin/lilypond ~/bin/
  ln -si '/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge' ~/bin/
fi

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +quitall
