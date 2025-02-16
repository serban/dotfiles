function fish_user_key_bindings
  bind \cc                cancel-commandline
if test (string split . --fields 1 $FISH_VERSION) -ge 4
  bind alt-left           prevd-or-backward-token   # __fish_shared_key_bindings
  bind alt-right          nextd-or-forward-token    # __fish_shared_key_bindings
  bind alt-backspace      backward-kill-token       #  fish_default_key_bindings
  bind alt-delete         kill-token                #  fish_default_key_bindings
else
  bind \ef                forward-bigword
  bind \eb                backward-bigword
  bind \ed                kill-bigword
  bind \e\x7f             backward-kill-bigword
end
  bind \ec                print_working_dir
  bind \ev                cycle_ripgrep_wrapper
  bind \em                serban_fish_prompt_minimal_toggle
  bind \eg                serban_fish_prompt_version_toggle
  bind \ei                'commandline --insert ‣'
  bind \ej                'commandline --insert ·'
  bind \ey                'commandline --insert (date +%Y-%m-%d)'
  bind \ea                'fish_commandline_append " &| head -n 20"'
  bind \ez                'fish_commandline_append " &| tail -n 20"'
end
