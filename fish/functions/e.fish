function e
  set --local  options (fish_opt --short=a --long=all)
  set options $options (fish_opt --short=g --long=gui)
  set options $options (fish_opt --short=n --long=neovim)
  set options $options (fish_opt --short=r --long=read-only)
  set options $options (fish_opt --short=t --long=tabs)

  if not argparse $options -- $argv
    return
  end

  if test -z "$DISPLAY"
    set --export DISPLAY :0
  end

  set --local xargs '-o'
  set --local binary vim
  set --local args ''
  set --local stdout /dev/stdout
  set --local stderr /dev/stderr

  if test -n "$_flag_gui"
    set xargs ''
    set stdout /dev/null
    set stderr /dev/null

    if type --quiet gvim
      set binary gvim
    else if type --quiet mvim
      set binary mvim
    else
      echo 'Could not find gvim or mvim'
      return 1
    end
  end

  if test -n "$_flag_neovim"
    set binary nvim
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
        | eval xargs -0 $xargs $binary $args > $stdout 2> $stderr
    return
  end

  eval $binary $args $argv > $stdout 2> $stderr
end
