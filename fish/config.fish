function serban_preexec --on-event fish_preexec
  printf '%s%s%s\n' \
      (set_color yellow) (serban_time_marker) \
      (set_color normal)
end

function serban_postexec --on-event fish_postexec
  set --local last_status $status
  set --local duration_sec (math --scale=0 $CMD_DURATION / 1000)

  set --local duration_string ''
  set --local last_status_string ''

  if test $duration_sec -gt 0
    set duration_string (printf '  [%s]' (serban_format_duration $duration_sec))
  end

  if test $last_status -ne 0
    set last_status_string (printf '  (%s)' $last_status)
  end

  if test $duration_sec -gt 0 || test $last_status -ne 0
    printf '%s%s%s%s%s%s\n' \
        (set_color yellow) (serban_time_marker) $duration_string \
        (set_color red) $last_status_string \
        (set_color normal)
  end
end

set --global fish_color_command yellow
set --global fish_color_quote yellow
set --global fish_color_redirection cyan
set --global fish_color_end cyan
set --global fish_color_error brred
set --global fish_color_param yellow
set --global fish_color_comment normal
set --global fish_color_match blue
set --global fish_color_operator magenta
set --global fish_color_escape brmagenta
set --global fish_color_autosuggestion normal

set --global fish_greeting

set --global --export PATH \
    $HOME/bin \
    $HOME/src/private/bin \
    $HOME/src/dotfiles/bin \
    $HOME/go/bin \
    $HOME/opt/google-cloud-sdk/bin \
    $HOME/homebrew/bin \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/bin \
    /usr/sbin \
    /bin \
    /sbin

set --global --export LD_LIBRARY_PATH \
    $HOME/homebrew/lib \
    $LD_LIBRARY_PATH

set --global --export LESS \
    --RAW-CONTROL-CHARS \
    --chop-long-lines \
    --ignore-case \
    --no-init \
    --quit-if-one-screen

set --global --export SHELL (command -s fish)
set --global --export VISUAL vim
set --global --export EDITOR vim
set --global --export PAGER less

set --global --export VIRTUAL_ENV_DISABLE_PROMPT true

if python -m virtualfish > /dev/null 2>&1
  eval (python -m virtualfish auto_activation)
end

abbr --add --global h head
abbr --add --global t tail
abbr --add --global l less -N

abbr --add --global d colordiff -u

abbr --add --global i history

abbr --add --global cp cp -vi
abbr --add --global mv mv -vi
abbr --add --global rm rm -v

abbr --add --global p2 python2
abbr --add --global p3 python3

abbr --add --global kb xset r rate 200 50  # in milliseconds and keystrokes/sec

if test -f $HOME/.config/fish/local.fish
  source $HOME/.config/fish/local.fish
end
