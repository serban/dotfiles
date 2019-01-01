function serban_preexec --on-event fish_preexec
  set --global serban_command_start_time_sec (date '+%s')
  echo (serban_time_marker)
end

function serban_postexec --on-event fish_postexec
  set --local duration_sec (math (date '+%s') - $serban_command_start_time_sec)

  if test $duration_sec -gt 0
    echo (serban_time_marker_with_duration $duration_sec)
  end

  set --erase --global serban_command_start_time_sec
end

if status --is-interactive
  abbr --add --global h head
  abbr --add --global t tail

  abbr --add --global p2 python2
  abbr --add --global p3 python3

  # These correspond one-to-one with the aliases in gitconfig.
  abbr --add --global gad git add
  abbr --add --global gau git add --update
  abbr --add --global gbl git blame
  abbr --add --global gbb git branch
  abbr --add --global gbv git branch --verbose --verbose
  abbr --add --global gbr git branch --verbose --verbose --remotes
  abbr --add --global gch git checkout
  abbr --add --global gcn git clean -d -x --dry-run
  abbr --add --global gcl git clone
  abbr --add --global gco git commit
  abbr --add --global gca git commit --amend --reuse-message=HEAD
  abbr --add --global gcp git cherry-pick
  abbr --add --global gdi git diff --stat --unified=5
  abbr --add --global gds git diff --stat --unified=5 --staged
  abbr --add --global gfe git fetch
  abbr --add --global ggr git grep
  abbr --add --global ggi git grep --ignore-case
  abbr --add --global gin git init
  abbr --add --global glo git log --decorate --stat
  abbr --add --global gls git ls-files
  abbr --add --global gpl git pull
  abbr --add --global gps git push
  abbr --add --global gpt git push --tags
  abbr --add --global grb git rebase
  abbr --add --global gre git remote
  abbr --add --global grs git reset
  abbr --add --global gsh git show
  abbr --add --global gst git status
  abbr --add --global gta git tag

  # These correspond one-to-one with the aliases in gitconfig.
  abbr --add --global gsa git stash apply
  abbr --add --global gsd git stash drop
  abbr --add --global gsl git stash list
  abbr --add --global gso git stash show -v
  abbr --add --global gsp git stash pop
  abbr --add --global gss git stash save
end
