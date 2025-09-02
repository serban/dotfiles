#!/usr/bin/env py

import os
import pathlib

from serban.dotfiles import script

KNOWN_DIRS = {

  '.Trash',               # macOS
  '.bash_sessions',       # macOS
  '.cache',               # XDG_CACHE_HOME
  '.config',              # XDG_CONFIG_HOME
  '.cups',                # 2023-10-29: https://github.com/OpenPrinting/libcups/issues/43 · https://github.com/OpenPrinting/libcups/pull/45
  '.gmailctl',            # 2023-10-29: https://github.com/mbrt/gmailctl/issues/144
  '.lldb',                # 2025-09-02: https://github.com/llvm/llvm-project/issues/71426
  '.local',               # XDG_DATA_HOME · XDG_STATE_HOME
  '.npm',                 # 2025-09-02: https://github.com/npm/rfcs/issues/389 · https://github.com/npm/rfcs/issues/586
  '.ssh',
  '.swiftpm',             # Swift Package Manager
  '.terminfo',            # 2023-10-29: https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos
  '.terraform.d',         # 2023-10-29: https://github.com/hashicorp/terraform/issues/15389
  '.vscode',

}

KNOWN_FILES = {

  '.CFUserTextEncoding',  # macOS
  '.DS_Store',            # macOS
  '.ICEauthority',
  '.Xauthority',
  '.bash_logout',
  '.bash_profile',
  '.bashrc',
  '.bazelrc',
  '.blazerc',
  '.g4d',
  '.hushlogin',           # shadow
  '.netrc',

}

def main():
  items = [i for i in os.scandir(pathlib.Path.home()) if i.name.startswith('.')]

  dirs = sorted({i.name for i in items if i.is_dir()} - KNOWN_DIRS)
  files = sorted({i.name for i in items if i.is_file()} - KNOWN_FILES)

  script.heading('Directories')
  script.bullets(dirs)

  script.heading('Files')
  script.bullets(files)

if __name__ == '__main__':
  main()
