#!/usr/bin/env py

import datetime
import pathlib
import subprocess
import sys
import time

from serban.dotfiles import script

PERIOD_MINUTES = 10

def log(msg):
  print('{} -> {}'.format(time.strftime('%Y-%m-%d %H:%M:%S'), msg))


def next_notification():
  now = datetime.datetime.now()
  next_minute = (now.minute // PERIOD_MINUTES + 1) * PERIOD_MINUTES
  next_datetime = now.replace(second=0, microsecond=0) + datetime.timedelta(
      minutes=(next_minute - now.minute))
  return (next_datetime, (next_datetime - now).total_seconds())


def notify():
  subprocess.run(
      ['terminal-notifier',
       '-group', 'time-tracker',
       '-sound', 'pop',
       '-title', 'Time Tracker',
       '-message', f'What did you do in the last {PERIOD_MINUTES} minutes?',
       '-open', 'file://' + str(pathlib.Path(pathlib.Path.home(), 'time.txt'))])


def main():
  try:
    while True:
      next_datetime, duration_seconds = next_notification()
      log(f'Next notification in {duration_seconds:.1f} seconds at '
          f'{next_datetime:%H:%M}')
      time.sleep(duration_seconds)
      wakeup_datetime = datetime.datetime.now()
      wakeup_delta = wakeup_datetime - next_datetime
      if wakeup_delta > datetime.timedelta(minutes=1):
        log(f'Woke up {script.human_duration(wakeup_delta)} too late. '
            f'Skipping notification')
        continue
      log('Notifying')
      notify()
  except KeyboardInterrupt:
    sys.exit(0)


if __name__ == '__main__':
  main()
