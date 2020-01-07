#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly term='urxvt'

# Use `pactl list sinks` to discover audio sinks
readonly sink='alsa_output.pci-0000_00_1f.3.HiFi__hw_PCH_0__sink'

case "$1" in
  alfred)         exec rofi -show run ;;
  browser)        exec google-chrome ;;
  calculator)     exec gnome-calculator ;;
  editor)         exec gvim --nofork ;;
  finder)         exec thunar ;;
  htop)           exec $term -e htop ;;
  media-prev)     exec xdotool key XF86AudioPrev ;;
  media-next)     exec xdotool key XF86AudioNext ;;
  media-play)     exec xdotool key XF86AudioPlay ;;
  mixer)          exec $term -bg black -fg white -title 'ALSA Mixer' -e alsamixer ;;
  python)         exec $term -e bpython3 ;;
  screensaver)    exec xautolock -locknow ;;
  screenshot)     exec xfce4-screenshooter ;;
  terminal)       exec $term ;;
  volume-up)      exec pactl set-sink-volume $sink +5% ;;
  volume-down)    exec pactl set-sink-volume $sink -5% ;;
  volume-mute)    exec pactl set-sink-mute $sink toggle  ;;
  *)              echo 'What do you want to launch?' 1>&2 ; exit 1 ;;
esac
