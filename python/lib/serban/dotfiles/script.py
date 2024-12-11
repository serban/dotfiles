import collections.abc
import dataclasses
import datetime
import os
import pathlib
import pprint
import shlex
import shutil
import subprocess
import sys
import time
import typing

RESET   = '\033[0m'
RED     = '\033[31m'
GREEN   = '\033[32m'
YELLOW  = '\033[33m'
BLUE    = '\033[34m'
MAGENTA = '\033[35m'
CYAN    = '\033[36m'
ORANGE  = '\033[91m'  # Solarized
VIOLET  = '\033[95m'  # Solarized

# Setting dry_run to True makes all of the subprocess wrappers below impotent.
# This functionality exists so that during development of a script you can
# quickly disable command invocation but still allow the subprocess wrappers to
# print the commands they would have executed. This mechanism allows for a quick
# but dangerous hack, as enabling it may change the behavior of your code in
# ways you don’t expect. Be careful!
#
# Turning on this flag has the following effects:
#
# •       run() does nothing
# • getstatus() returns zero
# • getoutput() returns an empty string
# •   getline() returns an empty string
# •  getlines() returns an empty list
dry_run = False

# Type hints for numeric types are a mess:
#
# • https://peps.python.org/pep-0484/#the-numeric-tower
# • https://docs.python.org/3/library/numbers.html#numbers.Real
# • https://docs.python.org/3/library/typing.html#typing.SupportsInt
# • https://docs.python.org/3/library/typing.html#typing.SupportsFloat
# • https://github.com/python/mypy/issues/3186 - int is not a Number?
# • https://stackoverflow.com/a/69383462/599692 - How to hint at number types
def _get_total_seconds(d: float | datetime.timedelta) -> int:
  if isinstance(d, datetime.timedelta):
    total_seconds = int(d.total_seconds())
  else:
    total_seconds = int(d)

  if total_seconds < 0:  # Lossy. A more strict check would be d != abs(d)
    raise ValueError(
        f'Duration must be non-negative. Got {d!r} = {total_seconds:,} seconds')

  return total_seconds

def human_duration(d: float | datetime.timedelta, compact: bool = False) -> str:
  """Get a human-readable representation of a duration value.

  Args:
    d:
      A numeric value encoding seconds or a datetime.timedelta. Must be
      non-negative. Fractional components finer than a second are discarded.
    compact:
      A boolean. Produce a shorter output string.

  Returns:
    A string.
  """
  total_seconds = _get_total_seconds(d)

  days,    hours_remaining_seconds = divmod(            total_seconds, 86_400)
  hours, minutes_remaining_seconds = divmod(  hours_remaining_seconds,  3_600)
  minutes, seconds                 = divmod(minutes_remaining_seconds,     60)

  s = '' if compact else ' '

  if days:
    return f'{days:d}d{s}{hours:02d}h{s}{minutes:02d}m{s}{seconds:02d}s'
  elif hours:
    return               f'{hours:d}h{s}{minutes:02d}m{s}{seconds:02d}s'
  elif minutes:
    return                              f'{minutes:d}m{s}{seconds:02d}s'
  else:
    return                                               f'{seconds:d}s'

def tilde(p: str | os.PathLike) -> str:
  """Replace the $HOME prefix of a path with '~'. Returns a string."""
  path, home = os.fsdecode(p), str(pathlib.Path.home())
  return path.replace(home, '~', 1) if path.startswith(home) else path

def title(s: str) -> None:
  """Set the terminal title."""
  print(f'\033]0;{s}\007', end='', flush=True)

def debug(*args, **kwargs) -> None:
  """Print a debug message. Does nothing if running in PYTHONOPTIMIZE mode."""
  if __debug__:
    print(f'{BLUE}%', *args, RESET, **kwargs)

def message(*args, **kwargs) -> None:
  """Print an info message. Takes the same arguments as built-in print()."""
  print(f'{CYAN}❋', *args, RESET, **kwargs)

def success(*args, **kwargs) -> None:
  """Print a success message. Takes the same arguments as built-in print()."""
  print(f'{GREEN}✓', *args, RESET, **kwargs)

def result(*args, **kwargs) -> None:
  """Print a result message. Takes the same arguments as built-in print()."""
  print(f'{MAGENTA}→', *args, RESET, **kwargs)

