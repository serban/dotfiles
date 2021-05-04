function fish_prompt
  set --global __fish_git_prompt_showdirtystate true
  set --global __fish_git_prompt_showuntrackedfiles true

  set --global __fish_git_prompt_char_dirtystate ∙
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
  printf '%s%s%s%s %s%s%s%s%s %s%s ' \
      (set_color red) $host \
      (set_color brmagenta) "$virtual_env" \
      (set_color blue) $cwd \
      (set_color cyan) "$git_status" \
      (set_color yellow) $suffix \
      (set_color normal)
end
