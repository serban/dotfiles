function fish_prompt
  set --global __fish_git_prompt_showdirtystate true

  set --local user $USER
  set --local host (prompt_hostname)
  set --local cwd (prompt_pwd)
  set --local git_status (__fish_git_prompt ' > %s')
  set --local virtual_env ''
  set --local suffix '$'

  if test -n "$VIRTUAL_ENV"
    set virtual_env (printf ' ^ %s' (string split / $VIRTUAL_ENV)[-1])
  end

  if test $user = root
    set suffix '#'
  end

  # 🐟 🐠 🐡
  printf '%s[%s%s%s@%s%s %s%s%s%s%s%s%s]%s %s><>%s ' \
      (set_color blue) \
      (set_color green) $user \
      (set_color blue) \
      (set_color red) $host \
      (set_color normal) $cwd \
      (set_color cyan) "$git_status" \
      (set_color brmagenta) "$virtual_env" \
      (set_color blue) $suffix \
      (set_color yellow) \
      (set_color normal)
end
