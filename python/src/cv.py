#!/usr/bin/env py

import argparse
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
  debi: str
  okay: str
  want: str
  have: str  = '∅'
  rece: bool = False
  colo: str  = RED
  mark: str  = '✗'

kPackages = [

  Package('bat',       ['bat', '--version'],       r'bat (.+)',           '2025-08-11', '0.25.0',   '0.25.0',   '0.25.0'),
  Package('btop',      ['btop', '--version'],      r'btop version: (.+)', '2025-12-27', '1.3.2',    '1.4.6',    '1.4.6'),
  Package('delta',     ['delta', '--version'],     r'delta (.+)',         '2025-08-11', '0.18.2',   '0.18.2',   '0.18.2'),
  Package('fd',        ['fd', '--version'],        r'fd(?:find)? (.+)',   '2025-08-11', '10.2.0',   '10.2.0',   '10.2.0'),
  Package('fish',      ['fish', '--version'],      r'fish, version (.+)', '2025-08-11', '4.0.2',    '4.0.2',    '4.0.2'),
  Package('fzf',       ['fzf', '--version'],       r'(.+) \(.*',          '2025-08-11', '0.60',     '0.60',     '0.65.1'),
  Package('git',       ['git', '--version'],       r'git version (.+)',   '2025-08-11', '2.47.2',   '2.47.2',   '2.50.1'),
  Package('less',      ['less', '--version'],      r'less (.+) \(.*',     '2025-08-11', '668',      '668',      '679'),
  Package('lf',        ['lf', '--version'],        r'r?(.+)',             '2025-08-11', '34',       '34',       '36'),
  Package('neovim',    ['nvim', '--version'],      r'NVIM v(.+)',         '2025-08-11', '0.10.4',   '0.10.4',   '0.11.3'),
  Package('python',    ['python3', '--version'],   r'Python (.+)',        '2025-08-11', '3.13.5',   '3.13.5',   '3.13.6'),
  Package('tmux',      ['tmux', '-V'],             r'tmux (.+)',          '2025-08-11', '3.5a',     '3.5a',     '3.5a'),
  Package('vim',       ['vim', '--version'],       VIM_REGEX,             '2025-08-11', '9.1.1244', '9.1.1244', '9.1.1600'),
  Package('watchexec', ['watchexec', '--version'], r'watchexec (\S+)',    '2025-08-11', '',         '2.3.2',    '2.3.2'),
  Package('click',     None,                       None,                  '2025-08-11', '8.1.8',    '8.1.8',    '8.2.1'),
  Package('packaging', None,                       None,                  '2025-08-11', '25.0',     '25.0',     '25.0'),
  Package('psutil',    None,                       None,                  '2025-08-11', '7.0.0',    '7.0.0',    '7.0.0'),
  Package('pygit2',    None,                       None,                  '2025-08-11', '1.17.0',   '1.17.0',   '1.18.1'),
  Package('rich',      None,                       None,                  '2025-08-11', '13.9.4',   '13.9.4',   '14.1.0'),
  Package('wcwidth',   None,                       None,                  '2025-08-11', '0.2.13',   '0.2.13',   '0.2.13'),

]

def bleach(s):
  return re.sub(r'\x1b\[[0-9;]*m', '', s)

def parse_command_line_arguments():
  parser = argparse.ArgumentParser(description='Version Checker')
  parser.color = True
  parser.add_argument(
      '-o', '--old', action='store_true', help='show obsolete packages only')
  return parser.parse_args()

def main():
  args = parse_command_line_arguments()

  for p in kPackages:
    if p.args:
      try:
        output = subprocess.run(
            p.args, check=True, stdout=subprocess.PIPE).stdout.decode().strip()
      except (FileNotFoundError, subprocess.CalledProcessError):
        continue

      m = re.match(p.regx, output)
      if not m:
        continue

      p.have = bleach(m[1]) if p.name != 'vim' else f'{m.group(1)}.{m.group(2)}'
    else:
      p.have = importlib.metadata.version(p.name)

    okay = packaging.version.parse(p.okay)
    want = packaging.version.parse(p.want)

    try:
      have = packaging.version.parse(p.have)
    except packaging.version.InvalidVersion:
      have = packaging.version.parse('0')

    if have >= okay:
      p.rece = True
      p.colo = YELLOW
      p.mark = '·'

    if have == want:
      p.rece = True
      p.colo = GREEN
      p.mark = '✓'

    if have > want:
      p.rece = True
      p.colo = CYAN
      p.mark = '✓'

  for p in kPackages:
    if args.old and p.rece:
      continue
    print(f'{p.colo}{p.mark}{RESET}  {p.name:9}  {p.debi:8}  {p.okay:8}  {p.want:8}  {p.colo}{p.have:8}{RESET}')

if __name__ == '__main__':
  main()
