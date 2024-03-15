import calendar
import collections
import datetime

from serban.dotfiles import script

def date_range(
    start_date: datetime.date,
    end_date: datetime.date,
    include_end: bool = False,
    exclude_weekends: bool = False,
    excluded: collections.abc.Set[datetime.date] = frozenset(),
) -> collections.abc.Iterator[datetime.date]:
  """Yield a series of dates in the given interval with optional constraints.

  Args:
    start_date:
      A datetime.date. The first date to iterate over.
    end_date:
      A datetime.date. The last date to iterate over (see include_end).
    include_end:
      A boolean. When False, iterate over the half-open interval [start, end).
      When True, iterate over the closed interval [start, end].
    exclude_weekends:
      A boolean. Omit Saturdays and Sundays.
    excluded:
      A set. An explicit list of dates to omit.

  Yields:
    datetime.date objects.
  """
  for i in range((end_date - start_date).days + (1 if include_end else 0)):
    date = start_date + datetime.timedelta(days=i)
    if ((exclude_weekends and date.weekday() > calendar.FRIDAY) or
        (date in excluded)):
      continue
    yield date

def date_range_exclusive(
    start_date: datetime.date,
    end_date: datetime.date) -> collections.abc.Iterator[datetime.date]:
  """Yield a series of dates in the given half-open interval [start, end)."""
  return date_range(start_date, end_date)

def date_range_inclusive(
    start_date: datetime.date,
    end_date: datetime.date) -> collections.abc.Iterator[datetime.date]:
  """Yield a series of dates in the given closed interval [start, end]."""
  return date_range(start_date, end_date, include_end=True)

def previous_friday_exclusive(today: datetime.date) -> datetime.date:
  """Get the previous Friday. If today is Friday, return today."""
  return today - datetime.timedelta(
      days=((today.weekday() - calendar.FRIDAY + 7) % 7))

def previous_sunday_exclusive(today: datetime.date) -> datetime.date:
  """Get the previous Sunday. If today is Sunday, return today."""
  return today - datetime.timedelta(
      days=((today.weekday() - calendar.SUNDAY + 7) % 7))

def previous_monday_exclusive(today: datetime.date) -> datetime.date:
  """Get the previous Monday. If today is Monday, return today."""
  return today - datetime.timedelta(days=today.weekday())

def previous_monday_inclusive(today: datetime.date) -> datetime.date:
  """Get the previous Monday. If today is Monday, return the previous Monday."""
  return previous_monday_exclusive(today - datetime.timedelta(days=1))

def mondays(count: int = 6) -> collections.abc.Iterator[datetime.date]:
  """Yield count Mondays starting with the previous Monday, inclusive."""
  first_monday = previous_monday_inclusive(datetime.date.today())
  for i in range(count):
    yield first_monday + datetime.timedelta(weeks=i)

def select_monday(count: int = 6) -> datetime.date:
  """Prompt the user to select a date from a list of past and coming Mondays."""
  today = datetime.date.today()
  script.message(f'Today is {today:%a} {today:%b} {today:%d}')
  monday = datetime.date.fromisoformat(
      script.select('Monday', [m.isoformat() for m in mondays(count)]))
  script.result(f'Selected {monday:%a} {monday:%b} {monday:%d}')
  return monday
