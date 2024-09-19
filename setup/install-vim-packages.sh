#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

print () {
  echo "==> $@"
}

print 'Creating parent directories'
mkdir -p ~/.config/vim/autoload

print 'Installing vim-plug'
curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  --output ~/.config/vim/autoload/plug.vim

print 'Installing plugins'
vim +PlugInstall +quitall

print 'Installing Go binaries'
vim +GoInstallBinaries +quitall
