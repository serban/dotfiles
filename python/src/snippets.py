#!/usr/bin/env py

import calendar
import datetime
import pathlib
import stat
import string
import subprocess

from serban.dotfiles import script

TEMPLATE = """# $DATE - Snippets

## Week of $MONTH $DAY, $YEAR

### Monday

### Tuesday

### Wednesday

### Thursday

### Friday
"""

SNIPPETS_DIR = pathlib.Path(pathlib.Path.home(), 'txt', 'snippets')
SCRATCH_PATH = pathlib.Path(SNIPPETS_DIR, '0001-01-01 Scratch.md')
ACTIVE_PATH  = pathlib.Path(SNIPPETS_DIR, '0001-01-01 Active.md')


def snippets_path(date):
  return pathlib.Path(SNIPPETS_DIR, date.isoformat() + ' Snippets' + '.md')


def write_snippets_file(date):
  substitutions = {
    'DATE': date.isoformat(),
    'MONTH': calendar.month_name[date.month],
    'DAY': date.day,
    'YEAR': date.year,
  }

  template = string.Template(TEMPLATE)

  path = snippets_path(date)
  path.parent.mkdir(parents=True, exist_ok=True)

  with path.open('w') as f:
    f.write(template.substitute(substitutions))

  path.parent.chmod(stat.S_IRWXU)
  path.chmod(stat.S_IRUSR | stat.S_IWUSR)


def open_vim(*paths):
  # NB: bufdo changes the buffer of the current window to the last buffer.
  subprocess.run(
      ['vim',
       '-c', 'silent bufdo set textwidth=0',
       '-c', 'buffer 1',
       '-c', 'split',
       '-c', 'buffer 2',
       '-c', 'botright vsplit',
       '-c', 'buffer 3',
       '-c', 'botright vsplit',
       '-c', 'buffer 4',
       '-c', 'wincmd =',
       '-c', f'cd {SNIPPETS_DIR}',
       *paths])


def main():
  today = datetime.date.today()
  this_monday = today - datetime.timedelta(days=today.weekday())
  last_monday = this_monday - datetime.timedelta(weeks=1)

  this_week_path = snippets_path(this_monday)
  last_week_path = snippets_path(last_monday)

  if not this_week_path.exists():
    write_snippets_file(this_monday)

  script.title('Snippets')
  open_vim(SCRATCH_PATH, ACTIVE_PATH, last_week_path, this_week_path)


if __name__ == '__main__':
  main()
