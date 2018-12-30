function fish_prompt
  set --local last_status $status
  set --local prefix ''
  set --local user $USER
  set --local host (prompt_hostname)
  set --local cwd (prompt_pwd)
  set --local suffix '$'

  if test $last_status -ne 0
    set prefix "($last_status) "
  end

  if test $user = root
    set suffix '#'
  end

  printf '🐡 %s%s%s[%s%s%s@%s%s %s%s%s]%s %s' \
      (set_color red) $prefix \
      (set_color blue) \
      (set_color green) $user \
      (set_color blue) \
      (set_color red) $host \
      (set_color normal) $cwd \
      (set_color blue) $suffix \
      (set_color normal)
end
