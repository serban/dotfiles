#!/usr/bin/env py

import argparse

RESET  = '\033[0m'

SOLARIZED_ANSI_BACKGROUND_COLORS = {
    'base03    8': 100,  # base03 - bright black
    'base02    0':  40,  # base02 - black
    'base01   10': 102,  # base01 - bright green
    'base00   11': 103,  # base00 - bright yellow
    'base0    12': 104,  # base0  - bright blue
    'base1    14': 106,  # base1  - bright cyan
    'base2     7':  47,  # base2  - white
    'base3    15': 107,  # base3  - bright white
    'yellow    3':  43,  # yellow
    'orange    9': 101,  # orange - bright red
    'red       1':  41,  # red
    'magenta   5':  45,  # magenta
    'violet   13': 105,  # violet - bright magenta
    'blue      4':  44,  # blue
    'cyan      6':  46,  # cyan
    'green     2':  42,  # green
}

STYLES = {
    'Normal':                     '\033[0m',
    'Strikethrough':              '\033[9m',
    'Underline Single':           '\033[4m',
    'Underline Double':           '\033[21m',
    'Kitty Underline Single':     '\033[4:1m',
    'Kitty Underline Double':     '\033[4:2m',
    'Kitty Underline Curly':      '\033[4:3m',
    'Kitty Underline Dotted':     '\033[4:4m',
    'Kitty Underline Dashed':     '\033[4:5m',
}

COLORS = [
    ('Normal',                    '\033[0m'),
    ('Italic',                    '\033[3m'),
    ('Strikethrough',             '\033[9m'),
    ('Underline Single',          '\033[4m'),
    ('Underline Double',          '\033[21m'),
    ('Kitty Underline Single',    '\033[4:1m'),
    ('Kitty Underline Double',    '\033[4:2m'),
    ('Kitty Underline Curly',     '\033[4:3m'),
    ('Kitty Underline Dotted',    '\033[4:4m'),
    ('Kitty Underline Dashed',    '\033[4:5m'),
    ('Black',                     '\033[30m'),
    ('Red',                       '\033[31m'),
    ('Green',                     '\033[32m'),
    ('Yellow',                    '\033[33m'),
    ('Blue',                      '\033[34m'),
    ('Magenta',                   '\033[35m'),
    ('Cyan',                      '\033[36m'),
    ('White',                     '\033[37m'),
    ('Bright Black',              '\033[30;1m'),
    ('Bright Red',                '\033[31;1m'),
    ('Bright Green',              '\033[32;1m'),
    ('Bright Yellow',             '\033[33;1m'),
    ('Bright Blue',               '\033[34;1m'),
    ('Bright Magenta',            '\033[35;1m'),
    ('Bright Cyan',               '\033[36;1m'),
    ('Bright White',              '\033[37;1m'),
    ('Aixterm Black',             '\033[90m'),
    ('Aixterm Red',               '\033[91m'),
    ('Aixterm Green',             '\033[92m'),
    ('Aixterm Yellow',            '\033[93m'),
    ('Aixterm Blue',              '\033[94m'),
    ('Aixterm Magenta',           '\033[95m'),
    ('Aixterm Cyan',              '\033[96m'),
    ('Aixterm White',             '\033[97m'),
    ('Background Black',          '\033[40m'),
    ('Background Red',            '\033[41m'),
    ('Background Green',          '\033[42m'),
    ('Background Yellow',         '\033[43m'),
    ('Background Blue',           '\033[44m'),
    ('Background Magenta',        '\033[45m'),
    ('Background Cyan',           '\033[46m'),
    ('Background White',          '\033[47m'),
    ('Background Bright Black',   '\033[40;1m'),
    ('Background Bright Red',     '\033[41;1m'),
    ('Background Bright Green',   '\033[42;1m'),
    ('Background Bright Yellow',  '\033[43;1m'),
    ('Background Bright Blue',    '\033[44;1m'),
    ('Background Bright Magenta', '\033[45;1m'),
    ('Background Bright Cyan',    '\033[46;1m'),
    ('Background Bright White',   '\033[47;1m'),
    ('Background Aixterm Black',  '\033[100m'),
    ('Background Aixterm Red',    '\033[101m'),
    ('Background Aixterm Green',  '\033[102m'),
    ('Background Aixterm Yellow', '\033[103m'),
    ('Background Aixterm Blue',   '\033[104m'),
    ('Background Aixterm Magenta','\033[105m'),
    ('Background Aixterm Cyan',   '\033[106m'),
    ('Background Aixterm White',  '\033[107m'),
]

def print_table_header(columns):
  print(('{:11}  ' * len(columns)).format(*columns))
  print('─' * (13 * len(columns) - 2))

def parse_command_line_arguments():
  parser = argparse.ArgumentParser()
  group = parser.add_mutually_exclusive_group()

  group.add_argument(
      '-f', '--formatting', dest='formatting', action='store_true',
      help='print formatting tables')

  group.add_argument(
      '-s', '--solarized', dest='solarized', action='store_true',
      help='print Solarized tables')

  group.add_argument(
      '-v', '--verbose', dest='verbose', action='store_true',
      help='enable verbose output')

  return parser.parse_args()