def error(*args, **kwargs) -> None:
  """Print an error message. Takes the same arguments as built-in print()."""
  print(f'{RED}!', *args, RESET, **kwargs)

def die(*args, **kwargs) -> None:
  """Die with exit status 1 and print an error message. Same args as print()."""
  error(*args, **kwargs)
  sys.exit(1)

def indent(o: typing.Any) -> None:
  """Print an object and prefix two spaces to each non-blank line of output."""
  for line in str(o).splitlines():
    if l := line.rstrip():
      print(' ', l)
    else:
      print()

def dump(o: typing.Any, width: int = 76) -> None:
  """Pretty-print an object and indent each non-blank line of output."""
  indent(pprint.pformat(o, width=width, underscore_numbers=True))

def bullets(l: collections.abc.Iterable) -> None:
  """Print a bulleted list from the supplied iterable."""
  for item in l:
    print('  ⁃', item)

def map(d: collections.abc.Mapping) -> None:
  """Print a key-value pair list from the supplied mapping."""
  p = len(max([str(k) for k in d.keys()], key=len, default=''))
  for k, v in d.items():
    print(f'  {k!s:>{p}} : {v}')  # Need !s for keys that don't have __format__

def timestamp() -> None:
  """Print the current local time."""
  print('✝', time.strftime('%Y-%m-%d %H:%M:%S'))

def separator() -> None:
  """Print a nice horizontal line."""
  print(f'  {"─"*76}  ')

def heading(s: str) -> None:
  """Print a nice box around some text."""
  width = 80
  pad = max(width - 4, len(s))

  horizontal_line = '─'
  vertical_line   = '│'
  upper_left      = '╭'
  upper_right     = '╮'
  lower_left      = '╰'
  lower_right     = '╯'

  print('{}{}{}'.format(upper_left, horizontal_line*(pad+2), upper_right))
  print('{} {:{pad}} {}'.format(vertical_line, s, vertical_line, pad=pad))
  print('{}{}{}'.format(lower_left, horizontal_line*(pad+2), lower_right))

def wait(d: float | datetime.timedelta) -> datetime.timedelta:
  """Wait for the given time duration with visual indication of progress.

  Send SIGINT (Ctrl-C) to stop waiting before the full duration has elapsed.

  Args:
    d:
      A numeric value encoding seconds or a datetime.timedelta. Must be
      non-negative. Fractional components finer than a second are discarded.

  Returns:
    A datetime.timedelta representing the actual amount of time waited.
  """
  total_seconds = _get_total_seconds(d)

  print(f'{YELLOW}⏲', f'Waiting {human_duration(total_seconds)}', RESET)

  pad = len(human_duration(total_seconds))

  current_second = 0
  for second_being_processed in range(1, total_seconds + 1):
    current_minute, current_second = divmod(second_being_processed, 60)

    if current_second == 1:
      print(f'  ', end='', flush=True)

    try:
      time.sleep(1)
    except KeyboardInterrupt:
      seconds_waited = second_being_processed - 1  # time.sleep() did not finish
      print()
      error(f'Interrupted after {human_duration(seconds_waited)}')
      return datetime.timedelta(seconds=seconds_waited)

    print('.', end='', flush=True)

    if current_second == 0:
      print(f'  {human_duration(second_being_processed):>{pad}}')

  if total_seconds > 0 and current_second > 0:
    print(f'{" " * (60 - current_second)}  {human_duration(total_seconds)}')

  return datetime.timedelta(seconds=total_seconds)

def confirm(prompt: str) -> bool:
  """Return a yes-or-no response from the user for the given prompt.

  Accepts only ‘y’ for yes and ‘n’ for no.

  Args:
    prompt:
      The string to print before waiting for input.

  Returns:
    A boolean indicating yes (True) or no (False).

  Raises:
    EOFError:
      If the user triggers EOF (Ctrl-D) instead of answering the prompt.
    KeyboardInterrupt:
      If the user triggers SIGINT (Ctrl-C) instead of answering the prompt.
  """
  try:
    while True:
      print(f'{VIOLET}■ {prompt} {YELLOW}', end='')
      if (response := input()) in ['y', 'n']:
        return response == 'y'
  except (EOFError, KeyboardInterrupt):
    print()
    raise
  finally:
    print(RESET, end='')

