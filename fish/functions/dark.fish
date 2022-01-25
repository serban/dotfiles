# Works as of iTerm2 commit 52b36370acd987876fae3acd37edfc7379272545 from
# August 2021 which ends the response with 0x1b 0x5c (escape backslash).
# Previous versions would end the response with just 0x07 (bell),
# which would require us to read one fewer byte.
#
# For the construction of the escape codes, see:
# • https://iterm2.com/documentation-escape-codes.html
# • https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it
#
# NB: iTerm2 commit d98595cf42e24777ce10463b5ee206aed3cbaff4 adds support for
# the Display P3 color space, which changes iTerm2's response to OSC 4 when
# enabled. See https://gitlab.com/gnachman/iterm2/-/issues/9652 -
#   Color rendering not as vibrant as other editors.
function dark
  if test "$TERM" = screen-256color
    read response --silent --nchars 25 \
        --prompt-str \033Ptmux\;\033\033]4\;-2\;\?\007\033\\
  else
    read response --silent --nchars 25 --prompt-str \033]4\;-2\;\?\007
  end

  set --local background \
      (echo $response \
           | grep --color=never --only-matching --extended-regexp \
               'rgb:[[:xdigit:]]{4}/[[:xdigit:]]{4}/[[:xdigit:]]{4}')

  if test "$background" = rgb:fdfd/f6f6/e3e3  # Solarized Light
    echo light
    return
  end

  echo dark
  test "$background" = rgb:0000/2b2b/3636  # Solarized Dark
end
