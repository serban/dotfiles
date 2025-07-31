import collections
import datetime
import enum
import importlib
import inspect
import io
import os
import pathlib
import pprint
import re
import subprocess
import sys
import time
import zoneinfo

try:
  from icecream import ic
  ic.configureOutput(prefix='⌬ ', includeContext=True)
except ModuleNotFoundError:
  pass

try:
  import rich.columns
  import rich.console
  import rich.padding
  import rich.pretty
  rich.pretty.install()
except ModuleNotFoundError:
  pass

try:
  import wat
except ModuleNotFoundError:
  pass

from serban.dotfiles import script

def env():
  def is_container(o):
    return isinstance(o, (tuple, list, set, frozenset, dict))

  def is_primitive(o):
    return isinstance(o, (bool, int, float, complex, bytes, str)) or o is None

  console = rich.console.Console(width=80)

  e = globals()
  g = frozenset(k for k in e if not k.startswith('_'))
  m = frozenset(k for k in g if inspect.ismodule(e[k]))
  c = frozenset(k for k in g if inspect.isclass(e[k]))
  f = frozenset(k for k in g if inspect.isfunction(e[k]))
  b = frozenset(k for k in g if is_container(e[k]))
  p = frozenset(k for k in g if is_primitive(e[k]))
  s = m & sys.stdlib_module_names
  t = m - sys.stdlib_module_names
  o = g - m - c - f - b - p

  for v, k in [
    (s, 'Standard Library Modules'),
    (t, 'Modules'),
    (c, 'Classes'),
    (f, 'Functions'),
    (b, 'Containers'),
    (p, 'Primitives'),
    (o, 'Other'),
  ]:
    if v:
      script.heading(k)
      columns = rich.columns.Columns(
          sorted(v), width=17, padding=(0, 2, 0, 0), column_first=True)
      console.print(rich.padding.Padding(columns, (0, 2)))
  if o:
    script.separator()
    script.map({k: type(e[k]) for k in sorted(o)})
