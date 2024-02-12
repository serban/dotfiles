local M = {}

M.nexus = hs.host.names()[1] == 'nexus.local'

M._modal = hs.hotkey.modal.new('⌘', 'e', 'Hotkey')

function M._modal:entered()
  hs.timer.doAfter(1.0, function() M._modal:exit() end)
end

function M.bind(key, fn)
  hs.hotkey.bind('⌃⌥⇧⌘', key, fn)
  M._modal:bind('', key, function() fn(); M._modal:exit() end)
end

M.bind("'",     function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 9}) end) -- Maximize
M.bind('8',     function() hs.grid.set(hs.window.focusedWindow(), {2, 0, 3, 9}) end) -- Center Skinny
M.bind('9',     function() hs.grid.set(hs.window.focusedWindow(), {1, 0, 5, 9}) end) -- Center Tall
M.bind('0',     function() hs.grid.set(hs.window.focusedWindow(), {1, 0, 6, 9}) end) -- Center Right
M.bind('\\',    function() hs.grid.set(hs.window.focusedWindow(), {0, 1, 7, 7}) end) -- Center Wide
M.bind(';',     function() hs.grid.set(hs.window.focusedWindow(), {1, 1, 5, 7}) end) -- Center
M.bind('left',  function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 3, 9}) end) -- Left
M.bind('right', function() hs.grid.set(hs.window.focusedWindow(), {3, 0, 4, 9}) end) -- Right
M.bind('up',    function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 5}) end) -- Top
M.bind('down',  function() hs.grid.set(hs.window.focusedWindow(), {0, 5, 7, 4}) end) -- Bottom
M.bind('f9',    function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 3, 5}) end) -- Top Left
M.bind('f10',   function() hs.grid.set(hs.window.focusedWindow(), {3, 0, 4, 5}) end) -- Top Right
M.bind('f11',   function() hs.grid.set(hs.window.focusedWindow(), {0, 5, 3, 4}) end) -- Bottom Left
M.bind('f12',   function() hs.grid.set(hs.window.focusedWindow(), {3, 5, 4, 4}) end) -- Bottom Right

M.bind('-',     function() stackApplicationWindows() end)
M.bind('=',     function() maximizeWindows() end)

M.bind('1',     function() moveFocusedWindowToScreen(serban.grid.kScreenLeft) end)
M.bind('2',     function() moveFocusedWindowToScreen(serban.grid.kScreenCenter) end)
M.bind('3',     function() moveFocusedWindowToScreen(serban.grid.kScreenRight) end)

M.bind('f1',    function() moveMouseToScreen(serban.grid.kScreenLeft) end)
M.bind('f2',    function() moveMouseToScreen(serban.grid.kScreenCenter) end)
M.bind('f3',    function() moveMouseToScreen(serban.grid.kScreenRight) end)

M.bind('f8',    function() hs.osascript.applescript('tell application "System Events" to tell appearance preferences to set dark mode to not dark mode') end)

M.bind('b',     function() activate('Firefox.app') end)
M.bind('c',     function() activate('Google Chrome.app') end)
M.bind('f',     function() activate('Finder.app') end)
M.bind('g',     function() activate(M.nexus and 'Numbers.app' or 'Google Chat.app') end)
M.bind('h',     function() activate('Weather.app') end)
M.bind('i',     function() activate('Maps.app') end)
M.bind('j',     function() activate('Sublime Merge.app') end)
M.bind('k',     function() activate(M.nexus and 'Activity Monitor.app' or 'kitty.app') end)
M.bind('l',     function() activate('Preview.app') end)
M.bind('m',     function() activate('Messages.app') end)
M.bind('n',     function() activate('Notes.app') end)
M.bind('o',     function() activate('OmniFocus.app') end)
M.bind('p',     function() activate(M.nexus and 'Photos.app' or 'Photo Booth.app') end)
M.bind('q',     function() activate('Hammerspoon.app') end)
M.bind('r',     function() activate('Calendar.app') end)
M.bind('s',     function() activate(M.nexus and 'Safari.app' or 'Google Meet.app') end)
M.bind('t',     function() activate('iTerm.app') end)
M.bind('u',     function() activate(M.nexus and 'UlyssesMac.app' or 'Cider V.app') end)
M.bind('v',     function() activate('MacVim.app') end)
M.bind('x',     function() activate('IINA.app') end)
M.bind('y',     function() activate('Dictionary.app') end)
M.bind('z',     function() highlightMousePointer() end)
M.bind('4',     function() openFirefoxHomeTabs() end)
M.bind('5',     function() openFirefoxChatTabs() end)
M.bind('6',     function() openChromeHomeTabs() end)
M.bind('7',     function() activate('YouTube Music.app') end)

return M
