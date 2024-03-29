#!/usr/bin/env py

import os
import re
import sys

BAD_CHARS = re.compile(r'[^0-9A-Za-z ._-]')

for dirpath, dirnames, filenames in os.walk(sys.argv[1]):
  for name in dirnames + filenames:
    if BAD_CHARS.search(name):
      print(os.path.join(dirpath, name))
