function ws
  set --local  options (fish_opt --short=n --long=open)

  if not argparse $options -- $argv
    return 1
  end

  set --function path ~/wks/(date +%Y-%m-%d)

  mkdir -p $path
  cd $path

  if test -n "$_flag_open"
    n
  end
end
