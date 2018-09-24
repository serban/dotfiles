#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

set -o errexit
set -o nounset
set -o pipefail

sudo apt-get install \
  bzip2 \
  clang \
  colordiff \
  colortest \
  dnsutils \
  editorconfig \
  git \
  golang \
  htop \
  hugo \
  libc++-dev \
  makepasswd \
  psmisc \
  python3 \
  silversearcher-ag \
  tmux \
  unzip \
  vim-nox

# Optionally add Debian testing to /etc/apt/sources.list and then run:
# sudo apt-get install --only-upgrade git tmux vim-nox

sudo apt-get install \
  conky \
  feh \
  fluxbox \
  graphviz \
  i3 \
  numlockx \
  rxvt-unicode \
  vim-gtk \
  virtualbox-guest-dkms \
  virtualbox-guest-utils \
  virtualbox-guest-x11 \
  xautolock
