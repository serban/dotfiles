import collections
import datetime
import enum
import importlib
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
  import wat
except ModuleNotFoundError:
  pass

from serban.dotfiles import script
