function r --wraps grep
  set --local binary grep

  # Use GNU grep on macOS
  if type --query ggrep
    set binary ggrep
  end

  $binary $argv \
    --no-messages \
    --line-number \
    --initial-tab \
    --ignore-case \
    --color=always
end
