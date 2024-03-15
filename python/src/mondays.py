#!/usr/bin/env py

import calendar
import datetime
import sys

from serban.dotfiles import timp

year = datetime.date.today().year

if len(sys.argv) > 1:
  year = int(sys.argv[1])

for date in timp.date_range_inclusive(
    datetime.date(year, 1, 1), datetime.date(year, 12, 31)):
  if date.weekday() == calendar.MONDAY:
    print(date.isoformat())
