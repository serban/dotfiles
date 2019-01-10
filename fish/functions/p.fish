function p
  set --local  options (fish_opt --short=a --long=all)
  set options $options (fish_opt --short=f --long=forest)

  if not argparse $options -- $argv
    return
  end

  set --local args -o pid,command

  if test -n "$_flag_all"
    set args $args -A
  else
    set args $args -u $USER
  end

  if test -n "$_flag_forest"
    set args $args --forest
  end

  ps $args $argv
end