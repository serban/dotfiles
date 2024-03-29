function plc
  header Fig Clients
  echo
  hg citc --list | sed 's/^/  /g'
  echo

  header CitC Clients
  echo
  g4 listclients | grep -E -o 'citc:[^]]+' | sed 's/citc://g' | grep -v '^fig-export' | sed 's/^/  /g'
  echo

  header tmux Sessions
  echo
  mls
  echo
end

function pdi
  env P4DIFF='colordiff -u' g4 diff $argv | less
end

function pdis
  env P4DIFF='colordiff -u' g4 diff $argv | delta --features (dark)-side-by-side
end

function pdiu
  env P4DIFF='colordiff -u' g4 diff $argv | delta --features (dark)-unified-diff
end

function pre --argument-names changelist
  if test -z $changelist
    echo 'No changelist specified'
    return 1
  end

  set --local client review-$changelist

  g4d -f $client
  g4 patch -c $changelist
  g4 change --desc "Review of cl/$changelist"

  mag $client
end

function prf
  g4 pending -s fullpath \
    | grep --only-matching --extended-regexp '//depot/google3/\S+' \
    | sed 's|^//depot/google3/||' \
    | grep --invert-match BUILD
end

abbr --add sj g4d @%
abbr --add gcd 'g4d /(cat ~/src/dotfiles-google/google3-folders | fzf)'
abbr --add hcd 'g /google/src/head/depot/google3/(cat ~/src/dotfiles-google/google3-folders | fzf)'

abbr --add pbu 'g4 change --desc "g3doc bump @ "(date "+%Y-%m-%d %H:%M")'
abbr --add pdc 'g4 citc -d -f'
abbr --add pew 'e (g4 whatsout)'
abbr --add pst 'g4 pending -l; g4 nothave'
