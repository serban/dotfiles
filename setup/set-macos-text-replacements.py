#!/usr/bin/env py

import plistlib
import subprocess
import tempfile

REPLACEMENTS = {
  '(0)': '\u24ea',     # ⓪
  '(1)': '\u2460',     # ①
  '(2)': '\u2461',     # ②
  '(3)': '\u2462',     # ③
  '(4)': '\u2463',     # ④
  '(5)': '\u2464',     # ⑤
  '(6)': '\u2465',     # ⑥
  '(7)': '\u2466',     # ⑦
  '(8)': '\u2467',     # ⑧
  '(9)': '\u2468',     # ⑨

  '(r)': '\U0001f534', # 🔴
  '(o)': '\U0001f7e0', # 🟠
  '(y)': '\U0001f7e1', # 🟡
  '(g)': '\U0001f7e2', # 🟢
  '(b)': '\U0001f535', # 🔵
  '(p)': '\U0001f7e3', # 🟣

  'zad': '↓',
  'zal': '←',
  'zar': '→',
  'zau': '↑',
  'zdr': '↳',
  'zrd': '↴',

  'zk': ':black-ack',

  'zsh': r'¯\_(ツ)_/¯',
  'ztf': r'(ノಠ益ಠ )ノ彡 ┻━┻',
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
