# Usage: confirm 'Apply?' && echo → Yea || echo → Nay
function confirm --argument-names prompt
  if test -z "$prompt"
    echo 'You must specify a prompt'
    return 2
  end

  read --function response --nchars 1 --prompt-str \
      (set_color brmagenta)"■ $prompt "(set_color yellow)
  test $response = y
end
