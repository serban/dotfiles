function gd
  set --local diff (gmailctl diff | grep --invert-match '^@' | string collect)
  echo -n "$diff" | bat --plain --language diff
  test -n "$diff" && confirm 'Apply?' && gmailctl apply --yes
end
