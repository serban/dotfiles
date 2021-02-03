#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

sudo apt-get install \
  bpython3 \
  bzip2 \
  clang \
  colordiff \
  colortest \
  dnsutils \
  editorconfig \
  fish \
  fzf \
  git \
  golang \
  hashdeep \
  hexyl \
  htop \
  httpie \
  hugo \
  jq \
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
  alsa-utils \
  conky \
  feh \
  fluxbox \
  graphviz \
  i3 \
  nitrogen \
  numlockx \
  rofi \
  rxvt-unicode \
  thunar \
  vim-gtk \
  virtualbox-guest-dkms \
  virtualbox-guest-utils \
  virtualbox-guest-x11 \
  xautolock \
  xdotool \
  xfce4-screenshooter \
  xinput
