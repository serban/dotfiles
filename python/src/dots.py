#!/usr/bin/env py

import argparse
import sys
import time

from serban.dotfiles import script


def parse_command_line_arguments():
  parser = argparse.ArgumentParser()

  parser.add_argument(
      '-v', '--verbose', dest='verbose', action='store_true',
      help='enable verbose output')

  parser.add_argument(
      'seconds', type=int,
      help='the number of seconds to wait')

  return parser.parse_args()


def main():
  args = parse_command_line_arguments()
  assert args.seconds >= 0

  total_seconds = args.seconds
  minutes, seconds = divmod(total_seconds, 60)

  if args.verbose:
    print(f'Waiting {script.human_duration(total_seconds)}')

  for i in range(1, total_seconds+1):
    try:
      time.sleep(1)
    except KeyboardInterrupt:
      if args.verbose:
        print(f'\nInterrupted after {script.human_duration(i-1)}')
      else:
        print(f' {script.human_duration(i-1)}')
      sys.exit(0)
    print('.', end='', flush=True)
    m, s = divmod(i, 60)
    if s == 0:
      print(f' {m:2d}m')

  if seconds > 0:
    print(f' {script.human_duration(i)}')


if __name__ == '__main__':
  main()
