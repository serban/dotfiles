abbr --add --global mdc tmux detach-client -s

function mlc
  tmux list-clients -F '#{client_termname}  #{session_name}' | sort
end

function mls
  tmux list-sessions -F '#{?session_attached,*, } #{session_name}'
end

function mcl
  tmux list-sessions -F '#{?session_attached,*, } #{session_name}' \
      | grep '^  z-' | string trim | while read --line session
    tmux kill-session -t =$session
  end
end

function mat --argument-names session
  if test -z $session
    set session misc
  end

  tmux new-session -A -c $HOME -n Shell -s $session
end

function mas --argument-names repo
  if test -z $repo
    echo 'No repo specified'
    return 1
  end

  set --local random_number (random 10 99)
  set --local target (string replace --all . - $repo)
  set --local session z-$target-$random_number

  # From the tmux man page:
  #
  # "If the session name is prefixed with an `=', only an exact match is
  # accepted (so `=mysess' will only match exactly `mysess', not `mysession')."
  #
  # This is intended behavior: https://github.com/tmux/tmux/issues/346
  if not tmux has-session -t =$target
    tmux new-session -d -s $target -c $HOME/src/$repo -n Shell
  end

  pushd $HOME/src/$repo
  tmux new-session -A -s $session -t =$target
  tmux kill-session -t =$session
  popd
end

function mag --argument-names client
  if test -z $client
    echo 'No client specified'
    return 1
  end

  set --local random_number (random 10 99)
  set --local target $client
  set --local session z-$client-$random_number

  g4 citc $client || true  # Ignore failure if client already exists
  if not tmux has-session -t =$target
    tmux new-session -d -s $target \
        -c /google/src/cloud/serban/$client/google3 -n Shell
  end

  pushd /google/src/cloud/serban/$client/google3
  tmux new-session -A -s $session -t =$target
  tmux kill-session -t =$session
  popd
end

complete \
  --command mat \
  --no-files \
  --arguments '(tmux list-sessions -F "#{session_name}")'

complete \
  --command mas \
  --command mag \
  --no-files \
  --arguments \
      '(tmux list-sessions -F "#{session_name}" | grep --invert-match "^z-")'
