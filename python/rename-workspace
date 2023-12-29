#!/usr/bin/env py

# TODO(serban): Add an option to insert at the destination rather than swap.

import json
import subprocess
import sys

I3MSG = 'i3-msg'
TMP_WORKSPACE = '99'


def main():
  new_workspace = sys.argv[1]

  workspaces = json.loads(
      subprocess.check_output([I3MSG, '-t', 'get_workspaces']).decode())

  for workspace in workspaces:
    if workspace.get('focused'):
      old_workspace = workspace.get('name')

  if new_workspace == old_workspace:
    return

  new_workspace_exists = len([workspace for workspace in workspaces
                              if workspace.get('name') == new_workspace]) > 0

  if new_workspace_exists:
    subprocess.call([I3MSG,
                     'rename workspace "{new}" to "{tmp}"; '
                     'rename workspace "{old}" to "{new}"; '
                     'rename workspace "{tmp}" to "{old}"; '.format(
                         old=old_workspace, new=new_workspace,
                         tmp=TMP_WORKSPACE)])
  else:
    subprocess.call([I3MSG,
                     'rename workspace "{old}" to "{new}"; '.format(
                         old=old_workspace, new=new_workspace)])


if __name__ == '__main__':
  main()
