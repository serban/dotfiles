abbr --add mdc 'tmux detach-client -s'

function mrw
  if test -z $TMUX
    echo 'Not running inside tmux'
    return 1
  end

  tmux rename-window (builtin path basename $PWD)
end

function mlc
  tmux list-clients -F '#{client_termname}  #{session_name}' | sort
end

function mls
  tmux list-sessions -F '#{?session_attached,✻, } #{session_name}'
end

function mlv
  set --local options (fish_opt --short=f --long=fzf)

  if not argparse --max-args 0 $options -- $argv
    return 1
  end

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

  # TODO(serban): mlv does not pick up vim sessions started with `e --all`
  # because #{pane_current_command} shows up as “fish”
  if test -z $_flag_fzf
    tmux list-panes -a \
        -f '#{m/ri:vim,#{pane_current_command}}' \
        -F "#{p$session_pad:session_name}  #{p-2:window_index} #{p$window_pad:window_name}  #{pane_current_path}" \
        | grep --invert-match '^z-'
  else
    tmux list-panes -a \
        -f '#{==:2,#{e|+:#{m/ri:vim,#{pane_current_command}},#{m/r:^(.|([^z].*)|(z[^-].*))$,#{session_name}}}}' \
        -F " #{p-4:pane_id}  #{p$session_pad:session_name}  #{p-2:window_index} #{p$window_pad:window_name}  #{pane_current_path}"
  end
end

function mcl
  for session in (
      tmux list-sessions -F '#{?session_attached,*, } #{session_name}' \
          | grep '^  z-' \
          | string trim)
    tmux kill-session -t =$session
    echo "Killed session $session"
  end
end

function mat --argument-names group
  if test -z $group
    set group misc
  end

  set --function random_number (random 10 99)
  set --function target $group
  set --function session z-$target-$random_number

  if not tmux has-session -t =$target
    tmux new-session -c $HOME -s $target -n Shell -d
  end

  pushd $HOME
  tmux new-session -A -s $session -t =$target \; set-option destroy-unattached
  popd
end

function mas --argument-names project
  if test -z $project
    echo 'No project specified'
    return 1
  end

  set --local random_number (random 10 99)
  set --local target (string replace --all . - $project)
  set --local session z-$target-$random_number

  if test -d $HOME/src/$project
    set repo $HOME/src/$project
  else if test -d $HOME/frk/$project
    set repo $HOME/frk/$project
  else if test -d $HOME/uvd/$project
    set repo $HOME/uvd/$project
  else if test -d $HOME/oss/$project
    set repo $HOME/oss/$project
  else
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
    tmux new-session  -c $repo     -s $target   -n git -d
    tmux split-window -c $repo     -t $target:1 -v -b
    tmux split-window -c $repo     -t $target:1 -h
    tmux new-window   -c $repo     -t $target:2 -n vim
    tmux new-window   -c $repo     -t $target:3 -n run
    tmux new-window   -c $repo     -t $target:4 -n repl
    tmux new-window   -c $repo     -t $target:5 -n build
    tmux new-window   -c $repo     -t $target:6 -n grep
    tmux new-window   -c $repo     -t $target:7 -n lf
    tmux new-window   -c $HOME/wks -t $target:8 -n wks
    tmux new-window   -c $HOME     -t $target:9 -n home
    tmux send-keys                 -t $target:1.1 'git status' Enter
    tmux send-keys                 -t $target:1.3 'glf' Enter
    tmux send-keys                 -t $target:2.1 'vic' Enter
    tmux select-pane               -t $target:1.1
  end

  pushd $repo
  tmux new-session -A -s $session -t =$target \; set-option destroy-unattached
  popd
end

function mag --argument-names client subdir
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
  set --local first_window_name g4
  set --local first_window_cmd pst
  set --local vim_cmd 'cd . && mfs && pew'

  if test -n "$subdir"
    set google3 /google/src/cloud/serban/$client/google3/$subdir
  end

  g4 citc $client || true  # Ignore failure if client already exists
  if not tmux has-session -t =$target
    if test -e /google/src/cloud/serban/$client/.citc/annotations/fig.enabled
      set first_window_name hg
      set first_window_cmd hxl
      set vim_cmd 'cd . && mfs && hec'
    end
    tmux new-session -c $google3  -s $target    -n $first_window_name -d
    tmux new-window  -c $google3  -t $target:2  -n vim
    tmux new-window  -c $google3  -t $target:3  -n run
    tmux new-window  -c $google3  -t $target:4  -n blaze
    tmux new-window  -c $google3  -t $target:5  -n gcloud
    tmux new-window  -c $google3  -t $target:6  -n grep
    tmux new-window  -c $google3  -t $target:7  -n lf
    tmux new-window  -c $google3  -t $target:8  -n sub
    tmux new-window  -c $HOME/txt -t $target:9  -n msg
    tmux new-window  -c $HOME/txt -t $target:10 -n txt
    tmux new-window  -c $HOME/log -t $target:11 -n log
    tmux new-window  -c $HOME/wks -t $target:12 -n wks
    tmux new-window  -c $HOME     -t $target:13 -n home
    dots 3
    tmux send-keys                -t $target:1  $first_window_cmd Enter
    tmux send-keys                -t $target:2  $vim_cmd
  end

  pushd $google3
  tmux new-session -A -s $session -t =$target \; set-option destroy-unattached
  popd
