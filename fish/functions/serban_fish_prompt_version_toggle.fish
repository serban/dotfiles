function serban_fish_prompt_version_toggle
  if set --query SERBAN_FISH_PROMPT_VERSION
    set --erase SERBAN_FISH_PROMPT_VERSION
  else
    set --global SERBAN_FISH_PROMPT_VERSION
  end
  commandline --function repaint
end
