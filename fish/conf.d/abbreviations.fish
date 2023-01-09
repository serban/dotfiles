abbr --add --global h head
abbr --add --global t tail
abbr --add --global l less -N

abbr --add --global d colordiff -u
abbr --add --global f find . -iname

abbr --add --global i " history merge && history --show-time=\e'[33m[%Y-%m-%d] '\e'[0m' --reverse"

abbr --add --global j jobs
abbr --add --global k kill
abbr --add --global v 'p | grep -i vim | awk "{print \$NF}"'

abbr --add --global s snippets

abbr --add --global cp cp -vi
abbr --add --global mv mv -vi
abbr --add --global rm rm -v

abbr --add --global pt pstree -g 3 -s

abbr --add --global p3 python3 -B
abbr --add --global p8 ping 8.8.8.8

abbr --add --global bu 'brew update && header Outdated Formulae && brew outdated'
abbr --add --global it 'python3 -B ~/src/dotfiles/iterm2/Scripts/local.py'
abbr --add --global jd jackd --driver coreaudio --rate 44100

abbr --add --global gc gcert

abbr --add --global kb xset r rate 200 50  # in milliseconds and keystrokes/sec

abbr --add --global l1 m1ddc display 30AEF261-0000-0000-311F-0104B5462778 set luminance  0
abbr --add --global l2 m1ddc display 30AEF261-0000-0000-311F-0104B5462778 set luminance 20
abbr --add --global l3 m1ddc display 30AEF261-0000-0000-311F-0104B5462778 set luminance 30

abbr --add --global dfs 'delta --features (dark)-side-by-side'
abbr --add --global dfu 'delta --features (dark)-unified-diff'

abbr --add --global sha sha256sum

# The slash in front of each name tells fd to match relative to the current
# directory. Without the slash, fd excludes any file matching the name at any
# level below the current one. For example, if run from $HOME, this excludes
# everything under ~/Music but not ~/Downloads/Music. See:
#
# * https://git-scm.com/docs/gitignore and
# * https://docs.rs/ignore/latest/ignore/struct.WalkBuilder.html
#
# Tested on 2021-12-22 with fd 8.3.0.
abbr --add --global fdh 'fd -E /Data -E /Library -E /Movies -E /Music -E /Pictures -E /go -E /oss'

abbr --add --global bleach "perl -pe 's/\e\[[0-9;]*m//g'"

# The regular expression we want to pass to perl is \\n, with two backslashes.
# If we were typing out this abbr invocation on the command line, we would need
# four backslashes to represent the original two. Here, we need *eight*
# backslashes to represent the four we want inserted in the abbreviation string.
abbr --add --global sn "perl -pe 's/\\\\\\\\n/\n/g'"

abbr --add --global rmclass find . -type f -name "'*.class'" -exec rm -vf "'{}'" \\\;
abbr --add --global rmds find . -type f -name .DS_Store -exec rm -vf "'{}'" \\\;
abbr --add --global rmpyc find . -type f -name "'*.pyc'" -exec rm -vf "'{}'" \\\;
abbr --add --global rmswp find . -type f -regex "'^.*/\\.[^/]*sw[a-z]\$'" -exec rm -vf "'{}'" \\\;

abbr --add --global wmt watchman-make --pattern "'**/BUILD'" "'**/*.h'" "'**/*.cc'" --run "'bazel test :all'"
