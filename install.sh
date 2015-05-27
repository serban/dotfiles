#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

set -o errexit
set -o nounset
set -o pipefail

readonly DOTFILES="${HOME}/src/dotfiles"

ln -si ${DOTFILES}/bash_logout    ~/.bash_logout
ln -si ${DOTFILES}/bashrc         ~/.bashrc
ln -si ${DOTFILES}/colordiffrc    ~/.colordiffrc
ln -si ${DOTFILES}/conkyrc        ~/.conkyrc
ln -si ${DOTFILES}/dir_colors     ~/.dir_colors
ln -si ${DOTFILES}/gdbinit        ~/.gdbinit
ln -si ${DOTFILES}/gitconfig      ~/.gitconfig
ln -si ${DOTFILES}/gitignore      ~/.gitignore
ln -si ${DOTFILES}/gvimrc         ~/.gvimrc
ln -si ${DOTFILES}/inputrc        ~/.inputrc
ln -si ${DOTFILES}/screenrc       ~/.screenrc
ln -si ${DOTFILES}/tmux.conf      ~/.tmux.conf
ln -si ${DOTFILES}/vimrc          ~/.vimrc
ln -si ${DOTFILES}/Xresources     ~/.Xresources

mkdir -p ~/.moc
ln -si ${DOTFILES}/moc/config     ~/.moc/config
ln -si ${DOTFILES}/moc/themes     ~/.moc/themes

# Silence the message of the day and last login info
touch ~/.hushlogin

OS="$(uname -s)"

if [[ "$(whoami)" = 'root' ]] || \
   [[ "${OS}" = 'Darwin' ]] || \
   [[ "${OS}" = 'FreeBSD' ]]; then
  ln -si ${DOTFILES}/bashrc ~/.bash_profile
fi

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
