import iterm2

# https://stackoverflow.com/questions/29643352/converting-hex-to-rgb-value-in-python
def hex_to_rgb(color):
  return tuple(int(color[i:i+2], 16) for i in [0, 2, 4])

async def main(connection):
  base03  = iterm2.Color(*hex_to_rgb('002b36'))
  base02  = iterm2.Color(*hex_to_rgb('073642'))
  base01  = iterm2.Color(*hex_to_rgb('586e75'))
  base00  = iterm2.Color(*hex_to_rgb('657b83'))
  base0   = iterm2.Color(*hex_to_rgb('839496'))
  base1   = iterm2.Color(*hex_to_rgb('93a1a1'))
  base2   = iterm2.Color(*hex_to_rgb('eee8d5'))
  base3   = iterm2.Color(*hex_to_rgb('fdf6e3'))
  yellow  = iterm2.Color(*hex_to_rgb('b58900'))
  orange  = iterm2.Color(*hex_to_rgb('cb4b16'))
  red     = iterm2.Color(*hex_to_rgb('dc322f'))
  magenta = iterm2.Color(*hex_to_rgb('d33682'))
  violet  = iterm2.Color(*hex_to_rgb('6c71c4'))
  blue    = iterm2.Color(*hex_to_rgb('268bd2'))
  cyan    = iterm2.Color(*hex_to_rgb('2aa198'))
  green   = iterm2.Color(*hex_to_rgb('859900'))

  profile_delta = iterm2.LocalWriteOnlyProfile()
  profile_delta.set_name('Serban Solarized Dark')
  profile_delta.set_allow_title_setting(True)
  profile_delta.set_badge_text('*')

  profile_delta.set_background_color(base03)
  profile_delta.set_foreground_color(base0)
  profile_delta.set_bold_color(base0)
  profile_delta.set_link_color(blue)
  profile_delta.set_cursor_color(base0)
  profile_delta.set_cursor_text_color(base03)
  profile_delta.set_selected_text_color(base2)
  profile_delta.set_selection_color(magenta)
  profile_delta.set_ansi_0_color(base02)
  profile_delta.set_ansi_1_color(red)
  profile_delta.set_ansi_2_color(green)
  profile_delta.set_ansi_3_color(yellow)
  profile_delta.set_ansi_4_color(blue)
  profile_delta.set_ansi_5_color(magenta)
  profile_delta.set_ansi_6_color(cyan)
  profile_delta.set_ansi_7_color(base2)
  profile_delta.set_ansi_8_color(base03)
  profile_delta.set_ansi_9_color(orange)
  profile_delta.set_ansi_10_color(base01)
  profile_delta.set_ansi_11_color(base00)
  profile_delta.set_ansi_12_color(base0)
  profile_delta.set_ansi_13_color(violet)
  profile_delta.set_ansi_14_color(base1)
  profile_delta.set_ansi_15_color(base3)

  profile_delta.set_use_tab_color(False)
  profile_delta.set_use_cursor_guide(False)
  profile_delta.set_use_underline_color(False)

  # profile_delta.set_cursor_type(iterm2.CursorType.CURSOR_TYPE_BOX)
  profile_delta.set_blinking_cursor(False)
  profile_delta.set_use_bold_font(True)
  profile_delta.set_use_bright_bold(False)
  profile_delta.set_use_italic_font(True)
  profile_delta.set_blink_allowed(False)

  profile_delta.set_unlimited_scrollback(True)
  profile_delta.set_mouse_reporting(True)
  profile_delta.set_mouse_reporting_allow_mouse_wheel(True)
  profile_delta.set_silence_bell(False)
  profile_delta.set_bm_growl(False)
  profile_delta.set_flashing_bell(False)
  profile_delta.set_visual_bell(True)

  profile_delta.set_close_sessions_on_end(True)
  profile_delta.set_prompt_before_closing(False)
  profile_delta.set_send_session_ended_alert(False)
  profile_delta.set_session_close_undo_timeout(60)

  app = await iterm2.async_get_app(connection)
  session = app.current_terminal_window.current_tab.current_session
  await session.async_set_profile_properties(profile_delta)

  async with iterm2.NewSessionMonitor(connection) as new_session_monitor:
    while True:
      session_id = await new_session_monitor.async_get()
      print('New Session: {:<36}'.format(session_id))
      session = app.get_session_by_id(session_id)
      await session.async_set_profile_properties(profile_delta)

if __name__ == '__main__':
  iterm2.run_forever(main)