end

function mkg
  set --local options (fish_opt --short=q --long=quiet)

  if not argparse --max-args 1 $options -- $argv
    return 1
  end

  set --local group $argv[1]

  if test -z $group
    echo 'No session group specified'
    return 1
  end

  # According to the fish documentation on command substitution, “the inner
  # command is run first and has to complete before the outer command can even
  # be started”. This behavior is important in order to avoid concurrency issues
  # calling `tmux kill-session` at the same time as `tmux list-sessions` is
  # still running. This may have happened before when the loop below was
  # constructed using `tmux list-sessions … | while read --line session` instead
  # of with `for session in (tmux list-sessions …)`.
  for session in (
      tmux list-sessions \
          -f "#{==:#{session_group},$group}" \
          -F '#{session_name}')
    tmux kill-session -t =$session
    if test -z $_flag_quiet
      echo "Killed session $session"
    end
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
    tmux send-keys -t $pane ' cd . ; mfs ; # mcd #' Enter
  end
end

function mfs
  set --global --export SSH_AUTH_SOCK \
      (string replace --regex '^SSH_AUTH_SOCK=' '' \
          (tmux show-environment SSH_AUTH_SOCK))
end

function mos --argument-names project
  if test -z $TMUX
    echo 'Not running inside tmux'
    return 1
  end

  if test -z $project
    set --function project (
        fd --base-directory ~/oss --type directory --max-depth 1 --strip-cwd-prefix \
            | sed 's|/$||' \
            | sort \
            | fzf --prompt '⁖ ~/oss/' \
                  --bind enter:accept-non-empty \
                  --bind esc:cancel)
  end

  set --function path ~/oss/$project

  if test -z $project
    echo 'No project specified'
    return 1
  end

  if not test -d $path
    echo 'Not a directory'
    return 1
  end

  tmux new-window   -c $path -n $project
  tmux split-window -c $path
  tmux send-keys    'g --no-pager' Enter
end

function mnw
  if test -z $TMUX
    echo 'Not running inside tmux'
    return 1
  end

  set --function project (
      fd --base-directory ~ --type directory --max-depth 1 . src frk uvd oss wks \
          | sed 's|/$||' \
          | sort \
          | fzf --height 100% --bind enter:accept-non-empty)

  if test -z $project
    return 1
  end

  set --function path ~/$project

  set --function panes 1
  switch (builtin path dirname $project)
    case src frk uvd oss
      set panes 4
    case wks
      set panes 2
  end

  tmux new-window -c $path -n (builtin path basename $project)
  switch $panes
    case 2
      tmux split-window -c $path
      sleep 0.25
      tmux send-keys    -t .1 'g --no-pager' Enter
    case 4
      tmux split-window -c $path -v
      tmux split-window -c $path -h
      tmux split-window -c $path -vf
      tmux select-layout -E
      sleep 0.25
      tmux send-keys    -t .1 'vic' Enter
      tmux send-keys    -t .2 'g --no-pager' Enter
      tmux send-keys    -t .3 'git status' Enter
      tmux send-keys    -t .4 'glf' Enter
      tmux select-pane  -t .3
  end
end

function serban_complete_mas
  for dir in (find $HOME/src $HOME/frk $HOME/uvd $HOME/oss -mindepth 1 -maxdepth 1 -type d 2> /dev/null)
    echo (string split / $dir)[-1]
  end
end

complete \
  --command mat \
  --no-files \
  --arguments '(tmux list-sessions -F "#{session_name}" | grep --invert-match "^z-")'

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

complete \
  --command mos \
  --no-files \
  --arguments \
      '(fd --base-directory ~/oss --type directory --max-depth 1 --strip-cwd-prefix | sed "s|/\$||")'
