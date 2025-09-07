#!/usr/bin/env bash

# GNU ln › What's the difference between --no-dereference and --no-target-directory?
# ↳ https://serverfault.com/questions/147787/how-to-update-a-symbolic-link-target-ln-f-s-not-working

set -o errexit
set -o nounset
set -o pipefail

readonly OS="$(uname -s)"
readonly WHOAMI="$(whoami)"

readonly DOTS0='src/dotfiles'
readonly DOTS1='../src/dotfiles'
readonly DOTS2='../../src/dotfiles'
readonly DOTS3='../../../src/dotfiles'
readonly DOTS4='../../../../src/dotfiles'
readonly DOTS5='../../../../../src/dotfiles'
readonly DOTFILES="${HOME}/src/dotfiles"

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

function debian {
  [ -f /etc/debian_version ]
}

umask u=rwx,g=,o=  # umask 077

mkdir -p -m 700 ~/.cache
mkdir -p -m 700 ~/.config
mkdir -p -m 700 ~/.local
mkdir -p -m 700 ~/.local/bin
mkdir -p -m 700 ~/.local/share
mkdir -p -m 700 ~/.local/state

chmod 700 ~/.cache
chmod 700 ~/.config
chmod 700 ~/.local
chmod 700 ~/.local/bin
chmod 700 ~/.local/share
chmod 700 ~/.local/state

mkdir -p -m 700 ~/.cache/grip

mkdir -p -m 700 ~/.local/share/bookmarks
mkdir -p -m 700 ~/.local/share/gnupg

mkdir -p -m 700 ~/.local/state/bash
mkdir -p -m 700 ~/.local/state/bash/history
mkdir -p -m 700 ~/.local/state/bpython
mkdir -p -m 700 ~/.local/state/less
mkdir -p -m 700 ~/.local/state/postgresql
mkdir -p -m 700 ~/.local/state/python
mkdir -p -m 700 ~/.local/state/sqlite
mkdir -p -m 700 ~/.local/state/vim
mkdir -p -m 700 ~/.local/state/vim/swap

root || darwin || freebsd && {
  ln -vsnf ${DOTS0}/bashrc                      ~/.bash_profile
}

ln -vsnf ${DOTS0}/bash_logout                   ~/.bash_logout
ln -vsnf ${DOTS0}/bashrc                        ~/.bashrc
ln -vsnf ${DOTS0}/bazelrc                       ~/.bazelrc
ln -vsnf ${DOTS0}/blazerc                       ~/.blazerc
ln -vsnf ${DOTS0}/hushlogin                     ~/.hushlogin

mkdir -p ~/.config/alacritty
ln -vsnf ${DOTS2}/alacritty.yml                 ~/.config/alacritty/alacritty.yml

mkdir -p ~/.config/bat
ln -vsnf ${DOTS2}/bat-config                    ~/.config/bat/config

mkdir -p ~/.config/bpython
ln -vsnf ${DOTS2}/bpython-config                ~/.config/bpython/config

mkdir -p ~/.config/colordiff
ln -vsnf ${DOTS2}/colordiffrc                   ~/.config/colordiff/colordiffrc

mkdir -p ~/.config/conky
ln -vsnf ${DOTS2}/conky.conf                    ~/.config/conky/conky.conf

mkdir -p ~/.config/dust
ln -vsnf ${DOTS2}/dust-config.toml              ~/.config/dust/config.toml

mkdir -p ~/.config/emacs
ln -vsnf ${DOTS2}/emacs/early-init.el           ~/.config/emacs/early-init.el
ln -vsnf ${DOTS2}/emacs/init.el                 ~/.config/emacs/init.el

mkdir -p ~/.config/fish
ln -vsnf ${DOTS2}/fish/conf.d                   ~/.config/fish/conf.d
ln -vsnf ${DOTS2}/fish/completions              ~/.config/fish/completions
ln -vsnf ${DOTS2}/fish/functions                ~/.config/fish/functions
ln -vsnf ${DOTS2}/fish/config.fish              ~/.config/fish/config.fish

mkdir -p ~/.config/gdb
ln -vsnf ${DOTS2}/gdbearlyinit                  ~/.config/gdb/gdbearlyinit
ln -vsnf ${DOTS2}/gdbinit                       ~/.config/gdb/gdbinit

