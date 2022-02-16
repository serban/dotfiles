import sys
sys.dont_write_bytecode = True

import iterm2

import solarized

async def main(connection):
  app = await iterm2.async_get_app(connection)

  async with iterm2.NewSessionMonitor(connection) as new_session_monitor:
    while True:
      session_id = await new_session_monitor.async_get()
      session = app.get_session_by_id(session_id)
      theme = await app.async_get_theme()
      print(f'New Session: {session_id:<36}  Theme: {theme}')

      # Disable this script in favor of profiles with both dark and light colors
      print(f'→ NOP: Script is disabled in favor of profile Serban Solarized')
      continue

      await session.async_set_profile_properties(
          solarized.Profile(light='light' in theme))

if __name__ == '__main__':
  iterm2.run_forever(main)
