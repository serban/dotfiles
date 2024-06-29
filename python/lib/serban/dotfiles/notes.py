import dataclasses
import datetime
import os
import pathlib
import re

ROOT = pathlib.Path.home() / 'txt'

_FILE_REGEX = re.compile(r'^(\d{4}-\d{2}-\d{2}) (.+)\.md$')
_HEAD_REGEX = re.compile(r'^# (\d{4}-\d{2}-\d{2}) - (.+)$')

@dataclasses.dataclass(slots=True)
class Metadata:
  """The metadata of a note derived from its filesystem path.

  Instantiation always succeeds but attributes are only meaningful if the
  `valid` attribute is True.

  Attributes:
    path:     A pathlib.Path.   The full path to the note file.
    valid:    A boolean.        True if the path is valid.
    error:    A string.         An explanation of why `valid` is False.
    folder:   A pathlib.Path.   The subfolder under ~/txt containing the note.
    date:     A datetime.date.  The creation date of the note.
    title:    A string.         The title of the note.
  """
  path:     pathlib.Path

  valid:    bool                  = dataclasses.field(init=False, default=False)
  error:    str                   = dataclasses.field(init=False, default='')

  folder:   pathlib.Path | None   = dataclasses.field(init=False, default=None)
  date:     datetime.date | None  = dataclasses.field(init=False, default=None)
  title:    str                   = dataclasses.field(init=False, default='')

  def __post_init__(self):
    try:
      folder = self.path.parent.resolve().relative_to(ROOT)
    except ValueError:
      self.error = 'Bad folder'
      return

    if not folder.parts:
      self.error = 'No folder'
      return

    self.folder = folder

    if file_match := re.match(_FILE_REGEX, self.path.name):
      file_date_str, file_title = file_match.group(1), file_match.group(2)
    else:
      self.error = 'Bad filename'
      return

    try:
      self.date = datetime.date.fromisoformat(file_date_str)
    except ValueError:
      self.error = 'Bad date'
      return

    if file_title.strip() != file_title:
      self.error = 'Bad title'
      return

    self.title = file_title

    self.valid = True

@dataclasses.dataclass(slots=True)
class Note:
  """An in-memory representation of a note.

  Instantiation always succeeds but attributes are only meaningful if the
  `valid` attribute is True.

  Attributes:
    path:     A pathlib.Path.   The full path to the note file.
    contents: A string.         The full contents of the note file.
    valid:    A boolean.        True if the path and contents are valid.
    error:    A string.         An explanation of why `valid` is False.
    folder:   A pathlib.Path.   The subfolder under ~/txt containing the note.
    date:     A datetime.date.  The creation date of the note.
    title:    A string.         The title of the note.
    body:     A string.         The full contents of the note minus the header.
  """
  path:     pathlib.Path
  contents: str

  valid:    bool                  = dataclasses.field(init=False, default=False)
  error:    str                   = dataclasses.field(init=False, default='')

  folder:   pathlib.Path | None   = dataclasses.field(init=False, default=None)
  date:     datetime.date | None  = dataclasses.field(init=False, default=None)
  title:    str                   = dataclasses.field(init=False, default='')
  body:     str                   = dataclasses.field(init=False, default='')

  def __post_init__(self):
    meta = Metadata(self.path)

    if not meta.valid:
      self.error = meta.error
      return

    self.folder = meta.folder

    if not self.contents:
      self.error = 'No contents'
      return

    if not self.contents.endswith('\n'):
      self.error = 'No newline'
      return

    lines = self.contents.splitlines()

    if head_match := re.match(_HEAD_REGEX, lines[0]):
      head_date_str, head_title = head_match.group(1), head_match.group(2)
    else:
      self.error = 'Bad header'
      return

    try:
      head_date = datetime.date.fromisoformat(head_date_str)
    except ValueError:
      self.error = 'Bad header date'
      return

    if head_date != meta.date:
      self.error = 'Date mismatch'
      return

    self.date = meta.date

    if head_title == meta.title:
      self.title = meta.title
    else:
      self.error = 'Title mismatch'
      return

    if len(lines) > 1 and lines[1]:
      self.error = 'No blank line'
      return

    if len(lines) > 2:
      self.body = '\n'.join(lines[2:])

    self.valid = True

def create(
    folder: str | pathlib.Path,
    title: str,
    body: str = '',
    date: str | datetime.date | None = None) -> Note:
  """Create a note in the given folder under ~/txt.

  Args:
    folder:
      A pathlib.Path or string. The relative path under ~/txt in which to place
      the note. The folder and its parents are created if they do not exist.
    title:
      A string. The title of the note.
    body:
      A string. The body of the note.
    date:
      A datetime.date or ISO 8601 date string. The creation date of the note.
      Defaults to today's date if None.

  Returns:
    A Note object representing the created note.

  Raises:
    ValueError:
      If the resulting note would be invalid.
    FileExistsError:
      If the note file exists.
  """
  date = date or datetime.date.today()
  header = f'# {date} - {title}'
  filename = f'{date} {title}.md'
  directory = ROOT / folder
  path = directory / filename
  contents = f'{header}\n' if not body else f'{header}\n\n{body}'

  if not contents.endswith('\n'):
    contents += '\n'

  note = Note(path, contents)
  if not note.valid:
    raise ValueError(note.error)

  os.makedirs(directory, exist_ok=True)
  with open(path, 'x') as file:
    file.write(contents)

  return note

def load(path: pathlib.Path) -> Note:
  """Return a Note object representing the note at the given path."""
  with open(path) as file:
    return Note(path, file.read())
