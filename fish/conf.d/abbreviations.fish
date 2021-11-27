abbr --add --global h head
abbr --add --global t tail
abbr --add --global l less -N

abbr --add --global d colordiff -u
abbr --add --global f find . -iname

abbr --add --global i " history --show-time=\e'[33m[%Y-%m-%d] '\e'[0m' --reverse"

abbr --add --global j jobs
abbr --add --global k kill
abbr --add --global v 'p | grep -i vim | awk "{print \$NF}"'

abbr --add --global s snippets

abbr --add --global cp cp -vi
abbr --add --global mv mv -vi
abbr --add --global rm rm -v

abbr --add --global p3 python3 -B
abbr --add --global p8 ping 8.8.8.8

abbr --add --global bu 'brew update && header Outdated Formulae && brew outdated'
abbr --add --global jd jackd --driver coreaudio --rate 44100

abbr --add --global kb xset r rate 200 50  # in milliseconds and keystrokes/sec

abbr --add --global dfs 'delta --features (dark)-side-by-side'
abbr --add --global dfu 'delta --features (dark)-unified-diff'

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
