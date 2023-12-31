function ws
  set --local  options (fish_opt --short=n --long=open)

  if not argparse $options -- $argv
    return
  end

  set --function date (date +%Y-%m-%d)
  set --function fold wks

  if test (uname -s) = Darwin
    set fold Workspace
  end

  set --function path ~/$fold/$date

  mkdir -p $path
  cd $path

  if test -n "$_flag_open"
    n
  end
end
