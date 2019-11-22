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

function pdi --argument-names file
  env P4DIFF='colordiff -u' g4 diff $file | less
end

abbr --add --global pbu 'g4 change --desc "g3doc bump @ "(date "+%Y-%m-%d %H:%M:%S")'
abbr --add --global pew 'e (g4 whatsout)'
abbr --add --global pst 'g4 pending -l; g4 nothave'
