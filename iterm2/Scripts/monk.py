import pathlib
import time

import iterm2

COMMANDS_PATH = pathlib.Path(pathlib.Path.home(), 'tmp', 'monk.sh')

async def main(connection):
  with open(COMMANDS_PATH) as f:
    commands = [l for l in f.read().splitlines() if l and not l.startswith('#')]

  app = await iterm2.async_get_app(connection)

  sessions = []
  for c in commands:
    tab = await app.current_window.async_create_tab('monk')
    sessions.append(tab.current_session)

  time.sleep(1)

  for i, c in enumerate(commands):
    await sessions[i].async_send_text(c + '\n')

if __name__ == '__main__':
  iterm2.run_until_complete(main)
