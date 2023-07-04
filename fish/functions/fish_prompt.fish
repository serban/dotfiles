function fish_prompt
  set --local prompt_start  \033]133\;A\007
  set --local command_start \033]133\;B\007

  if set --query SERBAN_FISH_PROMPT_MINIMAL
    printf '%s%s%s%s %s' \
        $prompt_start \
        (set_color yellow) '$' \
        (set_color normal) \
        $command_start
    return
  end

  set --global __fish_git_prompt_showdirtystate true
  set --global __fish_git_prompt_showuntrackedfiles true

  set --global __fish_git_prompt_char_dirtystate ∙
  set --global __fish_git_prompt_char_stagedstate ∙
  set --global __fish_git_prompt_char_untrackedfiles ∘

  set --local host (prompt_hostname)
  set --local cwd (prompt_pwd)
  set --local git_status (fish_git_prompt ' › %s')
  set --local virtual_env ''
  set --local suffix '$'

  if test -n "$VIRTUAL_ENV"
    set virtual_env (printf ' %s' (string split / $VIRTUAL_ENV)[-1])
  end

  if test $USER = root
    set suffix '#'
  end

  # 🐟 🐠 🐡 ><>
  printf '%s%s%s%s%s %s%s%s%s%s %s%s %s' \
      $prompt_start \
      (set_color red) $host \
      (set_color brmagenta) "$virtual_env" \
      (set_color blue) $cwd \
      (set_color cyan) "$git_status" \
      (set_color yellow) $suffix \
      (set_color normal) \
      $command_start
end
