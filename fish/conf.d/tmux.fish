abbr --add --global mdc tmux detach-client -s

function mlc
  tmux list-clients -F '#{client_termname}  #{session_name}' | sort
end

function mls
  tmux list-sessions -F '#{?session_attached,*, } #{session_name}'
end

function mlv
  tmux list-panes -a \
      -f '#{m/ri:vim,#{pane_current_command}}' \
      -F '#{p30:session_name}  #{p-2:window_index} #{p10:window_name}  #{p-4:pane_current_command}  #{pane_current_path}' \
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
    tmux new-window    -c /ramdisk -t $target:7 -n ramdisk
  end

  pushd $google3
  tmux new-session -A -s $session -t =$target \; set-option destroy-unattached
  popd
end

function mkg --argument-names client
  if test -z $client
    echo 'No client specified'
    return 1
  end

  tmux list-sessions -F '#{session_group} #{session_name}' \
      | grep "^$client " | cut --delimiter=' ' --fields=2 \
      | while read --line session
    tmux kill-session -t =$session
    echo "Killed session $session"
  end
end

function mcd
  tmux list-panes -a \
      -f '#{==:2,#{e|+:#{==:#{pane_current_command},fish},#{m:*/cloud/*/google3*,#{pane_current_path}}}}' \
      -F '#{pane_id}' | sort --unique \
      | while read --line pane
    tmux send-keys -t $pane C-c
    tmux send-keys -t $pane ' cd . # mcd #' Enter
    echo "Sent keys to $pane"
  end
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
