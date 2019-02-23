function fish_title
  string replace --regex "^$HOME" \~ "$PWD"
end
