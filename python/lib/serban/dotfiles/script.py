import pathlib
import shlex
import subprocess
import sys

RESET   = '\033[0m'
RED     = '\033[31m'
GREEN   = '\033[32m'
YELLOW  = '\033[33m'
BLUE    = '\033[34m'
MAGENTA = '\033[35m'
CYAN    = '\033[36m'

def tilde(p: pathlib.PurePath) -> str:
  """Replace the $HOME prefix of a PurePath with '~'. Returns a string."""
  path, home = str(p), str(pathlib.Path.home())
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

def error(*args, **kwargs) -> None:
  """Print an error message. Takes the same arguments as built-in print()."""
  print(f'{RED}!', *args, RESET, **kwargs)

def die(*args, **kwargs) -> None:
  """Die with exit status 1 and print an error message. Same args as print()."""
  error(*args, **kwargs)
  sys.exit(1)

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

def getstatus(args, verbose=True) -> int:
  """Get the exit status of a command.

  Args:
    args:
      The command to run. See the documentation for subprocess.Popen().
    verbose:
      A boolean. Print the command before running it.

  Returns:
    An integer.
  """
  if verbose:
    print(f'{YELLOW}⁖', shlex.join(args), RESET)
  return subprocess.run(args).returncode

def run(args, exit=True, verbose=True) -> None:
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
  """
  if verbose:
    print(f'{YELLOW}»', shlex.join(args), RESET)
  try:
    subprocess.run(args, check=True)
  except subprocess.CalledProcessError as e:
    error(e)
    if exit:
      sys.exit(e.returncode)

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
    print(f'{YELLOW}›', shlex.join(args), RESET)
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
