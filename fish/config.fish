function serban_preexec --on-event fish_preexec
  set --global serban_command_start_time_sec (date '+%s')
  echo (serban_time_marker)
end

function serban_postexec --on-event fish_postexec
  set --local duration_sec (math (date '+%s') - $serban_command_start_time_sec)

  if test $duration_sec -gt 0
    echo (serban_time_marker_with_duration $duration_sec)
  end

  set --erase --global serban_command_start_time_sec
end
