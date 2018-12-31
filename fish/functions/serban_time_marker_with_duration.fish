function serban_time_marker_with_duration --argument-names duration_sec
  printf '%s  %s(%s)%s' \
      (serban_time_marker) \
      (set_color yellow) \
      (serban_format_duration $duration_sec) \
      (set_color normal)
end