mkdir -p ~/.config/ghostty
ln -vsnf ${DOTS2}/ghostty-config                ~/.config/ghostty/config

mkdir -p ~/.config/git
ln -vsnf ${DOTS2}/git-config                    ~/.config/git/config
ln -vsnf ${DOTS2}/git-ignore                    ~/.config/git/ignore

mkdir -p ~/.config/hammerspoon
ln -vsnf ${DOTS2}/hammerspoon/serban            ~/.config/hammerspoon/serban
ln -vsnf ${DOTS2}/hammerspoon/init.lua          ~/.config/hammerspoon/init.lua

mkdir -p ~/.config/helix
ln -vsnf ${DOTS2}/helix-config.toml             ~/.config/helix/config.toml
ln -vsnf ${DOTS2}/helix-languages.toml          ~/.config/helix/languages.toml

mkdir -p ~/.config/hg
ln -vsnf ${DOTS2}/hgrc                          ~/.config/hg/hgrc

mkdir -p ~/.config/i3
ln -vsnf ${DOTS2}/i3-config                     ~/.config/i3/config

mkdir -p ~/.config/i3status
ln -vsnf ${DOTS2}/i3status-config               ~/.config/i3status/config

mkdir -p ~/.config/ipython/profile_default
ln -vsnf ${DOTS3}/ipython_config.py             ~/.config/ipython/profile_default/ipython_config.py

mkdir -p ~/.config/less
ln -vsnf ${DOTS2}/lesskey                       ~/.config/less/lesskey

mkdir -p ~/.config/readline
ln -vsnf ${DOTS2}/inputrc                       ~/.config/readline/inputrc

mkdir -p ~/.config/kitty
ln -vsnf ${DOTS2}/kitty.conf                    ~/.config/kitty/kitty.conf
ln -vsnf ${DOTS2}/kitty-paste-actions.py        ~/.config/kitty/paste-actions.py

mkdir -p ~/.config/lf
ln -vsnf ${DOTS2}/lfrc                          ~/.config/lf/lfrc

mkdir -p ~/.config/moc/themes
ln -vsnf ${DOTS2}/moc-config                    ~/.config/moc/config
ln -vsnf ${DOTS3}/moc-theme                     ~/.config/moc/themes/serban

mkdir -p ~/.config/newsboat
ln -vsnf ${DOTS2}/newsboat-config               ~/.config/newsboat/config

mkdir -p ~/.config/nitrogen
ln -vsnf ${DOTS2}/bg-saved.cfg                  ~/.config/nitrogen/bg-saved.cfg

mkdir -p ~/.config/nvim
ln -vsnf ${DOTS2}/nvim/lua                      ~/.config/nvim/lua
ln -vsnf ${DOTS2}/nvim/init.lua                 ~/.config/nvim/init.lua

mkdir -p ~/.config/nvim-vim
ln -vsnf ${DOTS2}/vim/vimrc                     ~/.config/nvim-vim/init.vim

mkdir -p ~/.config/procs
ln -vsnf ${DOTS2}/procs-config.toml             ~/.config/procs/config.toml

mkdir -p ~/.config/screen
ln -vsnf ${DOTS2}/screenrc                      ~/.config/screen/screenrc

mkdir -p ~/.config/sqlite3
ln -vsnf ${DOTS2}/sqliterc                      ~/.config/sqlite3/sqliterc

mkdir -p ~/.config/tmux
ln -vsnf ${DOTS2}/tmux.conf                     ~/.config/tmux/tmux.conf

mkdir -p ~/.config/vim
ln -vsnf ${DOTS2}/vim/after                     ~/.config/vim/after
ln -vsnf ${DOTS2}/vim/pack                      ~/.config/vim/pack
ln -vsnf ${DOTS2}/vim/ultisnips                 ~/.config/vim/UltiSnips
ln -vsnf ${DOTS2}/vim/gvimrc                    ~/.config/vim/gvimrc
ln -vsnf ${DOTS2}/vim/vimrc                     ~/.config/vim/vimrc

mkdir -p ~/.config/wezterm
ln -vsnf ${DOTS2}/wezterm.lua                   ~/.config/wezterm/wezterm.lua

mkdir -p ~/.config/zed
ln -vsnf ${DOTS2}/zed/snippets                  ~/.config/zed/snippets
ln -vsnf ${DOTS2}/zed/keymap.json               ~/.config/zed/keymap.json
ln -vsnf ${DOTS2}/zed/settings.json             ~/.config/zed/settings.json

