#!/usr/bin/env py

import argparse
import secrets
import string

ALPHABET = string.ascii_letters + string.digits

def parse_command_line_arguments():
  parser = argparse.ArgumentParser(
      description='Password Generator')

  parser.add_argument(
      '-c', '--count', dest='count', metavar='…', type=int, default=10,
      help='the number of passwords to generate')

  parser.add_argument(
      '-l', '--length', dest='length', metavar='…', type=int, default=32,
      help='the length of each password')

  parser.add_argument(
      '-v', '--verbose', dest='verbose', default=False, action='store_true',
      help='enable verbose output')

  return parser.parse_args()

def main():
  args = parse_command_line_arguments()

  if args.verbose:
    print('{:>{pad}}\n'.format(
        f'{len(ALPHABET) ** args.length:.1e} permutations', pad=args.length))

  for _ in range(args.count):
    print(''.join(secrets.choice(ALPHABET) for _ in range(args.length)))

if __name__ == '__main__':
  main()
