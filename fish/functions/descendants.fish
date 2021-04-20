function descendants --argument-names pid
  if test -z "$pid"
    echo 'You must specify a PID'
    return 1
  end

  set --local pids $pid

  for child in (pgrep --parent $pid)
    set pids $pids (descendants $child)
  end

  for p in $pids
    echo $p
  end
end
