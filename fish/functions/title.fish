function title
  printf '\033]0;%s\007' (string join ' ' $argv)
end
