import iterm2

async def main(connection):
  profile_delta = iterm2.LocalWriteOnlyProfile()
  profile_delta.set_normal_font('Monaco 10')

  app = await iterm2.async_get_app(connection)
  session = app.current_window.current_tab.current_session
  await session.async_set_profile_properties(profile_delta)

if __name__ == '__main__':
  iterm2.run_until_complete(main)
