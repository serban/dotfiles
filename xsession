#!/usr/bin/env bash

set -o nounset

export PATH="${HOME}/bin:${HOME}/src/dotfiles/bin:${PATH}"
readonly BACKGROUND="${HOME}/Downloads/background.jpg"

log() {
  echo "SERBAN: $1" 1>&2
}

dots() {
  echo -n 'SERBAN: '

  for ((i=0; i<$1; i++)); do
    sleep 1
    echo -n '.'
  done

  echo
}

# Get rid of the horrible default GTK theme. Do this before running the `xset`
# invocations below so that gnome-settings-daemon does not override the settings
# made in this script.
log 'Starting gnome-settings-daemon (cinnamon-settings-daemon) components'
/usr/lib/x86_64-linux-gnu/cinnamon-settings-daemon/csd-xrandr &
/usr/lib/x86_64-linux-gnu/cinnamon-settings-daemon/csd-xsettings &

# Sleep for a bit so that gnome-settings-daemon can do its thing before we
# set the background and override stuff below.
log 'Waiting for gnome-settings-daemon'
dots 2

# if [ -f "${BACKGROUND}" ]; then
#   log 'Setting background image'
#   fbsetbg -f "${BACKGROUND}"
# else
#   log "Cannot set background image: no image found at ${BACKGROUND}"
# fi

log 'Setting background images'
nitrogen --restore

# Sleep for a bit so that nitrogen can do its thing before conky starts and
# leaves artifacts on the background.
log 'Waiting for nitrogen'
dots 6

log 'Sourcing ~/.Xresources'
xrdb -merge ~/.Xresources

log 'Turning off the number lock'
numlockx off

# To use the function keys on an Apple keyboard:
#
# echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode

for ID in $(
    xinput -list |
        grep 'Apple Keyboard' |
        grep --extended-regexp --only-matching 'id=[[:digit:]]+' |
        cut --delimiter='=' --fields=2); do
  log "Swapping CTRL and CAPS keys for Apple Keyboard ${ID}"
  setxkbmap -option ctrl:swapcaps -device "${ID}"
done

log 'Setting the keyboard repeat delay and repeat rate'
xset r rate 200 50  # in milliseconds and keystrokes/sec, respectively

log 'Setting display power preferences'
xset s blank            # Prefer a blank screen over a background pattern
xset s expose           # Never disable the screensaver
xset s 0 0              # Don't actually blank the display
xset dpms 600 600 600   # Poweroff the display after ten minutes of inactivity

# Disable screen blanking and do not poweroff the display
# log 'Disabling screen blanking'
# xset s off -dpms

log 'Starting xautolock'
xautolock -time 5 -locker 'i3lock --ignore-empty-password --color=657b83' &  # base00

log 'Starting conky'
conky &

log 'Starting Goobuntu Indicator'
/usr/share/goobuntu-indicator/goobuntu_indicator.py &

log 'Starting i3'
exec i3
