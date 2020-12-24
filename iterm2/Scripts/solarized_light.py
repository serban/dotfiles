import iterm2

import solarized

async def main(connection):
  profile_delta = solarized.Profile(light=True)

  app = await iterm2.async_get_app(connection)

  for window in app.windows:
    for tab in window.tabs:
      for session in tab.sessions:
        await session.async_set_profile_properties(profile_delta)

if __name__ == '__main__':
  iterm2.run_until_complete(main)
