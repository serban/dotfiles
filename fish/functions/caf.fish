function caf --argument-names duration_hours
  if test -z "$duration_hours"
    echo 'You must specify a duration in hours'
    return 1
  end

  set --local duration_seconds (math 60 \* 60 \* $duration_hours)

  pmset -g

  echo
  echo "Staying awake for $duration_hours hours"
  
  caffeinate -t $duration_seconds
end