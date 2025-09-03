function serban_preexec --on-event fish_preexec
  printf '%s%s%s%s\n' \
      \033]133\;C\007 \
      (set_color yellow) (serban_time_marker) \
      (set_color normal)
end

function serban_postexec --on-event fish_postexec
  set --local last_status $status
  set --local duration_sec (math --scale=0 $CMD_DURATION / 1000)

  set --local duration_string ''
  set --local last_status_string ''

  if test $duration_sec -gt 0
    set duration_string (printf '  (%s)' (serban_format_duration $duration_sec))
  end

  if test $last_status -ne 0
    set last_status_string (printf '  ‹%s›' $last_status)
  end

  if test $duration_sec -gt 0 || test $last_status -ne 0
    printf '%s%s%s%s%s%s\n' \
        (set_color yellow) (serban_time_marker) $duration_string \
        (set_color red) $last_status_string \
        (set_color normal)
  end

  printf '\033]133;D;%s\007' $last_status
end

function serban_dirchange --on-variable PWD
  printf '%s→ %s%s\n' \
      (set_color brgreen) (serban_working_dir) \
      (set_color normal)
end

# See `status features` for current shell's feature flag state.
set --universal fish_features \
    qmark-noglob \
    stderr-nocaret \
    ampersand-nobg-in-token \
    regex-easyesc \
    remove-percent-self \
    test-require-arg \
    #

set --global fish_color_keyword green
set --global fish_color_command yellow
set --global fish_color_option yellow
set --global fish_color_param yellow
set --global fish_color_quote yellow
set --global fish_color_operator magenta
set --global fish_color_escape brmagenta
set --global fish_color_redirection cyan
set --global fish_color_end blue
set --global fish_color_error brred
set --global fish_color_comment bryellow
set --global fish_color_autosuggestion normal
set --global fish_color_cancel brred --reverse

# https://github.com/fish-shell/fish-shell/issues/2442
# ↳ $fish_color_search_match only supports background colors
set --global fish_color_search_match --background yellow

set --global fish_pager_color_prefix magenta --underline
set --global fish_pager_color_completion normal
set --global fish_pager_color_description green

set --global fish_greeting

if test "$TERM" = xterm-kitty
  set --global fish_handle_reflow 1
end

set --prepend fish_complete_path \
    $HOME/src/dotfiles-google/fish/completions \
    $HOME/src/wip/fish/completions \
    #

set --prepend fish_function_path \
    $HOME/src/dotfiles-google/fish/functions \
    $HOME/src/wip/fish/functions \
    #

set --global --export XDG_CONFIG_HOME     $HOME/.config
set --global --export XDG_DATA_HOME       $HOME/.local/share
set --global --export XDG_STATE_HOME      $HOME/.local/state
set --global --export XDG_CACHE_HOME      $HOME/.cache

set --global --export LESSKEYIN           $HOME/.config/less/lesskey
set --global --export INPUTRC             $HOME/.config/readline/inputrc
set --global --export SCREENRC            $HOME/.config/screen/screenrc

set --global --export GNUPGHOME           $HOME/.local/share/gnupg

set --global --export LESSHISTFILE        $HOME/.local/state/less/less-history
set --global --export PSQL_HISTORY        $HOME/.local/state/postgresql/psql-history
set --global --export PYTHON_HISTORY      $HOME/.local/state/python/python-history
set --global --export SQLITE_HISTORY      $HOME/.local/state/sqlite/sqlite-history

set --global --export FLY_CONFIG_DIR      $HOME/.local/state/fly

set --global --export GRIPHOME            $HOME/.cache/grip
set --global --export MYPY_CACHE_DIR      $HOME/.cache/mypy
set --global --export PYTHONPYCACHEPREFIX $HOME/.cache/python
set --global --export RUFF_CACHE_DIR      $HOME/.cache/ruff

set --global --export CARGO_HOME          $HOME/env/cargo
set --global --export GOPATH              $HOME/env/go
set --global --export PYENV_ROOT          $HOME/env/pyenv
set --global --export RUSTUP_HOME         $HOME/env/rustup
set --global --export VIRTUALFISH_HOME    $HOME/env/virtualenv

set --global --export PYTHONPATH \
    $HOME/src/dotfiles/python/lib \
    $HOME/src/wip/python/lib \
    #

set --global --export PIP_REQUIRE_VIRTUALENV true
set --global --export PYTHONSTARTUP $HOME/src/dotfiles/pythonstartup.py

set --global --export HOMEBREW_AUTO_UPDATE_SECS 21600  # 6 hours

set --global --export JUST_COLOR always
set --global --export JUST_COMMAND_COLOR purple

set --global --export FZF_DEFAULT_COMMAND fd --type file --strip-cwd-prefix

set --global --export FZF_DEFAULT_OPTS \
    --reverse \
    --no-info \
    --no-separator \
    --height 8 \
    --scroll-off 1 \
    --header-first \
    --prompt '"⁖ "' \
    --pointer › \
    --marker ● \
    --no-bold \
    --color dark,border:13 \
    --color header:5,prompt:3,query:3 \
    --color gutter:-1,marker:2 \
    --color hl:1,hl+:1 \
    --color bg:-1,fg:12 \
    --color bg+:0,fg+:7,pointer:7 \
    #

# NB: From the `less` man page:
# Options are also taken from the environment variable "LESS". Some options like
# -k or -D require a string to follow the option letter. The string for that
# option is considered to end when a dollar sign ($) is found.
set --global --export LESS \
    --RAW-CONTROL-CHARS \
    --chop-long-lines \
    --shift 16 \
    --rscroll '|$' \
    --prompt '=%f$' \
    --mouse \
    --wheel-lines 3 \
    --ignore-case \
    --no-histdups \
    --no-init \
    --quit-if-one-screen \
    --use-color \
    --color 'Pb$' \
    --color 'Er$' \
    --color 'SKg$' \
    --line-num-width 5 \
    --jump-target 3 \
    --incsearch \
    #

test (less --version | head -n 1 | cut -d ' ' -f 2) -ge 678
and set LESS $LESS \
    --no-paste \
    #

set --global --export SHELL (command -s fish)
set --global --export VISUAL vim
set --global --export EDITOR vim
set --global --export PAGER less

umask u=rwx,g=rx,o=rx  # umask 022

if type --query dircolors
  eval (dircolors -c ~/src/dotfiles/dir_colors)
else if type --query gdircolors
  eval (gdircolors -c ~/src/dotfiles/dir_colors)
end

if test -f ~/src/wip/fish/config.fish
  source ~/src/wip/fish/config.fish
end

if test -f $HOME/.config/fish/local.fish
  source $HOME/.config/fish/local.fish
end