def main():
  args = parse_command_line_arguments()

  if args.verbose:
    for name, escape_code in COLORS:
      print('{:26} : {}Lorem Ipsum{}'.format(name, escape_code, RESET))
  elif args.formatting:
    row_format = '{:24}  ' + '{}Lorem Ipsum{}  ' * 7

    print_table_header([
        'Style', '',
        'Normal     ', 'yellow    3', 'orange    9', 'red       1',
        'magenta   5', 'violet   13', 'blue      4',
        ])
    for style, escape_code in STYLES.items():
      print(row_format.format(
          style,
          escape_code,                   RESET,
          escape_code + '\033[58;5;3m',  RESET,  # yellow
          escape_code + '\033[58;5;9m',  RESET,  # orange
          escape_code + '\033[58;5;1m',  RESET,  # red
          escape_code + '\033[58;5;5m',  RESET,  # magenta
          escape_code + '\033[58;5;13m', RESET,  # violet
          escape_code + '\033[58;5;4m',  RESET,  # blue
          ))
  elif args.solarized:
    row_format = '{:11}  ' + '{}Lorem Ipsum{}  ' * 8

    print_table_header([
        '↓ bg · fg →',
        'base03    8', 'base02    0', 'base01   10', 'base00   11',
        'base0    12', 'base1    14', 'base2     7', 'base3    15',
        ])
    for color, i in SOLARIZED_ANSI_BACKGROUND_COLORS.items():
      print(row_format.format(
          color,
          '\033[30;1;' + str(      i) +   'm', RESET,  # base03 - bright black
          '\033[30;'   + str(      i) +   'm', RESET,  # base02 - black
          '\033[32;1;' + str(      i) +   'm', RESET,  # base01 - bright green
          '\033[33;1;' + str(      i) +   'm', RESET,  # base00 - bright yellow
          '\033[34;1;' + str(      i) +   'm', RESET,  # base0  - bright blue
          '\033[36;1;' + str(      i) +   'm', RESET,  # base1  - bright cyan
          '\033[37;'   + str(      i) +   'm', RESET,  # base2  - white
          '\033[37;1;' + str(      i) +   'm', RESET,  # base3  - bright white
          ))

    print()
    print_table_header([
        '↓ bg · fg →',
        'yellow    3', 'orange    9', 'red       1', 'magenta   5',
        'violet   13', 'blue      4', 'cyan      6', 'green     2',
        ])
    for color, i in SOLARIZED_ANSI_BACKGROUND_COLORS.items():
      print(row_format.format(
          color,
          '\033[33;'   + str(      i) +   'm', RESET,  # yellow
          '\033[31;1;' + str(      i) +   'm', RESET,  # orange - bright red
          '\033[31;'   + str(      i) +   'm', RESET,  # red
          '\033[35;'   + str(      i) +   'm', RESET,  # magenta
          '\033[35;1;' + str(      i) +   'm', RESET,  # violet - bright magenta
          '\033[34;'   + str(      i) +   'm', RESET,  # blue
          '\033[36;'   + str(      i) +   'm', RESET,  # cyan
          '\033[32;'   + str(      i) +   'm', RESET,  # green
          ))
  else:
    lorem_ipsum = '{}Lorem Ipsum{}  ' * 8

    print_table_header([
        'Foreground', 'Bright', 'Aixterm', 'Bright Aix',
        'Background', 'Bright', 'Aixterm', 'Bright Aix',
        ])
    for i in range(8):
      print(lorem_ipsum.format(
          '\033['      + str( 30 + i) +   'm', RESET,
          '\033['      + str( 30 + i) + ';1m', RESET,
          '\033['      + str( 90 + i) +   'm', RESET,
          '\033['      + str( 90 + i) + ';1m', RESET,
          '\033['      + str( 40 + i) +   'm', RESET,
          '\033['      + str( 40 + i) + ';1m', RESET,
          '\033['      + str(100 + i) +   'm', RESET,
          '\033['      + str(100 + i) + ';1m', RESET,
          ))

    print()
    print_table_header([
        'base03    8', 'base02    0', 'base01   10', 'base00   11',
        'base0    12', 'base1    14', 'base2     7', 'base3    15',
        ])
    for i in range(8):
      print(lorem_ipsum.format(
          '\033[30;1;' + str( 40 + i) +   'm', RESET,  # base03 - bright black
          '\033[30;'   + str( 40 + i) +   'm', RESET,  # base02 - black
          '\033[32;1;' + str( 40 + i) +   'm', RESET,  # base01 - bright green
          '\033[33;1;' + str( 40 + i) +   'm', RESET,  # base00 - bright yellow
          '\033[34;1;' + str( 40 + i) +   'm', RESET,  # base0  - bright blue
          '\033[36;1;' + str( 40 + i) +   'm', RESET,  # base1  - bright cyan
          '\033[37;'   + str( 40 + i) +   'm', RESET,  # base2  - white
          '\033[37;1;' + str( 40 + i) +   'm', RESET,  # base3  - bright white
          ))

    print()
    print_table_header([
        'base03  Aix', 'base02  Aix', 'base01  Aix', 'base00  Aix',
        'base0   Aix', 'base1   Aix', 'base2   Aix', 'base3   Aix',
        ])
    for i in range(8):
      print(lorem_ipsum.format(
          '\033[30;1;' + str(100 + i) +   'm', RESET,  # base03 - bright black
          '\033[30;'   + str(100 + i) +   'm', RESET,  # base02 - black
          '\033[32;1;' + str(100 + i) +   'm', RESET,  # base01 - bright green
          '\033[33;1;' + str(100 + i) +   'm', RESET,  # base00 - bright yellow
          '\033[34;1;' + str(100 + i) +   'm', RESET,  # base0  - bright blue
          '\033[36;1;' + str(100 + i) +   'm', RESET,  # base1  - bright cyan
          '\033[37;'   + str(100 + i) +   'm', RESET,  # base2  - white
          '\033[37;1;' + str(100 + i) +   'm', RESET,  # base3  - bright white
          ))

if __name__ == '__main__':
  main()
