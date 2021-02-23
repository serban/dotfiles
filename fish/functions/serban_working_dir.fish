# See https://github.com/fish-shell/fish-shell/blob/master/share/functions/prompt_pwd.fish

function serban_working_dir
  set --local home ~
  set --local pwd (string replace --regex '^'"$home"'/' '~/' $PWD)

  string replace --regex \
      '^/google/src/cloud/serban/[^/]+/google3/' \
      'google3/' \
      $pwd
end
