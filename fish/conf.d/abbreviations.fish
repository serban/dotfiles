abbr --add --global h head
abbr --add --global t tail
abbr --add --global l less -N

abbr --add --global d colordiff -u
abbr --add --global f find . -iname

abbr --add --global i history

abbr --add --global j jobs
abbr --add --global k kill
abbr --add --global v 'p | grep -i vim | awk "{print \$NF}"'

abbr --add --global s snippets

abbr --add --global cp cp -vi
abbr --add --global mv mv -vi
abbr --add --global rm rm -v

abbr --add --global p2 python2
abbr --add --global p3 python3

abbr --add --global jd jackd --driver coreaudio --rate 44100

abbr --add --global kb xset r rate 200 50  # in milliseconds and keystrokes/sec

abbr --add --global rmclass find . -type f -name "'*.class'" -exec rm -vf "'{}'" \\\;
abbr --add --global rmds find . -type f -name .DS_Store -exec rm -vf "'{}'" \\\;
abbr --add --global rmpyc find . -type f -name "'*.pyc'" -exec rm -vf "'{}'" \\\;
abbr --add --global rmswp find . -type f -regex "'^.*/\\.[^/]*sw[a-z]\$'" -exec rm -vf "'{}'" \\\;

abbr --add --global wmt watchman-make --pattern "'**/BUILD'" "'**/*.h'" "'**/*.cc'" --run "'bazel test :all'"
