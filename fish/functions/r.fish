function r
  set --local binary grep

  # Use GNU grep on macOS
  if type --quiet ggrep
    set binary ggrep
  end

  $binary $argv \
    --no-messages \
    --line-number \
    --initial-tab \
    --ignore-case \
    --color=always
end
