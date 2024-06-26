function fish_user_key_bindings
  bind \ef    forward-bigword
  bind \eb    backward-bigword
  bind \ed    kill-bigword
  bind \e\x7f backward-kill-bigword
  bind \ec    print_working_dir
  bind \em    serban_fish_prompt_minimal_toggle
  bind \ei    'commandline --insert ‣'
  bind \ej    'commandline --insert ·'
  bind \ey    'commandline --insert (date +%Y-%m-%d)'
  bind \ea    'fish_commandline_append " &| head -n 20"'
  bind \ez    'fish_commandline_append " &| tail -n 20"'
end
