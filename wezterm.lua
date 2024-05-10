-- https://wezfurlong.org/wezterm/config/lua/config/index.html
--
-- https://wezfurlong.org/wezterm/config/keyboard-concepts.html
-- https://wezfurlong.org/wezterm/config/key-encoding.html
-- https://wezfurlong.org/wezterm/config/keys.html
-- https://wezfurlong.org/wezterm/config/default-keys.html
-- https://wezfurlong.org/wezterm/config/lua/keyassignment/index.html
-- https://wezfurlong.org/wezterm/config/lua/keyassignment/SendString.html
-- https://wezfurlong.org/wezterm/config/lua/keyassignment/SpawnCommandInNewTab.html
-- https://wezfurlong.org/wezterm/config/lua/SpawnCommand.html
--
-- https://wezfurlong.org/wezterm/config/lua/config/default_cwd.html

local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- https://wezfurlong.org/wezterm/config/lua/config/term.html
-- macOS: Compile the terminfo entry to ~/.terminfo/*/wezterm:
-- /usr/bin/tic -x ~/oss/wezterm/termwiz/data/wezterm.terminfo
config.term = 'wezterm'

config.color_scheme = 'Sea Shells (Gogh)'

config.font_size = 15.0

config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false

config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.enable_csi_u_key_encoding = true
config.enable_kitty_keyboard = true

config.keys = {

  { mods='CMD',           key='t',  action=wezterm.action.SpawnCommandInNewTab({cwd=wezterm.home_dir})  },

  { mods='CTRL',          key='0',  action=wezterm.action.SendString('\x1b[48;5u')  },
  { mods='CTRL',          key='1',  action=wezterm.action.SendString('\x1b[49;5u')  },
  { mods='CTRL',          key='2',  action=wezterm.action.SendString('\x1b[50;5u')  },
  { mods='CTRL',          key='3',  action=wezterm.action.SendString('\x1b[51;5u')  },
  { mods='CTRL',          key='4',  action=wezterm.action.SendString('\x1b[52;5u')  },
  { mods='CTRL',          key='5',  action=wezterm.action.SendString('\x1b[53;5u')  },
  { mods='CTRL',          key='6',  action=wezterm.action.SendString('\x1b[54;5u')  },
  { mods='CTRL',          key='7',  action=wezterm.action.SendString('\x1b[55;5u')  },
  { mods='CTRL',          key='8',  action=wezterm.action.SendString('\x1b[56;5u')  },
  { mods='CTRL',          key='9',  action=wezterm.action.SendString('\x1b[57;5u')  },

  { mods='CTRL | META',   key='0',  action=wezterm.action.SendString('\x1b[48;7u')  },
  { mods='CTRL | META',   key='1',  action=wezterm.action.SendString('\x1b[49;7u')  },
  { mods='CTRL | META',   key='2',  action=wezterm.action.SendString('\x1b[50;7u')  },
  { mods='CTRL | META',   key='3',  action=wezterm.action.SendString('\x1b[51;7u')  },
  { mods='CTRL | META',   key='4',  action=wezterm.action.SendString('\x1b[52;7u')  },
  { mods='CTRL | META',   key='5',  action=wezterm.action.SendString('\x1b[53;7u')  },
  { mods='CTRL | META',   key='6',  action=wezterm.action.SendString('\x1b[54;7u')  },
  { mods='CTRL | META',   key='7',  action=wezterm.action.SendString('\x1b[55;7u')  },
  { mods='CTRL | META',   key='8',  action=wezterm.action.SendString('\x1b[56;7u')  },
  { mods='CTRL | META',   key='9',  action=wezterm.action.SendString('\x1b[57;7u')  },

}

config.unicode_version = 14

return config
