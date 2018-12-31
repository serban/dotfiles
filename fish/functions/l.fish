function l --wraps less
  less \
      --LINE-NUMBERS \
      --RAW-CONTROL-CHARS \
      --chop-long-lines \
      --ignore-case \
      --no-init \
      --quit-if-one-screen \
      $argv
end
