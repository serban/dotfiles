# vim:set ts=8 sw=2 sts=2 et:

# Dump these contents into the appropriate files:
#
# Linux   :   USER - ~/.bashrc
#             ROOT - ~/.bashrc & ~/.bash_profile
# Darwin  :   USER - ~/.bashrc & ~/.bash_profile
# FreeBSD :   USER - ~/.bashrc & ~/.bash_profile

# ------------------------------------------------------------------------------
# Exit early if the shell is not interactive

if [[ $- != *i* ]] ; then
  return
fi

# ------------------------------------------------------------------------------
# GLOBALS

DOTFILES="${HOME}/src/dotfiles"
PRIVATE="${HOME}/src/private"
OS="$(uname -s)"

function darwin {
  [ "${OS}" = 'Darwin' ]
}

function freebsd {
  [ "${OS}" = 'FreeBSD' ]
}

function linux {
  [ "${OS}" = 'Linux' ]
}

function solaris {
  [ "${OS}" = 'SunOS' ]
}

function debian {
  [ -f /etc/debian_version ]
}

function gentoo {
  [ -f /etc/gentoo-release ]
}

function suse {
  [ -f /etc/SuSE-release ]
}

function root {
  [ "$(whoami)" = 'root' ]
}


# ------------------------------------------------------------------------------
# COLORS

       NOCOLOR='\[\033[00m\]'

         BLACK='\[\033[00;30m\]'
           RED='\[\033[00;31m\]'
         GREEN='\[\033[00;32m\]'
        YELLOW='\[\033[00;33m\]'
          BLUE='\[\033[00;34m\]'
       MAGENTA='\[\033[00;35m\]'
          CYAN='\[\033[00;36m\]'
         WHITE='\[\033[00;37m\]'

  BRIGHT_BLACK='\[\033[01;30m\]'
    BRIGHT_RED='\[\033[01;31m\]'
  BRIGHT_GREEN='\[\033[01;32m\]'
 BRIGHT_YELLOW='\[\033[01;33m\]'
   BRIGHT_BLUE='\[\033[01;34m\]'
BRIGHT_MAGENTA='\[\033[01;35m\]'
   BRIGHT_CYAN='\[\033[01;36m\]'
  BRIGHT_WHITE='\[\033[01;37m\]'

# For TITLE, \[ appears only in the first part and \] appears only in the second
# part. This is because the entire contents betweent the two marks won't be
# printed to the screen.
      TITLE='\[\033]0;'
 CLOSETITLE='\007\]'
     SCREEN='\[\033k'
CLOSESCREEN='\033\\\\'

# TODO(serban): Why are these different from the above?
   NOCOLOR2='\033[00m'
    YELLOW2='\033[00;33m'

# ------------------------------------------------------------------------------
# SHELL SETTINGS

# Ignore CTRL-S and CTRL-Q, which stop and start terminal output, respectively.
stty -ixon

# Make directories 700 and files 600 by default
# umask 077

# Make directories 750 and files 640 by default
# umask 027

# Make directories 755 and files 644 by default
# umask 022

shopt -s checkwinsize
shopt -s no_empty_cmd_completion

export PAGER=/usr/bin/less

# ------------------------------------------------------------------------------
# HISTORY

shopt -s cmdhist
shopt -s histappend

# Save a new history file for every session
export HISTFILE="${HOME}/.history/$(date +%Y-%m-%d-%H%M%S)"

# Save a basically infinite number of commands per session
export HISTSIZE=1000000

# Save everything read by the shell parser
unset HISTCONTROL
unset HISTIGNORE

# Do not truncate the history file
unset HISTFILESIZE

# When printing history through the bash `history` built-in, use this prefix
export HISTTIMEFORMAT='[%Y-%m-%d %H:%M:%S] '

