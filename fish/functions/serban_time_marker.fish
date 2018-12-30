function serban_time_marker
  printf '%s======  %s  ======%s' \
      (set_color yellow) \
      (date '+%Y-%m-%d %H:%M:%S') \
      (set_color normal)
end
