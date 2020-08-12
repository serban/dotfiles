import iterm2

# https://stackoverflow.com/questions/29643352/converting-hex-to-rgb-value-in-python
def hex_to_rgb(color):
  return tuple(int(color[i:i+2], 16) for i in [0, 2, 4])

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

solarized_dark = iterm2.LocalWriteOnlyProfile()
solarized_dark.set_background_color(base03)
solarized_dark.set_foreground_color(base0)
solarized_dark.set_bold_color(base0)
solarized_dark.set_link_color(blue)
solarized_dark.set_cursor_color(base0)
solarized_dark.set_cursor_text_color(base03)
solarized_dark.set_selection_color(magenta)
solarized_dark.set_selected_text_color(base2)
solarized_dark.set_ansi_0_color(base02)
solarized_dark.set_ansi_1_color(red)
solarized_dark.set_ansi_2_color(green)
solarized_dark.set_ansi_3_color(yellow)
solarized_dark.set_ansi_4_color(blue)
solarized_dark.set_ansi_5_color(magenta)
solarized_dark.set_ansi_6_color(cyan)
solarized_dark.set_ansi_7_color(base2)
solarized_dark.set_ansi_8_color(base03)
solarized_dark.set_ansi_9_color(orange)
solarized_dark.set_ansi_10_color(base01)
solarized_dark.set_ansi_11_color(base00)
solarized_dark.set_ansi_12_color(base0)
solarized_dark.set_ansi_13_color(violet)
solarized_dark.set_ansi_14_color(base1)
solarized_dark.set_ansi_15_color(base3)

solarized_light = iterm2.LocalWriteOnlyProfile()
solarized_light.set_background_color(base3)
solarized_light.set_foreground_color(base00)
solarized_light.set_bold_color(base00)
solarized_light.set_link_color(blue)
solarized_light.set_cursor_color(base0)
solarized_light.set_cursor_text_color(base3)
solarized_light.set_selection_color(magenta)
solarized_light.set_selected_text_color(base3)
solarized_light.set_ansi_0_color(base2)
solarized_light.set_ansi_1_color(red)
solarized_light.set_ansi_2_color(green)
solarized_light.set_ansi_3_color(yellow)
solarized_light.set_ansi_4_color(blue)
solarized_light.set_ansi_5_color(magenta)
solarized_light.set_ansi_6_color(cyan)
solarized_light.set_ansi_7_color(base02)
solarized_light.set_ansi_8_color(base3)
solarized_light.set_ansi_9_color(orange)
solarized_light.set_ansi_10_color(base1)
solarized_light.set_ansi_11_color(base0)
solarized_light.set_ansi_12_color(base00)
solarized_light.set_ansi_13_color(violet)
solarized_light.set_ansi_14_color(base01)
solarized_light.set_ansi_15_color(base03)

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
                solarized_light if 'light' in theme else solarized_dark)

if __name__ == '__main__':
  iterm2.run_forever(main)