darwin || freebsd || linux && {
  ig() { grep --color=always --no-messages --no-filename --ignore-case  "$@" "${HOME}"/.history/* | sort | uniq ; }
}

# ------------------------------------------------------------------------------
# PATH

# Prioritize Homebrew over /bin, /sbin, /usr/bin, and /usr/sbin so that
# newer tools are used instead of the outdated Mac OS X utilities. For now, PATH
# is the same on Mac OS X, FreeBSD, and GNU/Linux.
export PATH="${HOME}/bin:${PRIVATE}/bin:${DOTFILES}/bin:${HOME}/go/bin:${HOME}/opt/google-cloud-sdk/bin:/usr/local/cuda/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:${PATH}"

# ------------------------------------------------------------------------------
# ALIASES

alias s='source ~/.bashrc'
alias show='declare -f'

alias i='history'
alias j='jobs'
alias k='kill'

alias p='pushd $1 > /dev/null'
alias o='popd'
alias d='dirs -v'
alias c='dirs -c'

alias mv='mv -vi'
alias cp='cp -vi'
alias rm='rm -v'

alias l='less --ignore-case --LINE-NUMBERS --RAW-CONTROL-CHARS --chop-long-lines'
alias h='head'
alias t='tail'

alias ag='ag --pager "less --ignore-case --RAW-CONTROL-CHARS --no-init --quit-if-one-screen" --color-path "01;35" --color-line-number "00;34"'
alias agh='ag --pager "less --ignore-case --RAW-CONTROL-CHARS --no-init --quit-if-one-screen" --color-path "01;35" --color-line-number "00;34" --file-search-regex "\.h$"'
alias agc='ag --pager "less --ignore-case --RAW-CONTROL-CHARS --no-init --quit-if-one-screen" --color-path "01;35" --color-line-number "00;34" --file-search-regex "\.cc$"'
alias agt='ag --pager "less --ignore-case --RAW-CONTROL-CHARS --no-init --quit-if-one-screen" --color-path "01;35" --color-line-number "00;34" --ignore "*_test.cc"'

alias cdf='colordiff -u'
alias gcc='gcc -std=c99 -g -Wall'
alias gdb='gdb -q'
alias p2='python2'
alias p3='python3'
alias ip3='ipython3'

alias emacs='emacs -nw'

alias fa='flac --analyze --residual-text --force'
alias tags='metaflac --export-tags-to=-'

alias screencapture='avconv -f x11grab -s sxga -r 60 -i :0.0 -vcodec libx264'

alias z='ping 8.8.8.8'

alias f='find . -iname'

# Find any file with an executable bit set
alias fx='find . -type f -perm +111'

# Find any file whose permissions aren't 644
alias fn644='find . -type f -not -perm 644'

# Find any directory whose permissions aren't 755
alias fn755='find . -type d -not -perm 755'

fe() { find . -iname '*.'$1 ; }
rmds() { find . -type f -name .DS_Store -exec rm -vf '{}' \; ; }
rmswp() { find . -type f -name '.*.swp' -exec rm -vf '{}' \; ; }

path() { IFS=':'; for component in ${PATH} ; do echo "${component}"; done ; }

commas() { python3 -c "print('{:,}'.format($1))" ; }

unix_seconds() {
  python3 -c \
    "import time; print(time.strftime('%Y-%m-%d %H:%M:%S %z', time.gmtime($1)))"
}

# TODO: Preserve millisecond resolution
unix_millis() {
  python3 -c \
    "import time; print(time.strftime('%Y-%m-%d %H:%M:%S %z', time.gmtime($1/1000)))"
}

# TODO: Preserve microsecond resolution
unix_micros() {
  python3 -c \
    "import time; print(time.strftime('%Y-%m-%d %H:%M:%S %z', time.gmtime($1/1000000)))"
}

# ------------------------------------------------------------------------------
# MAC OS X ALIASES

darwin && {
  alias safesleep='sudo pmset -a hibernatemode 3; pmset -g'
  alias nosafesleep='sudo pmset -a hibernatemode 0; pmset -g'

  alias c01='pmset -g ; printf "\nStaying awake for  1 hour\n"  ; caffeinate -t  3600'
  alias c02='pmset -g ; printf "\nStaying awake for  2 hours\n" ; caffeinate -t  7200'
  alias c04='pmset -g ; printf "\nStaying awake for  4 hours\n" ; caffeinate -t 14400'
  alias c08='pmset -g ; printf "\nStaying awake for  8 hours\n" ; caffeinate -t 28800'
  alias c12='pmset -g ; printf "\nStaying awake for 12 hours\n" ; caffeinate -t 43200'

  alias lilypond='/Applications/LilyPond.app/Contents/Resources/bin/lilypond'
}

# ------------------------------------------------------------------------------
# UNIX ALIASES

linux && {
  serbankb() {
    # Swap the CTRL and CAPS keys
    setxkbmap -option ctrl:swapcaps

    # Set the keyboard repeat delay and repeat rate
    xset r rate 200 50  # in milliseconds and keystrokes/sec
  }
}

# ------------------------------------------------------------------------------
# GENTOO ALIASES

linux && {
  root && alias isomount='mount -o loop,ro -t iso9660'

  gentoo && {
    # Query installed packages
    alias qp='equery list -i'

    # List files belonging to a package
    alias qf='equery files --type'

    # Which packages own this file?
    alias qb='equery belongs'

    # List USE flags of a package
    alias qu='equery uses'

    # Query USE flag among installed pckages
    alias qh='equery hasuse -i'

    # Query packages that directly depend on this one
    alias qd='equery depends -d'

    alias checkglsa='glsa-check --list | grep \\\[N\\\]'

    root && alias psync='time emerge --sync && eix-update'
  }
}

# ------------------------------------------------------------------------------
# RAM DISK

darwin && {
  ramdisk() {
    # Inspired by https://github.com/ideamonk/Rambola/blob/master/src/helper.sh
    local blocksize

    let blocksize=2048*8192  # 8 GiB
    diskutil eraseVolume HFS+ Ramdisk $(hdiutil attach -nomount ram://$blocksize)
  }
}

linux && {
  alias ramdisk='sudo mkdir -p /ramdisk && sudo mount -t tmpfs -o size=4g tmpfs /ramdisk'
}

# ------------------------------------------------------------------------------
# GIT ALIASES

alias ga='git add'
alias gb='git branch --verbose --verbose'
alias gbr='git branch --verbose --verbose --remotes'
alias gc='git checkout'
alias gca='git clean -x -d --force'
alias gcp='git cherry-pick'
alias gd='git diff --stat --unified=5'
gdx() { git diff --stat --unified=5 "$@" | gitx ; }
alias gdc='git diff --cached --stat --unified=5'
alias gdcx='git diff --cached --stat --unified=5 | gitx'
alias ge='git blame -e'
alias gf='git fetch && git remote prune origin'
alias gh='git show'
ghx() { git show "$@" | gitx ; }
alias gl='git log --decorate --stat'  # --graph is nice but slow on Chromium
alias glf='git ls-files'
alias gm='git add --update && git commit --amend --reuse-message=HEAD'
alias gco='git commit'
alias gcom='git commit --amend'
alias gcomh='git commit --amend --reuse-message=HEAD'
alias gp='git pull && git remote prune origin'
alias gr='git rebase'
alias gs='git log --decorate --regexp-ignore-case --author=serban'
alias gt='git status'
alias gu='git push && git push --tags'
alias gz='git reset --hard'

 alias today='git log --regexp-ignore-case --author=serban --since=5am --reverse --oneline'
alias todayp='git log --regexp-ignore-case --author=serban --since=5am --reverse --pretty="* %h %B"'

 alias week='git log --regexp-ignore-case --author=serban --since="8 days ago" --reverse --oneline'
alias weekp='git log --regexp-ignore-case --author=serban --since="8 days ago" --reverse --pretty="* %h %B"'

alias gsa='git stash apply'
alias gsd='git stash drop'
alias gsh='git stash show -v'
alias gsl='git stash list'
alias gsp='git stash pop'
alias gss='git stash save'

alias gx='gitx'
alias gk="GIT_EXTERNAL_DIFF=${DOTFILES}/bin/git-external-diff git diff"

alias gspp='git stash && git pull && git remote prune origin && git stash pop'

alias git-ignore-tracked-file='git update-index --assume-unchanged'
alias git-no-ignore-tracked-file='git update-index --no-assume-unchanged'

 gg() { git grep --line-number               "$@" -- '*.h' '*.hpp' '*.c' '*.cc' '*.cpp' '*.cu' '*.go' '*.html' '*.java' '*.js' '*.m' '*.mm' '*.py' '*.rb' '*.sh' ; }
ggi() { git grep --line-number --ignore-case "$@" -- '*.h' '*.hpp' '*.c' '*.cc' '*.cpp' '*.cu' '*.go' '*.html' '*.java' '*.js' '*.m' '*.mm' '*.py' '*.rb' '*.sh' ; }

git-push-branch-to-origin-master() {
  if [ -z "$1" ]; then
    echo "No branch specified"
    return 1
  fi

  git push origin "$1":master
}

git-delete-branch-on-origin() {
  if [ -z "$1" ]; then
    echo "No branch specified"
    return 1
  fi

  git push origin :"$1"
}

gh-clone() {
  git clone --origin github "git@github.com:serban/$1.git"
}

bb-clone() {
  git clone --origin bitbucket "git@bitbucket.org:serbang/$1.git"
}

bump() {
  git commit --all --message="Bump @ $(date '+%Y-%m-%d %H:%M:%S')"
}

# ------------------------------------------------------------------------------
# SED

# find uniq file extensions in a directory: find . -type f | gsed -rn 's|.*/[^/]+\.([^/.]+)$|\1|p' | sort -u

# Source files:
#
# c
# cc
# cpp
# css
# cu
# h
# handlebars
# hpp
# html
# java
# js
# json
# less
# m
# mm
# py
# rb
# sh
# txt

darwin && {
  # TODO: Use GNU sed
  # sed is stupid and doesn't understand \t. The real tab character is in there deliberately.
  #
  # Alternate tricks:
  # tab_character=$(printf '\t')
  alias  ws="find -E . -type f -regex '.*\.(h|hpp|c|cc|cpp|cu|java|js|m|mm|py|rb|sh|handlebars|html|txt)' -print0 | xargs -0 sed -i '' 's/[[:space:]]*$//'"
  alias et2="find -E . -type f -regex '.*\.(h|hpp|c|cc|cpp|cu|java|js|m|mm|py|rb|sh|handlebars|html|txt)' -print0 | xargs -0 sed -i '' 's/	/  /g'"
  alias et4="find -E . -type f -regex '.*\.(h|hpp|c|cc|cpp|cu|java|js|m|mm|py|rb|sh|handlebars|html|txt)' -print0 | xargs -0 sed -i '' 's/	/    /g'"
  alias et8="find -E . -type f -regex '.*\.(h|hpp|c|cc|cpp|cu|java|js|m|mm|py|rb|sh|handlebars|html|txt)' -print0 | xargs -0 sed -i '' 's/	/        /g'"

  # TODO: We can be much more clever, measuring multiples of the original
  # indent size followed by [:graph:], counting the multiples, and inserting
  # multiples of the new indent size
  alias ri42="sed -i '' 's/^    /  /'"
}

# ------------------------------------------------------------------------------
# PERMISSIONS

perms() {
  # Recursively set the permissions of every file and directory in a directory
  # USAGE: perms DIR_MODE FILE_MODE DIR

  find "$3" -type d -exec chmod -v "$1" '{}' \; | grep -v retained
  find "$3" -type f -exec chmod -v "$2" '{}' \; | grep -v retained
}

# ------------------------------------------------------------------------------
# LS

darwin || freebsd || solaris && {
  g() {
    if [ -n "$1" ]; then
      pushd "$1" > /dev/null || return
    fi

    if [ $(which gls) ]; then
      gls -lhFX --group-directories-first --color=always
    else
      ls -lhFG
    fi
  }

  a() {
    if [ -n "$1" ]; then
      pushd "$1" > /dev/null || return
    fi

    if [ $(which gls) ]; then
      gls -lhFXA --group-directories-first --color=always
    else
      ls -lhFGA | more
    fi
  }

  rls() {
    if [ -n "$1" ]; then
      pushd "$1" > /dev/null || return
    fi

    if [ $(which gls) ]; then
      gls -lhFXR --group-directories-first --color=always
    else
      ls -lhFGR | more
    fi
  }
}

linux && {
  g() {
    if [ -n "$1" ]; then
      pushd "$1" > /dev/null || return
    fi

    ls -lhFX --group-directories-first --color=always | more
  }

  a() {
    if [ -n "$1" ]; then
      pushd "$1" > /dev/null || return
    fi

    ls -lhFXA --group-directories-first --color=always | more
  }

  rls() {
    if [ -n "$1" ]; then
      pushd "$1" > /dev/null || return
    fi

    ls -lhFXR --group-directories-first --color=always | more
  }
}

# ------------------------------------------------------------------------------
# TMUX

alias mls='tmux list-sessions -F "#{?session_attached,*, } #{session_name}"'
alias mlc='tmux list-clients -F "#{client_termname}  #{session_name}" | sort'

m() {
  if [ -n "$1" ]; then
    tmux new-session -A -c "${HOME}" -n Shell -s "$1"
  else
    tmux new-session -A -c "${HOME}" -n Shell -s misc
  fi
}

ma() {
  REPO="${1}"

  # This is broken on macOS: 'tr: Illegal byte sequence'
  # `head` fires off a SIGPIPE, so make sure to `set +o pipefail` in a script.
  # RANDOM_NUMBER="$(cat /dev/urandom | tr -dc '0-9' | fold -w 2 | head -n 1)"

  RANDOM_NUMBER="$(python3 -c 'import random; print(random.randint(10, 99))')"
  TARGET="${REPO//\./-}"
  SESSION="z-${TARGET}-${RANDOM_NUMBER}"

  # From the tmux man page:
  #
  # "If the session name is prefixed with an `=', only an exact match is
  # accepted (so `=mysess' will only match exactly `mysess', not `mysession')."
  #
  # This is intended behavior: https://github.com/tmux/tmux/issues/346
  if ! tmux has-session -t "=${TARGET}" ; then
    tmux new-session -d -s "${TARGET}" -c "${HOME}/src/${REPO}" -n Shell
  fi

  pushd "${HOME}/src/${REPO}" > /dev/null
  tmux new-session -A -s "${SESSION}" -t "=${TARGET}"
  tmux kill-session -t "=${SESSION}"
  popd > /dev/null
}

mc() {
  while read -r session; do
    tmux kill-session -t "=${session}"
  done < <(tmux list-sessions -F '#{session_name}' | grep '^z-')
}

serbanCompleteM() {
  COMPREPLY=($(compgen -W "$(tmux list-sessions -F '#{session_name}')" -- "${COMP_WORDS[COMP_CWORD]}"))
}

complete -F serbanCompleteM m
complete -F serbanCompleteM ma

# ------------------------------------------------------------------------------
# BOOKMARKS

b() {
  if [ -z "$1" ]; then
    bookmarks list
  else
    g "$(bookmarks get $1)"
  fi
}

serbanCompleteB() {
  COMPREPLY=($(compgen -W "$(bookmarks labels)" -- "${COMP_WORDS[COMP_CWORD]}"))
}

serbanCompleteBookmarks()
{
  local previous_word current_word commands

  previous_word="${COMP_WORDS[COMP_CWORD-1]}"
  current_word="${COMP_WORDS[COMP_CWORD]}"

  commands="add change remove rename get labels list"

  COMPREPLY=()

  case "${previous_word}" in
    change|get|remove|rename)
      COMPREPLY=( $(compgen -W "$(bookmarks labels)" -- "${current_word}") ) ; return ;;
  esac

  COMPREPLY=($(compgen -W "${commands}" -- "${current_word}"))
}

complete -F serbanCompleteB b
complete -F serbanCompleteBookmarks bookmarks

# ------------------------------------------------------------------------------
# DIRCOLORS

darwin && {
  if [ $(which gdircolors) ]; then
    eval "$(gdircolors -b ~/.dir_colors)"
  fi
}

linux && {
  eval "$(dircolors -b ~/.dir_colors)"
}

# ------------------------------------------------------------------------------
# GREP

darwin && {
  alias    r='grep --color=always --no-messages --line-number --ignore-case'
  alias todo='grep --color=always --no-messages --line-number --ignore-case --recursive "TODO(serban)"'
  rgr() {     grep --color=always --no-messages --line-number --ignore-case --recursive "$@" * ; }
  cgr() {
              grep --color=always --no-messages --line-number --ignore-case --recursive \
                --include='*.h' --include='*.hpp' \
                --include='*.c' --include='*.cc' --include='*.cpp' --include='*.cu' \
                --include='*.go' --include='*.java' --include='*.py' --include='*.sh' \
                "$@" *
  }
}

linux && {
  alias    r='grep --color=always --no-messages --line-number --initial-tab --ignore-case'
  alias todo='grep --color=always --no-messages --line-number --initial-tab --ignore-case --recursive "TODO(serban)"'
  rgr() {     grep --color=always --no-messages --line-number --initial-tab --ignore-case --recursive "$@" * ; }
  cgr() {
              grep --color=always --no-messages --line-number --initial-tab --ignore-case --recursive \
                --include='*.h' --include='*.hpp' \
                --include='*.c' --include='*.cc' --include='*.cpp' --include='*.cu' \
                --include='*.go' --include='*.java' --include='*.py' --include='*.sh' \
                "$@" *
  }
}

# ------------------------------------------------------------------------------
# VIM

darwin || freebsd || linux && {
  export EDITOR=vim
}

darwin && {
  alias e.='find . -type f -print0 | xargs -0 mvim -p'
  alias v.='find . -type f -print0 | xargs -0 mvim -p -R'

  e() {
    mvim -p "$@" 2> /dev/null
  }

  v() {
    mvim -p -R "$@" 2> /dev/null
  }
}

linux && {
  alias e.='find . -type f -print0 | xargs -0 gvim -p'
  alias v.='find . -type f -print0 | xargs -0 gvim -p -R'

  e() {
    gvim -p "$@" 2> /dev/null
  }


  v() {
    gvim -p -R "$@" 2> /dev/null
  }
}

# ------------------------------------------------------------------------------
# PS

linux && {
  alias  us='ps --format pid,command --user $(whoami)'
  alias usf='ps --format pid,command --user $(whoami) --forest'

  alias  ua='ps --format pid,euser,command -A'
  alias uaf='ps --format pid,euser,command -A --forest'

  alias ual='ps --format pid,nice,nlwp,lstart,ruser,euser,tty,stat,rss,command -A'
  alias uac='ps --format pid,nice,nlwp,lstart,ruser,euser,tty,stat,rss,command -A --sort -pcpu'
  alias uam='ps --format pid,nice,nlwp,lstart,ruser,euser,tty,stat,rss,command -A --sort -pmem'
}

# ------------------------------------------------------------------------------
# CSCOPE

alias jcs="find . -type f -name '*.java' > cscope.files && cscope -bcq"

darwin && {
  alias cs='EDITOR=mvim cscope -d'

  if [ $(which gfind) ]; then
    alias ccs="gfind . -type f -regex '.*\.\(h\|c\|cc\|cpp\|cu\)' > cscope.files && cscope -bcq"
  else
    alias ccs="find -E . -type f -regex '.*\.(h|c|cc|cpp|cu)' > cscope.files && cscope -bcq"
  fi
}

linux && {
  alias cs='EDITOR=gvim cscope -d'
  alias ccs="find . -type f -regex '.*\.\(h\|c\|cc\|cpp\|cu\)' > cscope.files && cscope -bcq"
}

# ------------------------------------------------------------------------------
# FILE MANAGER

darwin && {
  alias n='open .'
}

linux && {
  alias n='nautilus --no-desktop . > /dev/null 2>&1 &'
}

# ------------------------------------------------------------------------------
# BASH COMPLETION

darwin && {
  # Homebrew git
  if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/git-completion.bash

  # MacPorts git
  elif [ -f /opt/local/share/doc/git-core/contrib/completion/git-completion.bash ]; then
    source /opt/local/share/doc/git-core/contrib/completion/git-completion.bash

  # git-osx-installer
  elif [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
    source /usr/local/git/contrib/completion/git-completion.bash
  fi
}

if [ -f "${HOME}/opt/google-cloud-sdk/completion.bash.inc" ]; then
  source "${HOME}/opt/google-cloud-sdk/completion.bash.inc"
fi

# For non-Gentoo distributions that don't have eselect:
#
#  if [ -f /etc/profile.d/bash-completion.sh ]
#  then
#    source /etc/profile.d/bash-completion.sh
#  fi
#
#  if [ -f /etc/bash_completion.d/git ]
#  then
#    source /etc/bash_completion.d/git
#  fi

# ------------------------------------------------------------------------------
# COMMAND HOOKS

serbanStartCommandTimer() {
  serban_command_timer="${serban_command_timer:=$SECONDS}"
}

serbanStopCommandTimer() {
  serban_command_seconds="$(( $SECONDS - $serban_command_timer ))"
  unset serban_command_timer
}

serbanFormatDuration() {
  local total_num_seconds="$1"

     let num_days="$(( total_num_seconds / 86400 ))"
    let num_hours="$(( total_num_seconds % 86400 / 3600 ))"
  let num_minutes="$(( total_num_seconds % 86400 % 3600 / 60))"
  let num_seconds="$(( total_num_seconds % 86400 % 3600 % 60))"

  if (( num_days > 0 )); then
    printf '%dd %02dh %02dm %02ds' ${num_days} ${num_hours} ${num_minutes} ${num_seconds}

  elif (( num_hours > 0 )); then
    printf '%dh %02dm %02ds' ${num_hours} ${num_minutes} ${num_seconds}

  elif (( num_minutes > 0 )); then
    printf '%dm %02ds' ${num_minutes} ${num_seconds}

  elif (( num_seconds > 0 )); then
    printf '%ds' ${num_seconds}
  fi
}

serbanFormatTime() {
  printf '%(%Y-%m-%d %H:%M:%S)T'
}

# Override serbanFormatTime for OS X because it has an ancient version of bash.
darwin && {
  serbanFormatTime() {
    date '+%Y-%m-%d %H:%M:%S'
  }
}

serbanPrintTime() {
  printf "${YELLOW2}======  $(serbanFormatTime)  ======${NOCOLOR2}\n"
}

serbanPrintCommandDuration() {
  local duration="$(serbanFormatDuration ${serban_command_seconds})"
  local time="$(serbanFormatTime)"

  if [ -n "${duration}" ]; then
    echo -e "${YELLOW2}======  ${time}  ======  (${duration})${NOCOLOR2}"
  fi
}

serbanPreCommandHook() {
  # Run only once after the first command entered at the prompt by a human.
  if [ -z "$serban_run_pre_command_hook" ]; then
    return
  fi
  unset serban_run_pre_command_hook

  # Put all pre-commands below this line.
  serbanPrintTime
  serbanStartCommandTimer
}

serbanPostCommandHook() {
  # Signal to the pre-command hook that it is safe to run.
  serban_run_pre_command_hook=true

  # Run this hook only after the shell has been initialized.
  if [ -n "$serban_first_post_command_hook" ]; then
    unset serban_first_post_command_hook
    return
  fi

  # Put all post-commands below this line.
  serbanStopCommandTimer
  history -a  # Save history after every command invocation
  serbanPrintCommandDuration
}

serban_first_post_command_hook=true
trap 'serbanPreCommandHook' DEBUG
export PROMPT_COMMAND=serbanPostCommandHook

# ------------------------------------------------------------------------------
# BASH PROMPT

serbanExitStatus() {
  local code="$?"

  if [ "${code}" != 0 ]; then
    echo "(${code}) "
  fi
}

serbanGitStatus() { git diff --quiet 2> /dev/null || echo ' *' ; }
serbanGitBranch() { git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ > \1$(serbanGitStatus)/" ; }

if root; then
  export PS1="${RED}[\u@\h ${NOCOLOR}\w${RED}]\$ ${NOCOLOR}"
else
  case "$TERM" in
    linux)
      export PS1="${BRIGHT_RED}\$(serbanExitStatus)${BRIGHT_BLUE}[${BRIGHT_GREEN}\u${BRIGHT_BLUE}@${BRIGHT_RED}\h${BRIGHT_BLUE} ${NOCOLOR}\w${CYAN}\$(serbanGitBranch)${BRIGHT_BLUE}]${BLUE}\$ ${NOCOLOR}" ;;
    screen.*)
      export PS1="${SCREEN}\W${CLOSESCREEN}${TITLE}\w${CLOSETITLE}${RED}\$(serbanExitStatus)${BLUE}[${GREEN}\u${BLUE}@${RED}\h ${NOCOLOR}\w${CYAN}\$(serbanGitBranch)${BLUE}]\$ ${NOCOLOR}" ;;
    *)
                               export PS1="${TITLE}\w${CLOSETITLE}${RED}\$(serbanExitStatus)${BLUE}[${GREEN}\u${BLUE}@${RED}\h ${NOCOLOR}\w${CYAN}\$(serbanGitBranch)${BLUE}]\$ ${NOCOLOR}" ;;
  esac
fi

# ------------------------------------------------------------------------------
# GO

export GOPATH="${HOME}/go"

# ------------------------------------------------------------------------------
# PYTHON

export PIP_REQUIRE_VIRTUALENV=true

if [ -f /usr/local/bin/virtualenvwrapper_lazy.sh ]; then
  source /usr/local/bin/virtualenvwrapper_lazy.sh
fi

# ------------------------------------------------------------------------------
# SOURCE OTHER STUFF

if [ -f ${HOME}/.bashrc_local ]; then
  source ${HOME}/.bashrc_local
fi

# ------------------------------------------------------------------------------
# CLEAR GLOBALS

unset -v DOTFILES
unset -v PRIVATE
unset -v OS
unset -f darwin freebsd linux solaris debian gentoo suse root
