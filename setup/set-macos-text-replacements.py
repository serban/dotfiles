#!/usr/bin/env python3

import plistlib
import subprocess
import tempfile

REPLACEMENTS = {
  '(0)': '⓪',
  '(1)': '①',
  '(2)': '②',
  '(3)': '③',
  '(4)': '④',
  '(5)': '⑤',
  '(6)': '⑥',
  '(7)': '⑦',
  '(8)': '⑧',
  '(9)': '⑨',
  'zad': '↓',
  'zal': '←',
  'zar': '→',
  'zau': '↑',
  'zdr': '↳',
  'zrd': '↴',
}

APPLESCRIPT = '''
  tell application "System Preferences"
    reveal anchor "text" of pane id "com.apple.preference.keyboard"
    activate
  end tell
'''

shortcuts = list()
for shortcut, phrase in REPLACEMENTS.items():
  shortcuts.append({'shortcut': shortcut, 'phrase': phrase})

_, path = tempfile.mkstemp(prefix='text-replacements-', suffix='.plist')
with open(path, 'wb') as file:
  plistlib.dump(shortcuts, file, sort_keys=False)

subprocess.run(['osascript'], input=APPLESCRIPT.encode())
subprocess.run(['open', '-R', path], check=True)