def _fzf(noun: str, items: collections.abc.Iterable[str], multi=False) -> str:
  if not shutil.which('fzf'):
    die('select(): fzf is not installed')

  if not items:
    raise ValueError(f'Iterable must not be empty. Got {items!r}')

  for s in items:
    if not s:
      raise ValueError(f'Item must not be empty')
    if '\0' in s:
      raise ValueError(f'Item must not contain the null character. Got {s!r}')

  header = f'Select {noun}:' if multi else f'Select a {noun}:'
  try:
    return subprocess.run(
        ['fzf',
         '--header', header,
         '--read0', '--print0',
         '--bind', 'enter:accept-non-empty',
         '--bind', 'esc:clear-selection'] +
        (['--bind', 'ctrl-a:select-all', '--multi'] if multi else []),
        check=True, text=True, input='\0'.join(items),
        stdout=subprocess.PIPE).stdout.rstrip('\0')
  except subprocess.CalledProcessError as e:
    match e.returncode:
      case 130:
        # https://peps.python.org/pep-0409 - Suppressing exception context
        raise KeyboardInterrupt('fzf was interrupted') from None
      case _:
        raise

def select(noun: str, items: collections.abc.Iterable[str]) -> str:
  """Prompt the user to select an item from a list using fzf.

  Args:
    noun:
      A singular noun describing the classification of the items in the list.
    items:
      An iterable of strings. Each string must not be empty and must not contain
      the null character.

  Returns:
    A string. The item the user selected.

  Raises:
    KeyboardInterrupt:
      If the user triggers SIGINT (Ctrl-C) instead of selecting an item.
  """
  return _fzf(noun, items)

def selectmany(noun: str, items: collections.abc.Iterable[str]) -> list[str]:
  """Prompt the user to select one or more items from a list using fzf.

  Args:
    noun:
      A plural noun describing the classification of the items in the list.
    items:
      An iterable of strings. Each string must not be empty and must not contain
      the null character.

  Returns:
    A list of strings. The items the user selected.

  Raises:
    KeyboardInterrupt:
      If the user triggers SIGINT (Ctrl-C) instead of completing the selection.
  """
  return _fzf(noun, items, multi=True).split('\0')

# • https://peps.python.org/pep-0519
#   ↳ PEP 519 – Adding a file system path protocol (2016-05-11)
# • https://github.com/python/cpython/issues/89293
#   ↳ shlex.join() does not accept pathlib.Path objects (2021-09-07)
# • https://discuss.python.org/t/coerce-path-objects-in-shlex-join/26755
#   ↳ Coerce Path objects in shlex.join (2023-05-13)
def _shlex_join(args) -> str:
  return shlex.join(
      os.fsdecode(a) if isinstance(a, os.PathLike) else a for a in args)

def _run_and_indent_output(args) -> int:
  with subprocess.Popen(
      args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True) as p:
    for line in p.stdout:  # type: ignore
      if l := line.rstrip():
        print(' ', l)
      else:
        print()
  return p.returncode

def run(args, exit=True, verbose=True, indent=True) -> None:
  """Run a command.

  Args:
    args:
      The command to run. See the documentation for subprocess.Popen().
    exit:
      A boolean. Specifies the behavior when the command returns a non-zero exit
      status. When True, call sys.exit() with the exit status of the command.
      When False, ignore the failure.
    verbose:
      A boolean. Print the command before running it.
    indent:
      A boolean. Indent the output of the command.
  """
  if verbose:
    print(f'{YELLOW}»', _shlex_join(args), RESET, flush=True)
  if dry_run:
    return
  try:
    if indent:
      if (returncode := _run_and_indent_output(args)) != 0:
        raise subprocess.CalledProcessError(returncode, args)
    else:
      subprocess.run(args, check=True)
  except subprocess.CalledProcessError as e:
    error(e)
    if exit:
      sys.exit(e.returncode)

def getstatus(args, verbose=True, indent=True) -> int:
  """Get the exit status of a command.

  Args:
    args:
      The command to run. See the documentation for subprocess.Popen().
    verbose:
      A boolean. Print the command before running it.
    indent:
      A boolean. Indent the output of the command.

  Returns:
    An integer.
  """
  if verbose:
    print(f'{YELLOW}⁖', _shlex_join(args), RESET, flush=True)
  if dry_run:
    return 0
  if indent:
    return _run_and_indent_output(args)
  else:
    return subprocess.run(args).returncode

