function serban_fish_prompt_minimal_toggle
  if set --query SERBAN_FISH_PROMPT_MINIMAL
    set --erase SERBAN_FISH_PROMPT_MINIMAL
  else
    set --global SERBAN_FISH_PROMPT_MINIMAL
  end
  commandline --function repaint
end
