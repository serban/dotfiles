#!/usr/bin/env py

import argparse
import secrets
import string

kAlphabets = {

  'alphanumeric': string.digits + string.ascii_letters,
  'lowernumeric': string.digits + string.ascii_lowercase,
  'numeric':      string.digits,

}

def parse_command_line_arguments():
  parser = argparse.ArgumentParser(
      description='Password Generator')

  parser.add_argument(
      '-a', '--alphabet', dest='alphabet',
      choices=kAlphabets.keys(), default='alphanumeric',
      help='the alphabet from which to choose password characters')

  parser.add_argument(
      '-c', '--count', dest='count', metavar='…', type=int, default=10,
      help='the number of passwords to generate')

  parser.add_argument(
      '-l', '--length', dest='length', metavar='…', type=int, default=32,
      help='the length of each password')

  parser.add_argument(
      '-n', '--numeric', dest='alphabet', action='store_const', const='numeric',
      help='an alias for --alphabet=numeric')

  parser.add_argument(
      '-s', '--short', dest='length', action='store_const', const=6,
      help='an alias for --length=6')

  parser.add_argument(
      '-v', '--verbose', dest='verbose', default=False, action='store_true',
      help='enable verbose output')

  return parser.parse_args()

def main():
  args = parse_command_line_arguments()
  alphabet = kAlphabets[args.alphabet]

  if args.verbose:
    print('{:>{pad}}\n'.format(
        f'{len(alphabet) ** args.length:.1e} permutations', pad=args.length))

  for _ in range(args.count):
    print(''.join(secrets.choice(alphabet) for _ in range(args.length)))

if __name__ == '__main__':
  main()
