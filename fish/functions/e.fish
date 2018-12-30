function e
  set --local  options (fish_opt --short=a --long=all)
  set options $options (fish_opt --short=r --long=read-only)

  if not argparse $options -- $argv
    return
  end

  set --local binary vim
  set --local args -p

  if test -n "$_flag_read_only"
    set args $args -R
  end

  if type --quiet gvim
    set binary gvim
  else if type --quiet mvim
    set binary mvim
  end

  if test -n "$_flag_all"
    find . -type f -not -path '*/.git/*' -print0 | xargs -0 $binary $args $argv
    return
  end

  $binary $args $argv
end
