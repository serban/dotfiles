function ws
  set --local  options (fish_opt --short=n --long=open)

  if not argparse $options -- $argv
    return 1
  end

  set --function slug $argv[1]

  if test -z $slug
    echo 'No slug specified'
    return 1
  end

  if string match --quiet --regex '[^a-z0-9-]' $slug
    echo 'Slug must contain only lowercase alphanumeric or hyphen characters'
    return 1
  end

  set --function path ~/wks/(date +%Y-%m-%d)-$slug

  mkdir -p $path
  cd $path

  if test -n "$_flag_open"
    n
  end
end
