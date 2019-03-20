function e
  set --local  options (fish_opt --short=a --long=all)
  set options $options (fish_opt --short=r --long=read-only)
  set options $options (fish_opt --short=t --long=tabs)

  if not argparse $options -- $argv
    return
  end

  if test -z "$DISPLAY"
    set --export DISPLAY :0
  end

  set --local binary vim
  set --local args ''

  if type --quiet gvim
    set binary gvim
  else if type --quiet mvim
    set binary mvim
  end

  if test -n "$_flag_read_only"
    set args $args -R
  end

  if test -n "$_flag_tabs"
    set args $args -p
  end

  if test -n "$_flag_all"
    find . -type f -not -path '*/.git/*' -print0 \
        | sort --zero-terminated \
        | eval xargs -0 $binary $args ^ /dev/null
    return
  end

  eval $binary $args $argv ^ /dev/null
end
