#!/usr/bin/env py

import argparse
import datetime

from serban.dotfiles import timp

def parse_command_line_arguments():
  parser = argparse.ArgumentParser(description='Date Range Tool')
  parser.add_argument('start_date', type=datetime.date.fromisoformat)
  parser.add_argument('end_date', type=datetime.date.fromisoformat)
  return parser.parse_args()

def main():
  args = parse_command_line_arguments()

  for date in timp.date_range_inclusive(args.start_date, args.end_date):
    print(date.strftime('%a %b %d'))

if __name__ == '__main__':
  main()
