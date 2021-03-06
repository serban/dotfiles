abbr --add --global mdc tmux detach-client -s

function mlc
  tmux list-clients -F '#{client_termname}  #{session_name}' | sort
end

function mls
  tmux list-sessions -F '#{?session_attached,*, } #{session_name}'
end

function mlv
  set --local session_pad 0
  set --local window_pad 0

  tmux list-panes -a \
      -f '#{m/ri:vim,#{pane_current_command}}' \
      -F '#{session_name} #{window_name}' \
      | grep --invert-match '^z-' \
      | while read --line line
    set --local token (string split ' ' $line)
    set --local session_len (string length $token[1])
    set --local window_len (string length $token[2])

    if test $session_len -gt $session_pad
      set session_pad $session_len
    end

    if test $window_len -gt $window_pad
      set window_pad $window_len
    end
  end

  tmux list-panes -a \
      -f '#{m/ri:vim,#{pane_current_command}}' \
      -F "#{p$session_pad:session_name}  #{p-2:window_index} #{p$window_pad:window_name}  #{pane_current_path}" \
      | grep --invert-match '^z-'
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

function mas --argument-names project
  if test -z $project
    echo 'No project specified'
    return 1
  end

  set --local random_number (random 10 99)
  set --local target (string replace --all . - $project)
  set --local session z-$target-$random_number
  set --local repo $HOME/src/$project

  if ! test -d $repo
    echo 'Repo does not exist'
    return 1
  end

  # From the tmux man page:
  #
  # "If the session name is prefixed with an `=', only an exact match is
  # accepted (so `=mysess' will only match exactly `mysess', not `mysession')."
  #
  # This is intended behavior: https://github.com/tmux/tmux/issues/346
  if not tmux has-session -t =$target
    tmux new-session -c $repo -s $target   -n git -d
    tmux new-window  -c $repo -t $target:2 -n vim
    tmux new-window  -c $repo -t $target:3 -n build
    tmux new-window  -c $repo -t $target:4 -n ag
    tmux new-window  -c $HOME -t $target:5 -n home
  end

  pushd $repo
  tmux new-session -A -s $session -t =$target \; set-option destroy-unattached
  popd
end

function mag --argument-names client
  if test -z $client
    echo 'No client specified'
    return 1
  end

  if test -d $HOME/src/$client
    echo 'Client name conflicts with project in ~/src'
    return 1
  end

  set --local random_number (random 10 99)
  set --local target $client
  set --local session z-$client-$random_number
  set --local google3 /google/src/cloud/serban/$client/google3

  g4 citc $client || true  # Ignore failure if client already exists
  if not tmux has-session -t =$target
    if test -e /google/src/cloud/serban/$client/.citc/annotations/fig.enabled
      tmux new-session -c $google3 -s $target   -n hg -d
    else
      tmux new-session -c $google3 -s $target   -n g4 -d
    end
    tmux new-window    -c $google3 -t $target:2 -n vim
    tmux new-window    -c $google3 -t $target:3 -n blaze
    tmux new-window    -c $google3 -t $target:4 -n ag
    tmux new-window    -c $google3 -t $target:5 -n presubmit
    tmux new-window    -c $HOME    -t $target:6 -n home
  end

  pushd $google3
  tmux new-session -A -s $session -t =$target \; set-option destroy-unattached
  popd
end

function mkg --argument-names group
  if test -z $group
    echo 'No session group specified'
    return 1
  end

  tmux list-sessions \
      -f "#{==:#{session_group},$group}" \
      -F '#{session_name}' \
      | while read --line session
    tmux kill-session -t =$session
    echo "Killed session $session"
  end
end

function mcd
  tmux list-panes -a \
      -f '#{==:2,#{e|+:#{==:#{pane_current_command},fish},#{m:*/cloud/*/google3*,#{pane_current_path}}}}' \
      -F '#{s/%//:pane_id}' | sort --unique --numeric-sort \
      | while read --line line
    set --local pane %$line
    set --local pid (tmux list-panes -t $pane -f "#{==:#{pane_id},$pane}" -F '#{pane_pid}')
    set --local pids (descendants $pid)
    set --local skip 0
    set --local mark ✓

    for p in $pids
      readlink /proc/$p/exe | grep --quiet vim
      and set skip 1
      and set mark ✗
    end

    tmux list-panes -t $pane \
        -f "#{==:#{pane_id},$pane}" \
        -F "$mark  #{p-4:pane_id}  #{p-7:pane_pid}  #{p30:session_name}  #{p-2:window_index} #{p10:window_name}"

    if test $skip -eq 1
      continue
    end

    tmux send-keys -t $pane C-c
    tmux send-keys -t $pane ' cd . # mcd #' Enter
  end
end

function mfs
  set --global --export SSH_AUTH_SOCK \
      (string replace --regex '^SSH_AUTH_SOCK=' '' \
          (tmux show-environment SSH_AUTH_SOCK))
end

function serban_complete_mas
  for dir in (find $HOME/src -mindepth 1 -maxdepth 1 -type d)
    echo (string split / $dir)[-1]
  end
end

complete \
  --command mat \
  --no-files \
  --arguments '(tmux list-sessions -F "#{session_name}")'

complete \
  --command mas \
  --no-files \
  --arguments '(serban_complete_mas)'

complete \
  --command mag \
  --no-files \
  --arguments \
      '(tmux list-sessions -F "#{session_name}" | grep --invert-match "^z-")'

complete \
  --command mkg \
  --no-files \
  --arguments \
      '(tmux list-sessions -F "#{session_name}" | grep --invert-match "^z-")'
