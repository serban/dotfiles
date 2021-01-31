#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

print () {
  echo "==> $@"
}

print 'Creating parent directories'
mkdir -p ~/.vim

print 'Installing Vundle'
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

print 'Installing plugins'
vim +PluginInstall +quitall

print 'Installing Go binaries'
vim +GoInstallBinaries +quitall
