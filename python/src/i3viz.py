#!/usr/bin/env py

import argparse
import json
import os
import subprocess
import tempfile
import sys

I3MSG = 'i3-msg'
DOT = 'dot'
FEH = 'feh'

TEMP_DIR_PREFIX = 'i3viz-'
DOT_FILE_NAME = 'i3viz.dot'
PNG_FILE_NAME = 'i3viz.png'


def is_root(node):
  return node.get('type') == 'root'


def is_output(node):
  return node.get('type') == 'output'


def is_dockarea(node):
  return node.get('type') == 'dockarea'


def is_workspace_parent(node):
  return node.get('type') == 'con' and node.get('name') == 'content'


def is_workspace(node):
  return node.get('type') == 'workspace'


def is_container(node):
  return node.get('type') == 'con' and node.get('name') is None


def is_floating_container(node):
  return node.get('type') == 'floating_con'


def is_window(node):
  return node.get('window') is not None


def make_edges(node):
  """Return a list of Graphviz DOT edges (strings) of the provided subtree."""

  lines = []

  id = node.get('id', '')
  name = (node.get('name') or '').replace('"', '\\"')
  orientation = node.get('orientation', '')
  orientation = '' if orientation == 'none' else orientation
  instance = node.get('window_properties', {}).get('instance', '')

  node_shape = 'box'
  node_style = 'rounded,dotted'
  edge_style = 'solid'

  if (is_root(node) or
      is_output(node) or
      is_dockarea(node) or
      is_workspace_parent(node)):
    node_shape = 'box'
    node_style = 'rounded,dotted'
    edge_style = 'dotted'

  elif is_workspace(node):
    node_shape = 'diamond'
    node_style = 'bold'

  elif is_container(node):
    node_shape = 'box'
    node_style = 'dashed'
    name = 'container'

  elif is_floating_container(node):
    node_shape = 'ellipse'
    node_style = 'dashed'
    name = 'floating'

  elif is_window(node):
    node_shape = 'box'
    node_style = 'solid'

  lines.append(
      '"{id}" [label="{name:.20}\\n{orientation}\\n{instance}", '
      'shape="{node_shape}", style="{node_style}"];'.format(
          id=id, instance=instance, name=name, orientation=orientation,
          node_shape=node_shape, node_style=node_style))

  for child in node.get('nodes'):
    lines.append('"{id}" -> "{child_id}" [style="{edge_style}"];'.format(
        id=id, child_id=child.get('id'), edge_style=edge_style))
    lines.extend(make_edges(child))

  for child in node.get('floating_nodes'):
    lines.append('"{id}" -> "{child_id}" [style="{edge_style}"];'.format(
        id=id, child_id=child.get('id'), edge_style=edge_style))
    lines.extend(make_edges(child))

  return lines


def make_graph(nodes):
  """Return a string of the Graphviz DOT file containing the provided nodes."""

  lines = []
  lines.append('digraph {')

  for node in nodes:
    lines.extend(make_edges(node))

  lines.append('}')
  lines.append('')

  return '\n'.join(lines)


def find_all_workspaces(tree):
  """Return a list of all workspace nodes from the root of the i3 tree.

  Args:
    tree: The Python representation of `i3-msg -t get_tree`
  """

  workspaces = []

  if is_workspace(tree):
    workspaces.append(tree)
  else:
    for child in tree.get('nodes'):
      workspaces.extend(find_all_workspaces(child))

  return workspaces


def find_visible_workspaces(tree, workspaces):
  """Return a list of visible workspace nodes from the root of the i3 tree.

  Args:
    tree: The Python representation of `i3-msg -t get_tree`
    workspaces: The Python representation of `i3-msg -t get_workspaces`
  """

  visible_workspace_numbers = [
      workspace.get('num') for workspace in workspaces
      if workspace.get('visible')]

  visible_workspaces = [
      workspace for workspace in find_all_workspaces(tree)
      if workspace.get('num') in visible_workspace_numbers]

  return visible_workspaces


def find_focused_workspace(workspaces):
  """Return the integer workspace number of the focused workspace.

  Args:
    workspaces: The Python representation of `i3-msg -t get_workspaces`
  """

  for workspace in workspaces:
    if workspace.get('focused'):
      return workspace.get('num')


def find_workspace(tree, workspace_number):
  """Return the workspace node of the corresponding workspace number.

  Args:
    tree: The Python representation of `i3-msg -t get_tree`
    workspaces: The Python representation of `i3-msg -t get_workspaces`
  """

  for workspace in find_all_workspaces(tree):
    if workspace.get('num') == workspace_number:
      return workspace


def parse_command_line_arguments():
  """Parse command line arguments and return an argparse.Namespace object."""

  parser = argparse.ArgumentParser(
      description='Render the i3 tree.')

  modes = parser.add_mutually_exclusive_group()

  modes.add_argument(
      '-t', '--tree',
      action='store_true',
      help='Render the entire tree.')

  modes.add_argument(
      '-a', '--all-workspaces',
      action='store_true',
      help='Render all workspaces.')

  modes.add_argument(
      '-v', '--visible-workspaces',
      default=True, action='store_true',
      help='Render visible workspaces. (default)')

  modes.add_argument(
      '-f', '--forcused-workspace',
      action='store_true',
      help='Render the focused workspace.')

  parser.add_argument(
      '-d', '--debug',
      action='store_true',
      help='Enable debugging output.')

  return parser.parse_args()


def main():
  args = parse_command_line_arguments()

  tree = json.loads(
      subprocess.check_output([I3MSG, '-t', 'get_tree']).decode())
  workspaces = json.loads(
      subprocess.check_output([I3MSG, '-t', 'get_workspaces']).decode())


  if args.tree:
    dot_file_string = make_graph([tree])

  elif args.all_workspaces:
    all_workspaces = find_all_workspaces(tree)
    dot_file_string = make_graph(all_workspaces)

  elif args.visible_workspaces:
    visible_workspaces = find_visible_workspaces(tree, workspaces)
    dot_file_string = make_graph(visible_workspaces)

  elif args.focused_workspace:
    focused_workspace_number = find_focused_workspace(workspaces)
    focused_workspace = find_workspace(tree, focused_workspace_number)
    dot_file_string = make_graph([focused_workspace])


  with tempfile.TemporaryDirectory(prefix=TEMP_DIR_PREFIX) as temp_dir:
    dot_file_path = os.path.join(temp_dir, DOT_FILE_NAME)
    png_file_path = os.path.join(temp_dir, PNG_FILE_NAME)

    if args.debug:
      print(dot_file_string, file=sys.stderr)
      print(dot_file_path, file=sys.stderr)
      print(png_file_path, file=sys.stderr)

    with open(dot_file_path, 'w') as dot_file:
      dot_file.write(dot_file_string)

    subprocess.check_call([DOT, '-Tpng', '-o', png_file_path, dot_file_path])
    subprocess.check_call([FEH, '--borderless', png_file_path])


if __name__ == '__main__':
  main()
