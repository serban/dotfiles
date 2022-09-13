function ag --wraps ag
  set --local  options (fish_opt --short=c --long=cpp)
  set options $options (fish_opt --short=h --long=html)
  set options $options (fish_opt --short=p --long=python)
  set options $options (fish_opt --short=t --long=ignore-tests)
  set options $options (fish_opt --short=v --long=variants)

  if not argparse $options -- $argv
    return
  end

  set --local args \
      --pager less \
      --color-path '01;35' \
      --color-line-number '00;34'

  if test -n "$_flag_cpp"
    set args $args --cc --cpp
  end

  if test -n "$_flag_html"
    set args $args --html
  end

  if test -n "$_flag_python"
    set args $args --python
  end

  if test -n "$_flag_ignore_tests"
    set args $args --ignore '*_test.*'
  end

  if test -n "$_flag_variants"
    if test -z $argv[1]
      echo 'No pattern specified'
      return 1
    end

    set --local tokens \
        (string split _ \
            (string replace --all ' ' _ \
                (string replace --all - _ \
                    (string lower $argv[1]))))

    set argv[1] (string join '|' \
        (string join '' $tokens) \
        (string join '-' $tokens) \
        (string join '_' $tokens) \
        (string join '\s+' $tokens))

    printf '%s⁖ %s ⁙%s\n\n' (set_color magenta) $argv[1] (set_color normal)
  end

  command ag $args $argv
end
