#!/usr/bin/env bash
# vim:set ts=8 sw=2 sts=2 et:

set -o nounset

export PATH="${HOME}/bin:${HOME}/src/dotfiles/bin:${PATH}"
readonly BACKGROUND="${HOME}/Downloads/background.jpg"

log() {
  echo "SERBAN: $1" 1>&2
}

# Get rid of the horrible default GTK theme. Do this before running the `xset`
# invocations below so that gnome-settings-daemon does not override the settings
# made in this script.
log 'Starting gnome-settings-daemon'
gnome-settings-daemon &

# Sleep for a bit so that gnome-settings-daemon can do its thing before we
# override stuff below.
log 'Waiting for gnome-settings-daemon'
sleep 1

if [ -f "${BACKGROUND}" ]; then
  log 'Setting background image'
  fbsetbg -f "${BACKGROUND}"
else
  log "Cannot set background image: no image found at ${BACKGROUND}"
fi

log 'Sourcing ~/.Xresources'
xrdb -merge ~/.Xresources

log 'Turning off the number lock'
numlockx off

log 'Setting the keyboard repeat delay and repeat rate'
xset r rate 200 50  # in milliseconds and keystrokes/sec, respectively

# Poweroff the display after ten minutes of inactivity
log 'Setting display power preferences'
xset s blank
xset dpms 600 600 600

log 'Starting xautolock'
xautolock -time 5 -locker 'i3lock --ignore-empty-password --color=657b83' &

log 'Starting conky'
conky &

log 'Starting i3'
exec i3
