import sys
sys.dont_write_bytecode = True

import iterm2

import solarized

async def main(connection):
  app = await iterm2.async_get_app(connection)

  async with iterm2.VariableMonitor(
      connection, iterm2.VariableScopes.APP, 'effectiveTheme', None) as monitor:
    while True:
      theme = await monitor.async_get()
      print(f'Theme Change: {theme}')

      for window in app.windows:
        for tab in window.tabs:
          for session in tab.sessions:
            await session.async_set_profile_properties(
                solarized.Profile(light='light' in theme))

if __name__ == '__main__':
  iterm2.run_forever(main)
