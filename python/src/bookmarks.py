#!/usr/bin/env py

import json
import os
import sys

BOOKMARKS_PATH = os.path.expanduser('~/.local/share/bookmarks/bookmarks.json')


class Bookmarks:
  def __init__(self, path=None):
    if path is None:
      self.bookmarks = dict()
    else:
      self._load(path)

  def add(self, label, path):
    if not label:
      raise Exception("label must not be empty")

    if not path:
      raise Exception("path must not be empty")

    if label in self.bookmarks:
      raise Exception("The label %s already exists" % label)

    self.bookmarks[label] = os.path.normpath(path)

  def remove(self, label):
    if not label:
      raise Exception("label must not be empty")

    del self.bookmarks[label]

  def get(self, label):
    if not label:
      raise Exception("label must not be empty")

    return self.bookmarks[label]

  def labels(self):
    return sorted(self.bookmarks.keys())

  def all(self):
    return sorted(self.bookmarks.items())

  def save(self, path):
    with open(path, 'w') as f:
      json.dump(self.bookmarks, f, indent=2, sort_keys=True)

  def _load(self, path):
    with open(path, 'r') as f:
      self.bookmarks = json.load(f)


def print_help():
  help_string = """USAGE:
  bookmarks <command> [label] [path]

COMMANDS:
  add <label> [<path>]
  change <label> <path>
  remove <label>
  rename <label> <new-label>
  get <label>
  labels
  list"""

  print(help_string)


def get_command_line_args():
  arg_dict = dict()
  arg_list = sys.argv[1:]
  num_args = len(arg_list)

  if num_args > 0:
    arg_dict['command'] = sys.argv[1]

  if num_args > 1:
    arg_dict['label'] = sys.argv[2]

  if num_args > 2:
    arg_dict['path'] = sys.argv[3]

  return arg_dict


def main():
  args = get_command_line_args()

  command = args.get('command')
  label = args.get('label')
  path = args.get('path')

  command_list = [
    'add',
    'change',
    'remove',
    'rename',
    'get',
    'labels',
    'list',
  ]

  if command not in command_list:
    print_help()
    return

  try:
    bookmarks = Bookmarks(BOOKMARKS_PATH)
  except IOError:
    bookmarks = Bookmarks()

  if command == 'add':
    path = path or os.getcwd()
    bookmarks.add(label, path)
    bookmarks.save(BOOKMARKS_PATH)

  elif command == 'change':
    bookmarks.remove(label)
    bookmarks.add(label, path)
    bookmarks.save(BOOKMARKS_PATH)

  elif command == 'remove':
    bookmarks.remove(label)
    bookmarks.save(BOOKMARKS_PATH)

  elif command == 'rename':
    new_label = path  # TODO(serban): Clean up argument parsing
    bookmarks.add(new_label, bookmarks.get(label))
    bookmarks.remove(label)
    bookmarks.save(BOOKMARKS_PATH)

  elif command == 'get':
    print(bookmarks.get(label))

  elif command == 'labels':
    for label in bookmarks.labels():
      print(label)

  elif command == 'list':
    labels = bookmarks.labels()

    if len(labels) == 0:
      return

    max_label_length = len(max(labels, key=len))

    for label, path in bookmarks.all():
      print('{:<{pad}}    {}'.format(label, path, pad=max_label_length))


if __name__ == '__main__':
  main()
