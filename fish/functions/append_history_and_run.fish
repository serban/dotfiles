function append_history_and_run
  if test (string split . --fields 1 $FISH_VERSION) -lt 4
    commandline "$argv"
    commandline --function execute
  else
    history append "$argv"
    command $argv
  end
end
