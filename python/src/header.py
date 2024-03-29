#!/usr/bin/env py

# See "Box Drawing": https://www.unicode.org/charts/PDF/U2500.pdf

import argparse
import collections


Style = collections.namedtuple('Style',
  'horizontal_line vertical_line upper_left upper_right lower_left lower_right')

STYLES = {
    'ascii':  Style('-', '|', '+', '+', '+', '+'),
    'light':  Style('─', '│', '┌', '┐', '└', '┘'),
    'round':  Style('─', '│', '╭', '╮', '╰', '╯'),
    'heavy':  Style('━', '┃', '┏', '┓', '┗', '┛'),
    'double': Style('═', '║', '╔', '╗', '╚', '╝'),
}


def parse_command_line_arguments():
  parser = argparse.ArgumentParser(
      description='header prints a nice box around some text.')

  parser.add_argument(
      'text', nargs='*',
      help='The text to print.')

  parser.add_argument(
      '-s', '--style', dest='style', choices=STYLES.keys(), default='round',
      help='The style of the box.')

  parser.add_argument(
      '-w', '--width', dest='width', type=int, default=80,
      help='The width of the box.')

  return parser.parse_args()


def main():
  args = parse_command_line_arguments()

  t = ' '.join(args.text)
  s = STYLES[args.style]

  assert args.width > 4
  p = max(args.width - 4, len(t))

  print('{}{}{}'.format(s.upper_left, s.horizontal_line*(p+2), s.upper_right))
  print('{} {:{pad}} {}'.format(s.vertical_line, t, s.vertical_line, pad=p))
  print('{}{}{}'.format(s.lower_left, s.horizontal_line*(p+2), s.lower_right))


if __name__ == '__main__':
  main()
