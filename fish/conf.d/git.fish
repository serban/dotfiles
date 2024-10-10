abbr --add sm smerge .

abbr --add cgl clustergit --relative --hide-clean --warn-unversioned
abbr --add cgf clustergit --fetch
abbr --add cgp clustergit --pull
abbr --add cgs clustergit --exec '"git stash list"'

# The abbreviations below correspond one-to-one with the aliases in gitconfig.

abbr --add gad git add
abbr --add gau git add --update
abbr --add gbl git blame -s
abbr --add gbb git branch
abbr --add gbv git branch --verbose --verbose
abbr --add gbr git branch --verbose --verbose --remotes
abbr --add gch git checkout
abbr --add gcn git clean -d -x --dry-run
abbr --add gcl git clone
abbr --add gco git commit
abbr --add gca git commit --amend --reuse-message=HEAD
abbr --add gcb --set-cursor=° git commit --message='"°Bump @ "(date "+%Y-%m-%d %H:%M:%S")'
abbr --add gcp git cherry-pick
abbr --add gdi git diff --stat --patch
abbr --add gds git diff --stat --patch --staged
abbr --add gfe git fetch
abbr --add ggr git grep
abbr --add ggi git grep --ignore-case
abbr --add gin git init
abbr --add glo git log --decorate --stat
abbr --add gl1 git log --decorate=no --oneline
#          glf
abbr --add glg git log --decorate=no --oneline --regexp-ignore-case --grep
#          glp
abbr --add gls git ls-files
abbr --add glu git ls-files --others --exclude-standard --directory
abbr --add gpl git pull --recurse-submodules
abbr --add gps git push
abbr --add gpt git push --tags
abbr --add grb git rebase
abbr --add gre git remote
abbr --add grs git reset
abbr --add gsh git show --stat --patch
abbr --add gst git status
abbr --add gsu git submodule update --init --recursive
abbr --add gsr git submodule update --remote --rebase --recursive
abbr --add gsy git submodule summary
abbr --add gta git tag

abbr --add gsa git stash apply
abbr --add gsd git stash drop
abbr --add gsl git stash list
abbr --add gso git stash show --stat --patch
abbr --add gsp git stash pop
abbr --add gss git stash save

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

function glf
  osc52 (
      git log --oneline --no-decorate $argv \
          | fzf --no-sort \
                --track \
                --with-nth 2.. \
                --height 100% \
                --preview-window 'right,60%,<84(hidden)' \
                --preview 'git show --color --stat --patch {1}' \
                --bind 'ctrl-s:first' \
                --bind 'ctrl-g:toggle-preview' \
                --bind "ctrl-r:reload(git log --oneline --no-decorate $argv)" \
                --bind 'ctrl-o:execute-silent(smerge search commit:{1})' \
                --bind 'double-click:execute-silent(smerge search commit:{1})' \
                --bind 'enter:accept-non-empty' \
                --bind 'esc:cancel' \
          | cut -d ' ' -f 1)
end

function glp
  git log --pretty='%C(yellow)%h %C(green)%as %C(default)%s%C(magenta)%d%C(default)' $argv
end
