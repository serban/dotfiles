import pathlib
import platform
import time

import iterm2

COMMANDS_DIR = pathlib.Path(pathlib.Path.home(), 'src', 'private', 'iterm2')

async def main(connection):
  hostname = platform.node().split('.')[0]
  commands_path = COMMANDS_DIR / f'{hostname}.sh'

  with open(commands_path) as f:
    commands = [l for l in f.read().splitlines() if l and not l.startswith('#')]

  app = await iterm2.async_get_app(connection)

  window = await iterm2.Window.async_create(connection)
  default_tab = window.current_tab

  sessions = []
  for c in commands:
    tab = await window.async_create_tab()
    sessions.append(tab.current_session)

  await default_tab.async_close()

  time.sleep(1)

  for i, c in enumerate(commands):
    await sessions[i].async_send_text(c + '\n')

  await window.tabs[0].async_activate()

if __name__ == '__main__':
  iterm2.run_until_complete(main)
