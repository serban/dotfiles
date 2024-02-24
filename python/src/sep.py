#!/usr/bin/env py

# See "Box Drawing": https://www.unicode.org/charts/PDF/U2500.pdf

import argparse
import collections
import subprocess

Style = collections.namedtuple('Style', 'horizontal_line')

STYLES = {
    'ascii':       Style('-'),  # U+002D Hyphen-Minus
    'light':       Style('─'),  # U+2500 Box Drawings Light Horizontal
    'heavy':       Style('━'),  # U+2501 Box Drawings Heavy Horizontal
    'double':      Style('═'),  # U+2550 Box Drawings Double Horizontal
    'double-dash': Style('╌'),  # U+254C Box Drawings Light Double Dash Horizontal
    'triple-dash': Style('┄'),  # U+2504 Box Drawings Light Triple Dash Horizontal
    'quad-dash':   Style('┈'),  # U+2508 Box Drawings Light Quadruple Dash Horizontal
}

RESET  = '\033[0m'
BASE01 = '\033[32;1m'

def parse_command_line_arguments():
  parser = argparse.ArgumentParser(
      description='sep prints a nice horizontal line.')

  parser.add_argument(
      '-s', '--style', dest='style', choices=STYLES.keys(), default='light',
      help='the style of the line')

  parser.add_argument(
      '-l', '--light', dest='light', action='store_true',
      help='use a light color')

  width_group = parser.add_mutually_exclusive_group()

  width_group.add_argument(
      '-f', '--full-width', dest='full_width', action='store_true',
      help='use full terminal width')

  width_group.add_argument(
      '-w', '--width', dest='width', type=int, default=80,
      help='the width of the line')

  return parser.parse_args()

def main():
  args = parse_command_line_arguments()
  assert args.width > 0

  width = args.width if not args.full_width else int(
      subprocess.run(['stty', 'size'],
      capture_output=True).stdout.decode().split()[1])

  line = STYLES[args.style].horizontal_line * width

  if args.light:
    print(f'{BASE01}{line}{RESET}')
  else:
    print(line)

if __name__ == '__main__':
  main()
