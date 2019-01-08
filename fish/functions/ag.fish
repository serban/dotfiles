function ag --wraps ag
  set --local options (fish_opt --short=t --long=ignore-tests)

  if not argparse $options -- $argv
    return
  end

  set --local pager \
      less \
          --RAW-CONTROL-CHARS \
          --chop-long-lines \
          --ignore-case \
          --no-init \
          --quit-if-one-screen

  set --local args \
      --pager "$pager" \
      --color-path '01;35' \
      --color-line-number '00;34'

  if test -n "$_flag_ignore_tests"
    set args $args --ignore '*_test.*'
  end

  command ag $args $argv
end
