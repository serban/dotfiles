import collections
import enum
import math
import os
import typing

# https://mypy.readthedocs.io/en/stable/running_mypy.html#missing-library-stubs-or-py-typed-marker
import wcwidth  # type: ignore

from serban.dotfiles import script

class Alignment(enum.Enum):
  LEFT = '<'
  CENTER = '^'
  RIGHT = '>'

def _transform(o: typing.Any) -> str:
  match o:
    case None:          return '∅'
    case False:         return '✗'
    case True:          return '✓'
    case os.PathLike(): return script.tilde(o).strip()
    case _:             return str(o).strip()

def _width(s: str) -> int:
  return wcwidth.wcswidth(s)

def _pad(s: str, alignment: Alignment, width: int) -> str:
  pad_total = max(0, width - _width(s))
  pad_left  = math.ceil(pad_total / 2)
  pad_right = math.floor(pad_total / 2)

  space_total = ' ' * pad_total
  space_left  = ' ' * pad_left
  space_right = ' ' * pad_right

  match alignment:
    case Alignment.LEFT:   return f'{s}{space_total}'
    case Alignment.CENTER: return f'{space_left}{s}{space_right}'
    case Alignment.RIGHT:  return f'{space_total}{s}'

class Table:
  """A builder for rendering a plain text table.

  >>> t = Table('✨', 'Wings', '› Legs',
  ...           '‹ English', '‹ Espan\u0303ol',
  ...           '‹ Franc\u0327ais', '‹ Roma\u0302na\u0306')
  >>> t.add_row('🦉', True, 2, 'Owl', 'Búho', 'Chouette', 'Bufniță')
  >>> t.add_separator()
  >>> t.add_row('🐭', False, 4, 'Mouse', 'Ratón', 'Souris', 'Șoarece')
  >>> t.add_row('🦝', False, 4, 'Raccoon', 'Mapache', 'Raton Laveur', 'Raton')
  >>> t.add_row('🦊', False, 4, 'Fox', 'Zorro', 'Renard', 'Vulpe')
  >>> t.add_row('🦁', False, 4, 'Lion', 'León', 'Lion', 'Leu')
  >>> t.add_separator()
  >>> t.add_row('🐙', False, 8, 'Octopus', 'Pulpo', 'Pieuvre', 'Caracatiță')
  >>> print(t.render())
  │ ✨ │ Wings │ › Legs │ ‹ English │ ‹ Español │ ‹ Français   │ ‹ Română   │
  ├────┼───────┼────────┼───────────┼───────────┼──────────────┼────────────┤
  │ 🦉 │   ✓   │      2 │ Owl       │ Búho      │ Chouette     │ Bufniță    │
  ├────┼───────┼────────┼───────────┼───────────┼──────────────┼────────────┤
  │ 🐭 │   ✗   │      4 │ Mouse     │ Ratón     │ Souris       │ Șoarece    │
  │ 🦝 │   ✗   │      4 │ Raccoon   │ Mapache   │ Raton Laveur │ Raton      │
  │ 🦊 │   ✗   │      4 │ Fox       │ Zorro     │ Renard       │ Vulpe      │
  │ 🦁 │   ✗   │      4 │ Lion      │ León      │ Lion         │ Leu        │
  ├────┼───────┼────────┼───────────┼───────────┼──────────────┼────────────┤
  │ 🐙 │   ✗   │      8 │ Octopus   │ Pulpo     │ Pieuvre      │ Caracatiță │
  """

  def __init__(self, *headers):
    """Initialize the table with the given column headers.

    Columns whose headers start with `‹` are left-aligned [1].
    Columns whose headers start with `›` are right-aligned [2].
    Columns whose headers do not start with either prefix are centered.

    [1] `‹` U+2039 “Single Left-Pointing Angle Quotation Mark”
    [2] `›` U+203A “Single Right-Pointing Angle Quotation Mark”
    """
    cells = [_transform(header) for header in headers]

    if not cells:
      raise ValueError('No headers')

    for cell in cells:
      if not _width(cell):
        raise ValueError('Cannot have empty headers')

    self.rows = list()
    self.num_columns = len(cells)
    self.alignment = collections.defaultdict(lambda: Alignment.CENTER)

    for i, cell in enumerate(cells):
      if cell.startswith('‹'):
        self.alignment[i] = Alignment.LEFT
      elif cell.startswith('›'):
        self.alignment[i] = Alignment.RIGHT

    self.add_row(*cells)
    self.add_separator()

  def add_row(self, *cells) -> None:
    """Add a row comprised of the given cells.

    Each argument is transformed into a string and stripped.
    Some types are transformed into more compact representations.
    """
    if (num_cells := len(cells)) != self.num_columns:
      raise ValueError(
          f'Dimension mismatch: Need {self.num_columns} cells. Got {num_cells}')
    self.rows.append([_transform(cell) for cell in cells])

  def add_separator(self) -> None:
    """Add a row that renders as a horizontal line with no cell contents."""
    self.rows.append(None)

  def render(self) -> str:
    """Return the formatted table."""
    widths = collections.defaultdict[int, int](int)
    for row in self.rows:
      if row:
        for i, cell in enumerate(row):
          widths[i] = max(widths[i], _width(cell))

    lines = list()
    for row in self.rows:
      if row:
        cells_padded = [
            f' {_pad(cell, self.alignment[i], widths[i])} '
            for i, cell in enumerate(row)]
      else:
        cells_padded = ['─' * (widths[i] + 2) for i in range(self.num_columns)]

      if row:
        lines.append(f'│{"│".join(cells_padded)}│')
      else:
        lines.append(f'├{"┼".join(cells_padded)}┤')

    return '\n'.join(lines)
