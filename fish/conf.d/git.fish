abbr --add --global sm smerge .

abbr --add --global cgl clustergit --relative --hide-clean --warn-unversioned
abbr --add --global cgf clustergit --fetch
abbr --add --global cgp clustergit --pull
abbr --add --global cgs clustergit --exec '"git stash list"'

# The abbreviations below correspond one-to-one with the aliases in gitconfig.

abbr --add --global gad git add
abbr --add --global gau git add --update
abbr --add --global gbl git blame -s
abbr --add --global gbb git branch
abbr --add --global gbv git branch --verbose --verbose
abbr --add --global gbr git branch --verbose --verbose --remotes
abbr --add --global gch git checkout
abbr --add --global gcn git clean -d -x --dry-run
abbr --add --global gcl git clone
abbr --add --global gco git commit
abbr --add --global gca git commit --amend --reuse-message=HEAD
abbr --add --global gcb git commit --all --message='"Bump @ "(date "+%Y-%m-%d %H:%M:%S")'  # TODO: Add to gitconfig
abbr --add --global gcp git cherry-pick
abbr --add --global gdi git diff --stat --patch
abbr --add --global gds git diff --stat --patch --staged
abbr --add --global gfe git fetch
abbr --add --global ggr git grep
abbr --add --global ggi git grep --ignore-case
abbr --add --global gin git init
abbr --add --global glo git log --decorate --stat
abbr --add --global gls git ls-files
abbr --add --global glu git ls-files --others --exclude-standard --directory
abbr --add --global gpl git pull
abbr --add --global gps git push
abbr --add --global gpt git push --tags
abbr --add --global grb git rebase
abbr --add --global gre git remote
abbr --add --global grs git reset
abbr --add --global gsh git show --stat --patch
abbr --add --global gst git status
abbr --add --global gta git tag

abbr --add --global gsa git stash apply
abbr --add --global gsd git stash drop
abbr --add --global gsl git stash list
abbr --add --global gso git stash show --stat --patch
abbr --add --global gsp git stash pop
abbr --add --global gss git stash save

# dandavison/delta wrappers

function gbld
  git blame --date=iso $argv | delta
end

function gdis
  git diff --color --stat --patch $argv | delta --features (dark)-side-by-side
end

function gdiu
  git diff --color --stat --patch $argv | delta --features (dark)-unified-diff
end

function gdss
  git diff --color --stat --patch --staged $argv | delta --features (dark)-side-by-side
end

function gdsu
  git diff --color --stat --patch --staged $argv | delta --features (dark)-unified-diff
end

function gshs
  git show --color --stat --patch $argv | delta --features (dark)-side-by-side
end

function gshu
  git show --color --stat --patch $argv | delta --features (dark)-unified-diff
end

function gsos
  git stash show --color --stat --patch $argv | delta --features (dark)-side-by-side
end

function gsou
  git stash show --color --stat --patch $argv | delta --features (dark)-unified-diff
end
