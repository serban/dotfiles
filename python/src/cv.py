#!/usr/bin/env py

import dataclasses
import importlib.metadata
import re
import subprocess

import packaging.version

from serban.dotfiles.script import RESET, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN

VIM_REGEX = r'VIM - Vi IMproved (.+) \(.*\s.*\sIncluded patches: 1-(.+)'

@dataclasses.dataclass
class Package:
  name: str
  args: list[str]
  regx: str
  date: str
  okay: str
  want: str
  have: str = '∅'
  colo: str = RED
  mark: str = '✗'

packages = [
    Package('bat',       ['bat', '--version'],       r'bat (.+)',           '2024-06-30', '0.22.1',   '0.24.0'),
    Package('delta',     ['delta', '--version'],     r'delta (.+)',         '2024-06-30', '0.17.0',   '0.17.0'),
    Package('fd',        ['fd', '--version'],        r'fd(?:find)? (.+)',   '2024-06-30', '8.6.0',    '10.1.0'),
    Package('fish',      ['fish', '--version'],      r'fish, version (.+)', '2024-06-30', '3.6.0',    '3.7.1'),
    Package('fzf',       ['fzf', '--version'],       r'(.+) \(.*',          '2024-06-30', '0.38.0',   '0.53.0'),
    Package('git',       ['git', '--version'],       r'git version (.+)',   '2024-06-30', '2.39.2',   '2.45.2'),
    Package('less',      ['less', '--version'],      r'less (.+) \(.*',     '2024-06-30', '590',      '661'),
    Package('lf',        ['lf', '--version'],        r'r?(.+)',             '2024-06-30', '28',       '32'),
    Package('neovim',    ['nvim', '--version'],      r'NVIM v(.+)',         '2024-06-30', '0.10.0',   '0.10.0'),
    Package('python',    ['python3', '--version'],   r'Python (.+)',        '2024-06-30', '3.11.2',   '3.12.4'),
    Package('tmux',      ['tmux', '-V'],             r'tmux (.+)',          '2024-06-30', '3.3a',     '3.4'),
    Package('vim',       ['vim', '--version'],       VIM_REGEX,             '2024-06-30', '9.0.1378', '9.1.0500'),
    Package('watchexec', ['watchexec', '--version'], r'watchexec (\S+)',    '2024-06-30', '2.1.2',    '2.1.2'),
    Package('click',     None,                       None,                  '2024-06-30', '8.1.3',    '8.1.7'),
    Package('packaging', None,                       None,                  '2024-06-30', '23.0',     '24.1'),
    Package('pygit2',    None,                       None,                  '2024-07-30', '1.11.1',   '1.15.1'),
    Package('rich',      None,                       None,                  '2024-06-30', '13.3.1',   '13.7.1'),
    Package('wcwidth',   None,                       None,                  '2024-06-30', '0.2.5',    '0.2.13'),
]

for p in packages:
  if p.args:
    try:
      output = subprocess.run(
          p.args, check=True, stdout=subprocess.PIPE).stdout.decode().strip()
    except (FileNotFoundError, subprocess.CalledProcessError):
      continue

    m = re.match(p.regx, output)
    if not m:
      continue

    p.have = m.group(1) if p.name != 'vim' else f'{m.group(1)}.{m.group(2)}'
  else:
    p.have = importlib.metadata.version(p.name)

  okay = packaging.version.parse(p.okay)
  want = packaging.version.parse(p.want)

  try:
    have = packaging.version.parse(p.have)
  except packaging.version.InvalidVersion:
    have = packaging.version.parse('0')

  if have >= okay:
    p.colo = YELLOW
    p.mark = '·'

  if have == want:
    p.colo = GREEN
    p.mark = '✓'

  if have > want:
    p.colo = CYAN
    p.mark = '✓'

for p in packages:
  print(f'{p.colo}{p.mark}{RESET}  {p.name:9}  {p.okay:8}  {p.want:8}  {p.colo}{p.have:8}{RESET}')
