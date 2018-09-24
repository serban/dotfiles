#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

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
defaults write com.apple.dock autohide -bool true

# Show the dock immediately when the mouse reaches the edge of the screen
defaults write com.apple.dock autohide-delay -int 0

# System Preferences > Keyboard > Key Repeat
defaults write -g KeyRepeat -int 2

# System Preferences > Keyboard > Delay Until Repeat
defaults write -g InitialKeyRepeat -int 15

# Restart the Dock
killall Dock

# Clear defaults cache
killall cfprefsd
