function a --wraps eza
  eza \
      --color always            \
      --classify always         \
      --no-quotes               \
      --git-ignore              \
      --group-directories-first \
      --sort extension          \
      --long                    \
      --binary                  \
      --time-style +%Y-%m-%d    \
      --no-permissions          \
      --no-user                 \
      --tree                    \
      $argv                     \
    | less
end
