#!/usr/bin/env py

import argparse
import calendar
import datetime

from serban.dotfiles import timp

def parse_command_line_arguments():
  parser = argparse.ArgumentParser(description='Mondays')
  parser.add_argument(
      'year', nargs='?', type=int, default=datetime.date.today().year)
  return parser.parse_args()

def main():
  year = parse_command_line_arguments().year

  for date in timp.date_range_inclusive(
      datetime.date(year, 1, 1), datetime.date(year, 12, 31)):
    if date.weekday() == calendar.MONDAY:
      print(date.isoformat())

if __name__ == '__main__':
  main()
