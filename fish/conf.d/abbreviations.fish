abbr --add h head
abbr --add t tail
abbr --add l less -N

abbr --add d colordiff -u
abbr --add f find . -iname
abbr --add 3 --set-cursor=° 'tree -C °| less'

abbr --add i " history merge && history --show-time=\e'[33m[%Y-%m-%d] '\e'[0m' --reverse"

abbr --add j jobs
abbr --add k kill
abbr --add v 'p | grep -i vim | awk "{print \$NF}"'

abbr --add s snippets

abbr --add cp cp -vi
abbr --add mv mv -vi
abbr --add rm rm -v

abbr --add lc wc -l

abbr --add pt pstree -g 3 -s

abbr --add p3 python3 -B
abbr --add p8 ping 8.8.8.8

abbr --add au 'sudo apt update && apt list --upgradable'
abbr --add bu 'brew update && header Outdated Formulae && brew outdated'
abbr --add it 'python3 -B ~/src/dotfiles/iterm2/Scripts/local.py'
abbr --add jd jackd --driver coreaudio --rate 44100

abbr --add gc gcert

abbr --add kb xset r rate 200 50  # in milliseconds and keystrokes/sec

abbr --add l1 m1ddc display 30AEF261-0000-0000-311F-0104B5462778 set luminance  0
abbr --add l2 m1ddc display 30AEF261-0000-0000-311F-0104B5462778 set luminance 20
abbr --add l3 m1ddc display 30AEF261-0000-0000-311F-0104B5462778 set luminance 30

abbr --add ago "ag 'TODO\(serban\)'"

abbr --add dfs 'delta --features (dark)-side-by-side'
abbr --add dfu 'delta --features (dark)-unified-diff'

abbr --add nva NVIM_APPNAME=nvim-astro nvim
abbr --add nvf NVIM_APPNAME=nvim-fresh nvim
abbr --add nvl NVIM_APPNAME=nvim-lazy nvim

abbr --add sha sha256sum

abbr --add sts "date '+%Y-%m-%d-%H%M%S'"

# The slash in front of each name tells fd to match relative to the current
# directory. Without the slash, fd excludes any file matching the name at any
# level below the current one. For example, if run from $HOME, this excludes
# everything under ~/Music but not ~/Downloads/Music. See:
#
# * https://git-scm.com/docs/gitignore and
# * https://docs.rs/ignore/latest/ignore/struct.WalkBuilder.html
#
# Tested on 2021-12-22 with fd 8.3.0.
abbr --add fdh 'fd -E /env -E /go -E /opt -E /oss -E /pre -E /Library -E /Movies -E /Music -E /Pictures -E /Data'

abbr --add mocp 'mocp --moc-dir ~/.config/moc'

abbr --add  units  "units --history ''"
abbr --add gunits "gunits --history ''"

abbr --add bleach "perl -pe 's/\e\[[0-9;]*m//g'"

# The regular expression we want to pass to perl is \\n, with two backslashes.
# If we were typing out this abbr invocation on the command line, we would need
# four backslashes to represent the original two. Here, we need *eight*
# backslashes to represent the four we want inserted in the abbreviation string.
abbr --add sn "perl -pe 's/\\\\\\\\n/\n/g'"

abbr --add rmclass find . -type f -name "'*.class'" -exec rm -vf "'{}'" \\\;
abbr --add rmds find . -type f -name .DS_Store -exec rm -vf "'{}'" \\\;
abbr --add rmpyc find . -type f -name "'*.pyc'" -exec rm -vf "'{}'" \\\;
abbr --add rmswp find . -type f -regex "'^.*/\\.[^/]*sw[a-z]\$'" -exec rm -vf "'{}'" \\\;

abbr --add wmt watchman-make --pattern "'**/BUILD'" "'**/*.h'" "'**/*.cc'" --run "'bazel test :all'"
