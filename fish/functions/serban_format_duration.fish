function serban_format_duration --argument-names total_seconds
  if test -z "$total_seconds"
    return
  end

  set --local days    (math --scale=0 $total_seconds / 86400)
  set --local hours   (math --scale=0 $total_seconds % 86400 / 3600)
  set --local minutes (math --scale=0 $total_seconds % 86400 % 3600 / 60)
  set --local seconds (math --scale=0 $total_seconds % 86400 % 3600 % 60)

  if test $days -gt 0
    printf '%dd %02dh %02dm %02ds' $days $hours $minutes $seconds

  else if test $hours -gt 0
    printf '%dh %02dm %02ds' $hours $minutes $seconds

  else if test $minutes -gt 0
    printf '%dm %02ds' $minutes $seconds

  else if test $seconds -gt 0
    printf '%ds' $seconds
  end
end
