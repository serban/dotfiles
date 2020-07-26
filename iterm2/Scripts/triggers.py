import iterm2

async def main(connection):
  profile_delta = iterm2.LocalWriteOnlyProfile()
  profile_delta.set_badge_text('◎')

  profile_delta.set_triggers([
      {'regex': '# waiting for changes', 'action': 'HighlightTrigger'},
      {'regex': '# waiting for changes', 'action': 'MarkTrigger', 'parameter': 0},
      {'regex': '# waiting for changes', 'action': 'BounceTrigger', 'parameter': 1},
  ])

  app = await iterm2.async_get_app(connection)
  session = app.current_terminal_window.current_tab.current_session
  await session.async_set_profile_properties(profile_delta)

if __name__ == '__main__':
  iterm2.run_until_complete(main)
