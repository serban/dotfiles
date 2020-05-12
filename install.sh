#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly DOTFILES="${HOME}/src/dotfiles"

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
  ln -si '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' ~/bin/
fi

if [[ "${OS}" = 'Darwin' ]]; then
  mkdir -p ~/Library/'Application Support'/iTerm2/Scripts/AutoLaunch
  ln -si ${DOTFILES}/iterm2/profile.py ~/Library/'Application Support'/iTerm2/Scripts/AutoLaunch/
  ln -si ${DOTFILES}/iterm2/font_12.py ~/Library/'Application Support'/iTerm2/Scripts/
  ln -si ${DOTFILES}/iterm2/font_15.py ~/Library/'Application Support'/iTerm2/Scripts/
  ln -si ${DOTFILES}/iterm2/font_18.py ~/Library/'Application Support'/iTerm2/Scripts/
  ln -si ${DOTFILES}/iterm2/font_24.py ~/Library/'Application Support'/iTerm2/Scripts/
  ln -si ${DOTFILES}/iterm2/solarized_dark.py ~/Library/'Application Support'/iTerm2/Scripts/
  ln -si ${DOTFILES}/iterm2/solarized_light.py ~/Library/'Application Support'/iTerm2/Scripts/
fi

if [[ "${OS}" = 'Darwin' ]]; then
  mkdir -p "${HOME}/Library/Application Support/Sublime Text 3/Packages/User"
  ln -si ${DOTFILES}/sublime/Preferences.sublime-settings "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/"
  ln -si "${DOTFILES}/sublime/Package Control.sublime-settings" "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/"
else
  mkdir -p ~/.config/sublime-text-3/Packages/User
  ln -si ${DOTFILES}/sublime/Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/
  ln -si "${DOTFILES}/sublime/Package Control.sublime-settings" ~/.config/sublime-text-3/Packages/User/
fi

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +quitall
vim +GoInstallBinaries +quitall
