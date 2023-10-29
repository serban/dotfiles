#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# System Preferences > General > Show scroll bars
defaults write -g AppleShowScrollBars WhenScrolling

# System Preferences > Dock > Size
defaults write com.apple.dock tilesize -int 35

# System Preferences > Dock > Magnification
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 70

# System Preferences > Dock > Position on screen
defaults write com.apple.dock orientation left

# System Preferences > Dock > Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# System Preferences > Dock > Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool false

# Show the dock immediately when the mouse reaches the edge of the screen
defaults write com.apple.dock autohide-delay -int 0

# System Preferences > Keyboard > Key Repeat
defaults write -g KeyRepeat -int 2

# System Preferences > Keyboard > Delay Until Repeat
defaults write -g InitialKeyRepeat -int 15

# Open the accent menu when holding down a key everywhere except code surfaces
#
# See https://github.com/Microsoft/vscode/issues/31919#issuecomment-343897993
# See https://superuser.com/questions/1408110/set-applepressandholdenabled-for-one-specific-application
defaults delete -g ApplePressAndHoldEnabled || true
defaults write com.googlecode.iterm2 ApplePressAndHoldEnabled -bool false
defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false
defaults write org.vim.MacVim ApplePressAndHoldEnabled -bool false

# Set name and location of screenshots
mkdir -p $HOME/Screenshots
defaults write com.apple.screencapture location $HOME/Screenshots
defaults write com.apple.screencapture name Screenshot
defaults write com.apple.screencapture include-date -bool false
defaults write com.apple.screencapture disable-shadow -bool true

# Hammerspoon
defaults write org.hammerspoon.Hammerspoon MJConfigFile ~/.config/hammerspoon/init.lua

# Restart the Dock
killall Dock

# Clear defaults cache
killall cfprefsd