darwin && {
  ln -vsnf ../../.config/gdb                    ~/Library/Preferences/gdb
}

debian && {
  ln -vsnf /usr/bin/batcat                      ~/.local/bin/bat
}

darwin && {
  ln -vsnf  /Applications/kitty.app/Contents/MacOS/kitten                         ~/.local/bin/kitten
  ln -vsnf  /Applications/kitty.app/Contents/MacOS/kitty                          ~/.local/bin/kitty
  ln -vsnf  /Applications/Ghostty.app/Contents/MacOS/ghostty                      ~/.local/bin/ghostty
  ln -vsnf  /Applications/MacVim.app/Contents/bin/mvim                            ~/.local/bin/mvim
  ln -vsnf  /Applications/WezTerm.app/Contents/MacOS/wezterm                      ~/.local/bin/wezterm
  ln -vsnf  /Applications/WezTerm.app/Contents/MacOS/wezterm-gui                  ~/.local/bin/wezterm-gui
  ln -vsnf  /Applications/Zed.app/Contents/MacOS/cli                              ~/.local/bin/zed
  ln -vsnf '/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge'    ~/.local/bin/smerge
  ln -vsnf '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'       ~/.local/bin/subl
  ln -vsnf '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code' ~/.local/bin/code
}

darwin && {
  mkdir -p                                                            "${HOME}/Library/Application Support/iTerm2"
  ln -vsnf ${DOTS3}/iterm2/DynamicProfiles                            "${HOME}/Library/Application Support/iTerm2/DynamicProfiles"
  ln -vsnf ${DOTS3}/iterm2/Scripts                                    "${HOME}/Library/Application Support/iTerm2/Scripts"
}

darwin && {
  mkdir -p                                                            "${HOME}/Library/Application Support/Code/User"
  ln -vsnf ${DOTS4}/vscode/settings.json                              "${HOME}/Library/Application Support/Code/User/settings.json"
}

linux && {
  mkdir -p                                                            "${HOME}/.config/Code/User"
  ln -vsnf ${DOTS3}/vscode/settings.json                              "${HOME}/.config/Code/User/settings.json"
}

darwin && {
  mkdir -p                                                            "${HOME}/Library/Application Support/Sublime Merge/Packages/User"
  ln -vsnf "${DOTS5}/sublime-merge/Commit.sublime-menu"               "${HOME}/Library/Application Support/Sublime Merge/Packages/User/Commit.sublime-menu"
  ln -vsnf "${DOTS5}/sublime-merge/Default.sublime-keymap"            "${HOME}/Library/Application Support/Sublime Merge/Packages/User/Default.sublime-keymap"
  ln -vsnf "${DOTS5}/sublime-merge/Preferences.sublime-settings"      "${HOME}/Library/Application Support/Sublime Merge/Packages/User/Preferences.sublime-settings"
}

linux && {
  mkdir -p                                                            "${HOME}/.config/sublime_merge/Packages/User"
  ln -vsnf "${DOTS4}/sublime-merge/Commit.sublime-menu"               "${HOME}/.config/sublime_merge/Packages/User/Commit.sublime-menu"
  ln -vsnf "${DOTS4}/sublime-merge/Default.sublime-keymap"            "${HOME}/.config/sublime_merge/Packages/User/Default.sublime-keymap"
  ln -vsnf "${DOTS4}/sublime-merge/Preferences.sublime-settings"      "${HOME}/.config/sublime_merge/Packages/User/Preferences.sublime-settings"
}

darwin && {
  mkdir -p                                                            "${HOME}/Library/Application Support/Sublime Text 3/Packages/User"
  ln -vsnf "${DOTS5}/sublime/Preferences.sublime-settings"            "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
  ln -vsnf "${DOTS5}/sublime/Package Control.sublime-settings"        "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/Package Control.sublime-settings"
}

linux && {
  mkdir -p                                                            "${HOME}/.config/sublime-text-3/Packages/User"
  ln -vsnf "${DOTS4}/sublime/Preferences.sublime-settings"            "${HOME}/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
  ln -vsnf "${DOTS4}/sublime/Package Control.sublime-settings"        "${HOME}/.config/sublime-text-3/Packages/User/Package Control.sublime-settings"
}
