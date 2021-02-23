function print_working_dir
  printf '\n%s→ %s%s\n' \
      (set_color brgreen) (serban_working_dir) \
      (set_color normal)
  commandline --function repaint
end
