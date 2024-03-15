#!/usr/bin/env py

import argparse
import datetime
import os

from serban.dotfiles import timp


def parse_exclude_file(path):
  with open(path) as f:
    return [l for l in f.read().splitlines() if l and not l.startswith('#')]


def parse_command_line_arguments():
  parser = argparse.ArgumentParser(
      description='Count the number of days until a target date')

  parser.add_argument(
      'date',
      help='The target date, YYYY-MM-DD')

  parser.add_argument(
      '-w', '--exclude-weekends', dest='exclude_weekends',
      action='store_true',
      help='Do not count Saturdays and Sundays')

  parser.add_argument(
      '-e', '--exclude', dest='exclude_paths', metavar='PATH',
      default=[], action='append',
      help='A list of dates to exclude')

  return parser.parse_args()


def main():
  args = parse_command_line_arguments()

  exclude = []
  for p in args.exclude_paths:
    exclude.extend(parse_exclude_file(os.path.expanduser(p)))

  target_date = datetime.datetime.strptime(
      args.date, '%Y-%m-%d').date()
  exclude_dates = set(
      [datetime.datetime.strptime(d, '%Y-%m-%d').date() for d in exclude])

  print(len(list(timp.date_range(
      datetime.date.today(), target_date,
      exclude_weekends=args.exclude_weekends, excluded=exclude_dates))))


if __name__ == '__main__':
  main()
