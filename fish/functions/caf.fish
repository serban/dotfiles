function caf --argument-names duration_hours
  if test -z "$duration_hours"
    echo 'You must specify a duration in hours'
    return 1
  end

  set --local duration_seconds (math 60 \* 60 \* $duration_hours)
  set --local expiration_time_seconds (math (date +%s) + $duration_seconds)

  pmset -g

  title awake $duration_hours hours
  echo "Staying awake for $duration_hours hours until" \
      (date -r $expiration_time_seconds '+%Y-%m-%d %H:%M')

  caffeinate -t $duration_seconds
end
