function g
  set --local  options (fish_opt --short=a --long=all)
  set options $options (fish_opt --short=r --long=recursive)
  set options $options (fish_opt --short=s --long=size)
  set options $options (fish_opt --short=t --long=time)

  if not argparse --exclusive size,time $options -- $argv
    return
  end

  set --local path $argv[1]

  set --local binary ls
  set --local args \
      --format=long \
      --no-group \
      --group-directories-first \
      --human-readable \
      --classify \
      --color=always

  if test -n "$_flag_all"
    set args $args --almost-all
  end

  if test -n "$_flag_recursive"
    set args $args --recursive
  end

  if test -n "$_flag_size"
    set args $args --sort=size
  else if test -n "$_flag_time"
    set args $args --sort=time
  else
    set args $args --sort=extension
  end

  if test -n "$path"
    if not cd $path
      return
    end
  end

  # Use GNU ls on macOS
  if type --quiet gls
    set binary gls
  end

  $binary $args \
      | less \
          --RAW-CONTROL-CHARS \
          --chop-long-lines \
          --ignore-case \
          --no-init \
          --quit-if-one-screen
end
