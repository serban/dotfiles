function serban_preexec --on-event fish_preexec
  printf '%s%s%s\n' \
      (set_color yellow) (serban_time_marker) \
      (set_color normal)
end

function serban_postexec --on-event fish_postexec
  set --local last_status $status
  set --local duration_sec (math --scale=0 $CMD_DURATION / 1000)

  set --local duration_string ''
  set --local last_status_string ''

  if test $duration_sec -gt 0
    set duration_string (printf '  [%s]' (serban_format_duration $duration_sec))
  end

  if test $last_status -ne 0
    set last_status_string (printf '  (%s)' $last_status)
  end

  if test $duration_sec -gt 0 || test $last_status -ne 0
    printf '%s%s%s%s%s%s\n' \
        (set_color yellow) (serban_time_marker) $duration_string \
        (set_color red) $last_status_string \
        (set_color normal)
  end
end

set --global --export PATH \
    $HOME/bin \
    $HOME/src/private/bin \
    $HOME/src/dotfiles/bin \
    $HOME/go/bin \
    $HOME/opt/google-cloud-sdk/bin \
    $HOME/homebrew/bin \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/bin \
    /usr/sbin \
    /bin \
    /sbin

set --global --export LD_LIBRARY_PATH \
    $HOME/homebrew/lib \
    $LD_LIBRARY_PATH

set --global VIRTUAL_ENV_DISABLE_PROMPT true

set --global fish_greeting

if status --is-interactive
  abbr --add --global h head
  abbr --add --global t tail

  abbr --add --global cp cp -vi
  abbr --add --global mv mv -vi
  abbr --add --global rm rm -v

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

  abbr --add --global hdi hg diff
  abbr --add --global hst hg status
end
