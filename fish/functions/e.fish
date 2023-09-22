function e
  set --local  options (fish_opt --short=a --long=all)
  set options $options (fish_opt --short=g --long=gui)
  set options $options (fish_opt --short=n --long=neovim)
  set options $options (fish_opt --short=r --long=read-only)
  set options $options (fish_opt --short=t --long=tabs)
  set options $options (fish_opt --short=u --long=unrestricted)

  if not argparse $options -- $argv
    return
  end

  if test -z "$DISPLAY"
    set --export DISPLAY :0
  end

  set --local fdargs
  set --local xargs -o
  set --local binary vim
  set --local args
  set --local stdout /dev/stdout
  set --local stderr /dev/stderr

  if test -n "$_flag_gui"
    set xargs
    set stdout /dev/null
    set stderr /dev/null

    if type --query gvim
      set binary gvim
    else if type --query mvim
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

  if test -n "$_flag_unrestricted"
    set fdargs --unrestricted
  end

  # See the following regarding the fd option `--strip-cwd-prefix`:
  #
  # • https://github.com/sharkdp/fd/issues/760
  #   ↳ fd is vulnerable to filenames with leading dashes
  # • https://github.com/sharkdp/fd/issues/1046
  #   ↳ Ambiguity in piped vs not piped output
  # • https://github.com/sharkdp/fd/pull/1115
  #   ↳ Enable --strip-cwd-prefix by default except with -0
  #
  # TODO(serban): mlv does not pick up vim sessions started with `e --all`
  # because #{pane_current_command} shows up as “fish”
  if test -n "$_flag_all"
    for arg in $argv
      set --append fdargs --search-path $arg
    end

    fd $fdargs --type file --print0 \
        | sort --zero-terminated \
        | xargs -0 $xargs $binary $args -- > $stdout 2> $stderr
    return
  end

  $binary $args -- $argv > $stdout 2> $stderr
end
