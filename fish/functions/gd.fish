function gd
  set --local diff ( \
      gmailctl diff \
      | grep --invert-match --extended-regexp '^(@|---|\+\+\+)' \
      | string collect)
  echo -n "$diff" | bat --plain --language diff
  test -n "$diff" && confirm 'Apply?' && gmailctl apply --yes
end
