# The expected response for OSC 11 is either one of:
#
# → b'\x1b]11;rgb:0000/2b2b/3636\x07' (24)
# → b'\x1b]11;rgb:0000/2b2b/3636\x1b\\' (25)
#
# `read` swallows the first two bytes (0x1b 0x5d):
#
# → b'11;rgb:0000/2b2b/3636\x07' (22)
# → b'11;rgb:0000/2b2b/3636\x1b\\' (23)
#
# For the terminating byte(s), `read` behaves differently based on the operating
# system and version of fish.
#
# NB: iTerm2 commit d98595cf4 adds support for the Display P3 color space, which
# changes iTerm2's response to OSC 11 when enabled. See:
#
# • https://gitlab.com/gnachman/iterm2/-/issues/9652
#   ↳ Color rendering not as vibrant as other editors
# • https://github.com/gnachman/iTerm2/commit/d98595cf42e24777ce10463b5ee206aed3cbaff4
#   ↳ 2021-12-15: Add support for the P3 colorspace. This will cause minor
#     breakages because colors in control sequences are now in P3 when enabled.
#
# │ ‹ Theme         │   Hex  │   XParseColor RGB  │
# ├─────────────────┼────────┼────────────────────┤
# │ Solarized Dark  │ 002b36 │ rgb:0000/2b2b/3636 │
# │ Solarized Light │ fdf6e3 │ rgb:fdfd/f6f6/e3e3 │
function dark
  if type --query termtheme
    termtheme --force
    return
  end

  set --function dark  rgb:0000/2b2b/3636
  set --function light rgb:fdfd/f6f6/e3e3 rgb:ffff/ffff/ffff

  set --function len 21
  set --function start 4

  if test (string split . --fields 1 $FISH_VERSION) -lt 4
    test "$TERM" = tmux-256color && set len 22 || set len 23
    set start 5
  end

  read --function response --silent --nchars $len --prompt-str \033]11\;\?\007
  set --function background (string sub --start $start --length 18 $response)

  if contains $background $light
    echo light
    return
  end

  echo dark
  contains $background $dark
end
