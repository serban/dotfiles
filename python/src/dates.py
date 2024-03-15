#!/usr/bin/env py

import datetime
import sys

from serban.dotfiles import timp

def main():
  if len(sys.argv) < 3:
    print('Provide a start date and end date', file=sys.stderr)
    sys.exit(1)

  start_date = datetime.datetime.strptime(sys.argv[1], '%Y-%m-%d').date()
  end_date   = datetime.datetime.strptime(sys.argv[2], '%Y-%m-%d').date()

  for date in timp.date_range_inclusive(start_date, end_date):
    print(date.strftime('%a %b %d'))

if __name__ == '__main__':
  main()
