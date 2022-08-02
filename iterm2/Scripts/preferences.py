# https://github.com/gnachman/iTerm2/blob/master/api/library/python/iterm2/iterm2/preferences.py
#
# ╭────────────────────────────────────────────────────────────────────────────╮
# │ Advanced Settings                                                          │
# ╰────────────────────────────────────────────────────────────────────────────╯
#    General › Synchronize search queries across windows and applications › No
#   Terminal › Use P3 as default color space? If No, sRGB will be used.   › No
#   Warnings › Suppress the notification asking if you want to disable    › Yes
#            › mouse reporting that is shown after a drag followed by
#            › Cmd-C when mouse reporting is on?

import iterm2

from iterm2.preferences import PreferenceKey

PREFERENCES = {
  PreferenceKey.OPEN_PROFILES_WINDOW_AT_START:            False,
  PreferenceKey.OPEN_DEFAULT_ARRANGEMENT_AT_START:        False,
  PreferenceKey.RESTORE_ONLY_HOTKEY_AT_START:             True,
  PreferenceKey.QUIT_WHEN_ALL_WINDOWS_CLOSED:             False,
  PreferenceKey.ONLY_WHEN_MORE_TABS:                      True,
  PreferenceKey.PROMPT_ON_QUIT:                           True,
# PreferenceKey.INSTANT_REPLAY_MEMORY_MB:                 4.0,
  PreferenceKey.SAVE_PASTE_HISTORY:                       False,
  PreferenceKey.ENABLE_BONJOUR_DISCOVERY:                 False,
  PreferenceKey.SOFTWARE_UPDATE_ENABLE_AUTOMATIC_CHECKS:  True,
  PreferenceKey.SOFTWARE_UPDATE_ENABLE_TEST_RELEASES:     True,
  PreferenceKey.LOAD_PREFS_FROM_CUSTOM_FOLDER:            False,
# PreferenceKey.CUSTOM_FOLDER_TO_LOAD_PREFS_FROM:         '',
  PreferenceKey.COPY_TO_PASTEBOARD_ON_SELECTION:          True,
  PreferenceKey.INCLUDE_TRAILING_NEWLINE_WHEN_COPYING:    False,
  PreferenceKey.APPS_MAY_ACCESS_PASTEBOARD:               True,
  PreferenceKey.WORD_CHARACTERS:                          '/-+\\~_.',
  PreferenceKey.ENABLE_SMART_WINDOW_PLACEMENT:            False,
  PreferenceKey.ADJUST_WINDOW_FOR_FONT_SIZE_CHANGE:       False,
  PreferenceKey.MAX_VERTICALLY:                           False,
  PreferenceKey.NATIVE_FULL_SCREEN_WINDOWS:               True,
# PreferenceKey.OPEN_TMUX_WINDOWS_IN:                     1,      # Tabs In A New Window
# PreferenceKey.TMUX_DASHBOARD_LIMIT:                     10,
# PreferenceKey.AUTO_HIDE_TMUX_CLIENT_SESSION:            False,
# PreferenceKey.USE_TMUX_PROFILE:                         True,
# PreferenceKey.USE_METAL:                                True,
# PreferenceKey.DISABLE_METAL_WHEN_UNPLUGGED:             True,
# PreferenceKey.PREFER_INTEGRATED_GPU:                    True,
# PreferenceKey.METAL_MAXIMIZE_THROUGHPUT:                True,
  PreferenceKey.THEME:                                    5,      # Minimal
  PreferenceKey.TAP_BAR_POSTIION:                         0,      # Top
  PreferenceKey.HIDE_TAB_BAR_WHEN_ONLY_ONE_TAB:           True,
  PreferenceKey.HIDE_TAB_NUMBER:                          True,
  PreferenceKey.HIDE_TAB_CLOSE_BUTTON:                    False,
  PreferenceKey.HIDE_TAB_ACTIVITY_INDICATOR:              True,
  PreferenceKey.SHOW_TAB_NEW_OUTPUT_INDICATOR:            False,
  PreferenceKey.SHOW_PANE_TITLES:                         False,
  PreferenceKey.STRETCH_TABS_TO_FILL_BAR:                 True,
  PreferenceKey.HIDE_MENU_BAR_IN_FULLSCREEN:              True,
  PreferenceKey.HIDE_FROM_DOCK_AND_APP_SWITCHER:          False,
  PreferenceKey.FLASH_TAB_BAR_IN_FULLSCREEN:              False,
  PreferenceKey.WINDOW_NUMBER:                            True,
  PreferenceKey.DIM_ONLY_TEXT:                            True,
  PreferenceKey.SPLIT_PANE_DIMMING_AMOUNT:                0.4,
  PreferenceKey.DIM_INACTIVE_SPLIT_PANES:                 True,
  PreferenceKey.DRAW_WINDOW_BORDER:                       False,
  PreferenceKey.HIDE_SCROLLBAR:                           False,
# PreferenceKey.DISABLE_FULLSCREEN_TRANSPARENCY:          False,
  PreferenceKey.ENABLE_DIVISION_VIEW:                     False,
# PreferenceKey.ENABLE_PROXY_ICON:                        False,
  PreferenceKey.DIM_BACKGROUND_WINDOWS:                   False,
  PreferenceKey.CONTROL_REMAPPING:                        1,      # ⌃ Control
  PreferenceKey.LEFT_OPTION_REMAPPING:                    2,      # ⌥ Left Option
  PreferenceKey.RIGHT_OPTION_REMAPPING:                   3,      # ⌥ Right Option
  PreferenceKey.LEFT_COMMAND_REMAPPING:                   7,      # ⌘ Left Command
  PreferenceKey.RIGHT_COMMAND_REMAPPING:                  8,      # ⌘ Right Command
  PreferenceKey.SWITCH_PANE_MODIFIER:                     9,      # ∅ No Shortcut
  PreferenceKey.SWITCH_TAB_MODIFIER:                      4,      # ⌘ Command
  PreferenceKey.SWITCH_WINDOW_MODIFIER:                   6,      # ⌥ ⌘ Option + Command
  PreferenceKey.ENABLE_SEMANTIC_HISTORY:                  True,
  PreferenceKey.PASS_ON_CONTROL_CLICK:                    True,
  PreferenceKey.OPTION_CLICK_MOVES_CURSOR:                False,
  PreferenceKey.THREE_FINGER_EMULATES:                    False,
  PreferenceKey.FOCUS_FOLLOWS_MOUSE:                      False,
  PreferenceKey.TRIPLE_CLICK_SELECTS_FULL_WRAPPED_LINES:  True,
  PreferenceKey.DOUBLE_CLICK_PERFORMS_SMART_SELECTION:    True,
# PreferenceKey.AUTO_COMMAND_HISTORY:                     False,
# PreferenceKey.PASTE_SPECIAL_CHUNK_SIZE:                 1024,
# PreferenceKey.PASTE_SPECIAL_CHUNK_DELAY:                0.01,
  PreferenceKey.NUMBER_OF_SPACES_PER_TAB:                 2,
  PreferenceKey.TAB_TRANSFORM:                            1,      # Convert Tabs To Spaces
  PreferenceKey.ESCAPE_SHELL_CHARS_WITH_BACKSLASH:        False,
  PreferenceKey.CONVERT_UNICODE_PUNCTUATION:              False,
  PreferenceKey.CONVERT_DOS_NEWLINES:                     True,
  PreferenceKey.REMOVE_CONTROL_CODES:                     True,
  PreferenceKey.BRACKETED_PASTE_MODE:                     True,
  PreferenceKey.PASTE_SPECIAL_USE_REGEX_SUBSTITUTION:     False,
# PreferenceKey.PASTE_SPECIAL_REGEX:                      '',
# PreferenceKey.PASTE_SPECIAL_SUBSTITUTION:               '',
# PreferenceKey.LEFT_TAB_BAR_WIDTH:                       150,
  PreferenceKey.PASTE_TAB_TO_STRING_TAB_STOP_SIZE:        2,
  PreferenceKey.SHOW_FULL_SCREEN_TAB_BAR:                 False,
# PreferenceKey.DEFAULT_TOOLBELT_WIDTH:                   250,
  PreferenceKey.STATUS_BAR_POSITION:                      1,      # Bottom
  PreferenceKey.PRESERVE_WINDOW_SIZE_WHEN_TAB_BAR_VISIBILITY_CHANGES: True,
  PreferenceKey.PER_PANE_BACKGROUND_IMAGE:                False,
  PreferenceKey.PER_PANE_STATUS_BAR:                      False,
  PreferenceKey.EMULATE_US_KEYBOARD:                      False,
  PreferenceKey.TEXT_SIZE_CHANGES_AFFECT_PROFILE:         False,
# PreferenceKey.ACTIONS:                                  None,
  PreferenceKey.HTML_TAB_TITLES:                          False,
# PreferenceKey.DISABLE_TRANSPARENCY_FOR_KEY_WINDOW:      False,
}

async def main(connection):
  for key in PreferenceKey:
    out = await iterm2.preferences.async_get_preference(connection, key)
    print(f'{str(key) + ":":54}  {repr(out)},')

  for key, value in PREFERENCES.items():
    await iterm2.preferences.async_set_preference(connection, key.value, value)

if __name__ == '__main__':
  iterm2.run_until_complete(main)