# When invoking subprocess.run(), getoutput() always captures stdout from the
# child process. However, there is a choice to be made for stderr.
# In general, there are four options:
#
# 1. Do not redirect stderr; stderr output goes to the terminal uncaptured.
# 2. Silence stderr; stderr output is discarded and does not appear in the
#    terminal.
# 3. Capture stderr independent from stdout; the two are available as separate
#    properties of subprocess.CompletedProcess and do not appear in the
#    terminal.
# 4. Redirect stderr to stdout and capture both streams in one place.
#    The combined stream is available in subprocess.CompletedProcess.stdout.
#
# See the following resources:
#
# • https://docs.python.org/3/library/subprocess.html#subprocess.run
# • https://docs.python.org/3/library/subprocess.html#subprocess.CompletedProcess
# • https://docs.python.org/3/library/subprocess.html#frequently-used-arguments
#
# From “Frequently Used Arguments”:
#
# › stdin, stdout, and stderr specify the executed program's standard input,
# › standard output and standard error file handles, respectively. Valid values
# › are PIPE, DEVNULL, an existing file descriptor (a positive integer), an
# › existing file object with a valid file descriptor, and None. PIPE indicates
# › that a new pipe to the child should be created. DEVNULL indicates that the
# › special file os.devnull will be used. With the default settings of None, no
# › redirection will occur; the child’s file handles will be inherited from the
# › parent. Additionally, stderr can be STDOUT, which indicates that the stderr
# › data from the child process should be captured into the same file handle as
# › for stdout.
def getoutput(args, exit=True, verbose=True, stderr=True) -> str:
  """Get the stdout output of a command.

  Args:
    args:
      The command to run. See the documentation for subprocess.Popen().
    exit:
      A boolean. Specifies the behavior when the command returns a non-zero exit
      status. When True, call sys.exit() with the exit status of the command.
      When False, ignore the failure and return an empty string.
    verbose:
      A boolean. Print the command before running it.
    stderr:
      A boolean. Specifies how to handle stderr output from the command. When
      True, stderr is not redirected and stderr output goes to the terminal
      uncaptured to facilitate debugging. When False, stderr output is
      suppressed and discarded.

  Returns:
    A string.
  """
  if verbose:
    print(f'{YELLOW}›', _shlex_join(args), RESET, flush=True)
  if dry_run:
    return ''
  try:
    return subprocess.run(
        args, check=True, stdout=subprocess.PIPE,
        stderr=None if stderr else subprocess.DEVNULL).stdout.decode()
  except subprocess.CalledProcessError as e:
    error(e)
    if exit:
      sys.exit(e.returncode)
    else:
      return ''

def getline(args, exit=True, verbose=True, stderr=True) -> str:
  """Get the stripped stdout output of a command.

  getline() is similar to getoutput(), but it strips the output string. This is
  useful when you expect the command to produce a single line of output.

  Returns:
    A string.
  """
  return getoutput(args, exit, verbose, stderr).strip()

def getlines(args, exit=True, verbose=True, stderr=True) -> list[str]:
  """Get the individual lines from the stdout output of a command.

  getlines() is similar to getoutput(), but it returns all the lines in a list.

  Returns:
    A list of strings.
  """
  return getoutput(args, exit, verbose, stderr).splitlines()

@dataclasses.dataclass(frozen=True, slots=True)
class Node:
  """The path attributes of a file discovered by walk().

  Attributes:
    path:     A pathlib.Path. The path to the file.
    parent:   A pathlib.Path. path.parent
    name:     A string.       path.name
    relative: A pathlib.Path. The path relative to the top of the search.
    absolute: A pathlib.Path. path.absolute()
    tilde:    A string.       tilde(path.absolute())
  """
  path:     pathlib.Path
  parent:   pathlib.Path
  name:     str
  relative: pathlib.Path
  absolute: pathlib.Path
  tilde:    str

def walk(top: pathlib.Path) -> collections.abc.Iterator[Node]:
  """Recursively yield the unhidden files of a directory in sorted order.

  Hidden directories are pruned; hidden files are omitted.

  Args:
    top:
      A pathlib.Path. The root of the search.

  Yields:
    Node objects.
  """
  for parent, dirs, files in top.walk():
    dirs[:] = sorted([d for d in dirs if not d.startswith('.')])
    names = sorted([f for f in files if not f.startswith('.')])
    for name in names:
      path = parent / name
      absolute = path.absolute()
      yield Node(path, parent, name, path.relative_to(top),
                 absolute, tilde(absolute))
