local M = {}

M.nexus = hs.host.names()[1] == 'nexus.local'

M._modal_pri = hs.hotkey.modal.new('⌘', 'e', 'Hotkey')
M._modal_sec = hs.hotkey.modal.new('⌘', 'd', 'Hotkey')

function M._modal_pri:entered()
  hs.timer.doAfter(1.0, function() M._modal_pri:exit() end)
end

function M._modal_sec:entered()
  hs.timer.doAfter(1.0, function() M._modal_sec:exit() end)
end

function M.bind_pri(key, fn)
  hs.hotkey.bind('⌃⌥⇧⌘', key, fn)
  M._modal_pri:bind('', key, function() fn(); M._modal_pri:exit() end)
end

function M.bind_sec(key, fn)
  M._modal_sec:bind('', key, function() fn(); M._modal_sec:exit() end)
end

M.bind_pri("'",     function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 9}) end) -- Maximize
M.bind_pri('8',     function() hs.grid.set(hs.window.focusedWindow(), {2, 0, 3, 9}) end) -- Center Skinny
M.bind_pri('9',     function() hs.grid.set(hs.window.focusedWindow(), {1, 0, 5, 9}) end) -- Center Tall
M.bind_pri('0',     function() hs.grid.set(hs.window.focusedWindow(), {1, 0, 6, 9}) end) -- Center Right
M.bind_pri('\\',    function() hs.grid.set(hs.window.focusedWindow(), {0, 1, 7, 7}) end) -- Center Wide
M.bind_pri(';',     function() hs.grid.set(hs.window.focusedWindow(), {1, 1, 5, 7}) end) -- Center
M.bind_pri('left',  function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 3, 9}) end) -- Left
M.bind_pri('right', function() hs.grid.set(hs.window.focusedWindow(), {3, 0, 4, 9}) end) -- Right
M.bind_pri('up',    function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 5}) end) -- Top
M.bind_pri('down',  function() hs.grid.set(hs.window.focusedWindow(), {0, 5, 7, 4}) end) -- Bottom
M.bind_pri('f9',    function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 3, 5}) end) -- Top Left
M.bind_pri('f10',   function() hs.grid.set(hs.window.focusedWindow(), {3, 0, 4, 5}) end) -- Top Right
M.bind_pri('f11',   function() hs.grid.set(hs.window.focusedWindow(), {0, 5, 3, 4}) end) -- Bottom Left
M.bind_pri('f12',   function() hs.grid.set(hs.window.focusedWindow(), {3, 5, 4, 4}) end) -- Bottom Right

M.bind_pri('-',     function() stackApplicationWindows() end)
M.bind_pri('=',     function() maximizeWindows() end)

M.bind_pri('1',     function() moveFocusedWindowToScreen(serban.grid.kScreenLeft) end)
M.bind_pri('2',     function() moveFocusedWindowToScreen(serban.grid.kScreenCenter) end)
M.bind_pri('3',     function() moveFocusedWindowToScreen(serban.grid.kScreenRight) end)

M.bind_pri('f1',    function() moveMouseToScreen(serban.grid.kScreenLeft) end)
M.bind_pri('f2',    function() moveMouseToScreen(serban.grid.kScreenCenter) end)
M.bind_pri('f3',    function() moveMouseToScreen(serban.grid.kScreenRight) end)

M.bind_pri('f8',    function() hs.osascript.applescript('tell application "System Events" to tell appearance preferences to set dark mode to not dark mode') end)

M.bind_pri('b',     function() activate('Firefox.app') end)
M.bind_pri('c',     function() activate('Google Chrome.app') end)
M.bind_pri('f',     function() activate('Finder.app') end)
M.bind_pri('g',     function() activate('Numbers.app') end)
M.bind_pri('h',     function() activate('Weather.app') end)
M.bind_pri('i',     function() activate('Maps.app') end)
M.bind_pri('j',     function() activate('Sublime Merge.app') end)
M.bind_pri('k',     function() activate('kitty.app') end)
M.bind_pri('l',     function() activate('Preview.app') end)
M.bind_pri('m',     function() activate('Messages.app') end)
M.bind_pri('n',     function() activate('Notes.app') end)
M.bind_pri('o',     function() activate('OmniFocus.app') end)
M.bind_pri('p',     function() activate('Photos.app') end)
M.bind_pri('q',     function() activate('Hammerspoon.app') end)
M.bind_pri('r',     function() activate('Calendar.app') end)
M.bind_pri('s',     function() activate('Safari.app') end)
M.bind_pri('t',     function() activate('iTerm.app') end)
M.bind_pri('u',     function() activate('UlyssesMac.app') end)
M.bind_pri('v',     function() activate('MacVim.app') end)
M.bind_pri('x',     function() activate('IINA.app') end)
M.bind_pri('y',     function() activate('Dictionary.app') end)
M.bind_pri('z',     function() activate('Zed.app') end)
M.bind_pri('4',     function() openFirefoxHomeTabs() end)
M.bind_pri('5',     function() openFirefoxChatTabs() end)
M.bind_pri('6',     function() openChromeHomeTabs() end)
M.bind_pri('7',     function() activate('TIDAL.app') end)

M.bind_sec('a',     function() activate('Activity Monitor.app') end)
M.bind_sec('c',     function() activate('Contacts.app') end)
M.bind_sec('f',     function() activate('FindMy.app') end)
M.bind_sec('o',     function() activate('Obsidian.app') end)
M.bind_sec('p',     function() activate('Photo Booth.app') end)
M.bind_sec('r',     function() activate('Reminders.app') end)
M.bind_sec('v',     function() activate('Visual Studio Code.app') end)
M.bind_sec('w',     function() activate('WezTerm.app') end)
M.bind_sec('x',     function() activate('Xcode.app') end)
M.bind_sec('z',     function() highlightMousePointer() end)

return M
