function serban_working_dir
  string replace --regex \
      '^/google/src/cloud/serban/[^/]+/google3/' \
      'google3/' \
      (pwd)
end
