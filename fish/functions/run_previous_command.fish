function run_previous_command
  if commandline --current-buffer | string length --quiet
    return
  end

  set --function last (history --max 1 --show-time='%s ' | cut -d ' ' -f 1)
  if test (math abs (date +%s) - $last) -gt 90
    printf '\n%sToo slow!%s\n' (set_color brcyan) (set_color normal)
    commandline --function repaint
    return
  end

  commandline --function history-search-backward
  commandline --function execute
end
