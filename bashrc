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

export PAGER=less

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
export PATH="${HOME}/bin:${PRIVATE}/bin:${DOTFILES}/bin:${DOTFILES}/python:${HOME}/go/bin:${HOME}/opt/google-cloud-sdk/bin:${HOME}/homebrew/bin:/usr/local/cuda/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:${PATH}"
export LD_LIBRARY_PATH="${HOME}/homebrew/lib:${LD_LIBRARY_PATH}"

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

alias h='head'
alias t='tail'
alias l='less --ignore-case'

alias cp='cp -vi'
alias mv='mv -vi'
alias rm='rm -v'

alias cdf='colordiff -u'
alias p2='python2'
alias p3='python3'

# Default options for less
export LESS='--RAW-CONTROL-CHARS --chop-long-lines --ignore-case --no-init --quit-if-one-screen'

path() { IFS=':'; for component in ${PATH} ; do echo "${component}"; done ; }

# ------------------------------------------------------------------------------
# LS

darwin || freebsd || solaris && {
  g() {
    if [ -n "$1" ]; then
      pushd "$1" > /dev/null || return
    fi

    if [ $(which gls) ]; then
      gls -lhGFX --group-directories-first --color=always | less
    else
      ls -lhFG
    fi
  }

  a() {
    if [ -n "$1" ]; then
      pushd "$1" > /dev/null || return
    fi

    if [ $(which gls) ]; then
      gls -lhGFXA --group-directories-first --color=always | less
    else
      ls -lhFGA | more
    fi
  }

  rls() {
    if [ -n "$1" ]; then
      pushd "$1" > /dev/null || return
    fi

    if [ $(which gls) ]; then
      gls -lhGFXR --group-directories-first --color=always | less
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

    ls -lhGFX --group-directories-first --color=always | less
  }

  a() {
    if [ -n "$1" ]; then
      pushd "$1" > /dev/null || return
    fi

    ls -lhGFXA --group-directories-first --color=always | less
  }

  rls() {
    if [ -n "$1" ]; then
      pushd "$1" > /dev/null || return
    fi

    ls -lhGFXR --group-directories-first --color=always | less
  }
}

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
  alias r='grep --color=always --no-messages --line-number --ignore-case'
}

linux && {
  alias r='grep --color=always --no-messages --line-number --initial-tab --ignore-case'
}

# ------------------------------------------------------------------------------
# VIM

darwin || freebsd || linux && {
  export EDITOR=vim
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
