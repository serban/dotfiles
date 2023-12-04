import pathlib
import time

import iterm2

COMMANDS_PATH = pathlib.Path(pathlib.Path.home(), 'ses', 'mingus.sh')

async def main(connection):
  with open(COMMANDS_PATH) as f:
    commands = [l for l in f.read().splitlines() if l and not l.startswith('#')]

  app = await iterm2.async_get_app(connection)

  window = await iterm2.Window.async_create(connection)
  default_tab = window.current_tab

  sessions = []
  for c in commands:
    tab = await window.async_create_tab('mingus')
    sessions.append(tab.current_session)

  await default_tab.async_close()

  time.sleep(1)

  for i, c in enumerate(commands):
    await sessions[i].async_send_text(c + '\n')

  tabs = list(window.tabs)
  for w in app.windows:
    for t in w.tabs:
      for s in t.sessions:
        p = await s.async_get_profile()
        if p.name == 'mingus' and w.window_id != window.window_id:
          tabs.append(t)

  await window.async_set_tabs(tabs)
  await window.tabs[0].async_activate()

if __name__ == '__main__':
  iterm2.run_until_complete(main)
