local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.color_scheme = 'Sea Shells (Gogh)'

config.font_size = 15.0

config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false

config.unicode_version = 14

return config
