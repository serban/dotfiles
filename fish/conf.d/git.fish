abbr --add sm 'smerge .'

abbr --add cgl 'clustergit --relative --hide-clean --warn-unversioned'
abbr --add cgf 'clustergit --fetch'
abbr --add cgp 'clustergit --pull'
abbr --add cgs "clustergit --exec 'git stash list'"

# The abbreviations below correspond one-to-one with the aliases in gitconfig.

abbr --add gad 'git add'
abbr --add gau 'git add --update'
abbr --add gbl 'git blame -s'
abbr --add gbb 'git branch'
abbr --add gbv 'git branch --verbose --verbose'
abbr --add gbr 'git branch --verbose --verbose --remotes'
abbr --add gch 'git checkout'
abbr --add gcn 'git clean -d -x --dry-run'
abbr --add gcl 'git clone'
abbr --add gco 'git commit'
abbr --add gca 'git commit --amend --reuse-message=HEAD'
abbr --add gcb --set-cursor=° "git commit --message='°Bump @ '(date '+%Y-%m-%d %H:%M:%S')"
abbr --add gcp 'git cherry-pick'
abbr --add gdi 'git diff --stat --patch'
abbr --add gds 'git diff --stat --patch --staged'
abbr --add gfe 'git fetch'
abbr --add ggr 'git grep'
abbr --add ggi 'git grep --ignore-case'
abbr --add gin 'git init'
abbr --add glo 'git log --decorate --stat'
abbr --add gl1 'git log --decorate=no --oneline'
#          glf
abbr --add glg 'git log --decorate=no --oneline --regexp-ignore-case --grep'
#          glp
#          glz
#          glr
#          glh
#          glt
abbr --add gls 'git ls-files'
abbr --add glu 'git ls-files --others --exclude-standard --directory'
#          gma
#          gmo
#          gmu
abbr --add gpl 'git pull --recurse-submodules'
abbr --add gps 'git push'
abbr --add gpt 'git push --tags'
abbr --add grb 'git rebase'
abbr --add gre 'git remote'
abbr --add grs 'git reset'
abbr --add grp 'git rev-parse --short'
abbr --add gsh 'git show --stat --patch'
abbr --add gst 'git status'
abbr --add gsm 'git status --untracked-files=no'
abbr --add gsu 'git submodule update --init --recursive'
abbr --add gsr 'git submodule update --remote --rebase --recursive'
abbr --add gsy 'git submodule summary'
abbr --add gta 'git tag'

abbr --add gsa 'git stash apply'
abbr --add gsd 'git stash drop'
abbr --add gsl 'git stash list'
abbr --add gso 'git stash show --stat --patch'
abbr --add gsp 'git stash pop'
abbr --add gss 'git stash save'

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
  set --function top (git rev-parse --show-toplevel) || return
  test -n "$argv" && set --function args --header "$argv"
  title 📜 (builtin path basename $top)
  osc52 (
      git log --oneline --no-decorate $argv \
          | fzf --no-sort \
                --track \
                --with-nth 2.. \
                --height 100% \
                --preview-window 'right,60%,noinfo,<84(hidden)' \
                --preview 'git show --color --stat --patch {1}' \
                --bind 'alt-c:execute(osc52 {1})' \
                --bind 'ctrl-s:first' \
                --bind 'ctrl-g:toggle-preview' \
                --bind "ctrl-r:reload(git log --oneline --no-decorate $argv)" \
                --bind 'ctrl-x:execute-silent(echo -n {1} | fish_clipboard_copy)' \
                --bind 'ctrl-o:execute-silent(smerge search commit:{1})' \
                --bind 'double-click:execute-silent(smerge search commit:{1})' \
                --bind 'enter:accept-non-empty' \
                --bind 'esc:cancel' \
                $args \
          | cut -d ' ' -f 1)
end

function glp
  git log --date=short-local \
      --pretty='%C(yellow)%h %C(green)%cd %C(default)%s%C(magenta)%d%C(default)' \
      $argv
end

function glz
  TZ=UTC git log --date=short-local \
      --pretty='%C(yellow)%h %C(green)%cd %C(default)%s%C(magenta)%d%C(default)' \
      $argv
end

function glr
  echo -e 'This is a follow-up to commits:\n'
  TZ=UTC git log --no-walk --reverse --date=short-local \
      --pretty='• %H (%cd)%n  ↳ %s' $argv
end

function glh --argument-names repo
  if not string match --quiet --entire / $repo
    echo 'Specify a GitHub repository in the format “⟨ORGANIZATION⟩/⟨PROJECT⟩”'
    return 1
  end
  TZ=UTC git log --no-walk --reverse --date=short-local \
      --pretty="• https://github.com/$repo/commit/%H%n  ↳ %cd: %s" $argv[2..-1]
end

function glt
  echo ```fish
  echo glt (git log --no-walk --reverse --pretty=%h $argv)
  echo ```
  echo
  echo '│ Commit Date │ Commit │ Commit │ ‹ Refs │ ‹ Subject │'
  echo '├'
  TZ=UTC git log --no-walk --reverse --date=format-local:'%Y-%m-%d %H:%M' \
      --decorate-refs-exclude=HEAD \
      --decorate-refs-exclude='heads/*' \
      --decorate-refs-exclude='remotes/*/HEAD' \
      --pretty='│ %cd │ %h │ %H │ %(decorate:prefix=,suffix=,pointer= → ,separator= · ) │ %s │' \
      $argv
end

function gma
  git ls-files -z --exclude-standard --modified --others | xargs --null mvim --remote-tab-silent
end

function gmo
  git ls-files -z --exclude-standard --modified | xargs --null mvim --remote-tab-silent
end

function gmu
  git ls-files -z --exclude-standard --others | xargs --null mvim --remote-tab-silent
end
