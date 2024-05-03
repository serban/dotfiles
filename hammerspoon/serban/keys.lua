local M = {}

local a = serban.actions
local g = serban.grid
local w = serban.windows

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

M.bind_pri("'",     function() g.moveFocusedWindow(g.kGridMaximized)    end)
M.bind_pri('8',     function() g.moveFocusedWindow(g.kGridCenterSkinny) end)
M.bind_pri('9',     function() g.moveFocusedWindow(g.kGridCenterTall)   end)
M.bind_pri('0',     function() g.moveFocusedWindow(g.kGridCenterRight)  end)
M.bind_pri('\\',    function() g.moveFocusedWindow(g.kGridCenterWide)   end)
M.bind_pri(';',     function() g.moveFocusedWindow(g.kGridCenter)       end)
M.bind_pri('left',  function() g.moveFocusedWindow(g.kGridLeft)         end)
M.bind_pri('right', function() g.moveFocusedWindow(g.kGridRight)        end)
M.bind_pri('up',    function() g.moveFocusedWindow(g.kGridTop)          end)
M.bind_pri('down',  function() g.moveFocusedWindow(g.kGridBottom)       end)
M.bind_pri('f9',    function() g.moveFocusedWindow(g.kGridTopLeft)      end)
M.bind_pri('f10',   function() g.moveFocusedWindow(g.kGridTopRight)     end)
M.bind_pri('f11',   function() g.moveFocusedWindow(g.kGridBottomLeft)   end)
M.bind_pri('f12',   function() g.moveFocusedWindow(g.kGridBottomRight)  end)

M.bind_pri('-',     function() w.stackFrontmostApplicationWindows() end)
M.bind_pri('=',     function() w.maximizeAllWindows() end)

M.bind_pri('1',     function() w.moveFocusedWindowToScreen(g.kScreenLeft) end)
M.bind_pri('2',     function() w.moveFocusedWindowToScreen(g.kScreenCenter) end)
M.bind_pri('3',     function() w.moveFocusedWindowToScreen(g.kScreenRight) end)

M.bind_pri('f1',    function() a.moveMouseToScreen(g.kScreenLeft) end)
M.bind_pri('f2',    function() a.moveMouseToScreen(g.kScreenCenter) end)
M.bind_pri('f3',    function() a.moveMouseToScreen(g.kScreenRight) end)

M.bind_pri('f8',    function() a.toggleDarkMode() end)

M.bind_pri('b',     function() a.activate('Firefox.app') end)
M.bind_pri('c',     function() a.activate('Google Chrome.app') end)
M.bind_pri('f',     function() a.activate('Finder.app') end)
M.bind_pri('g',     function() a.activate('Numbers.app') end)
M.bind_pri('h',     function() a.activate('Weather.app') end)
M.bind_pri('i',     function() a.activate('Maps.app') end)
M.bind_pri('j',     function() a.activate('Sublime Merge.app') end)
M.bind_pri('k',     function() a.activate('kitty.app') end)
M.bind_pri('l',     function() a.activate('Preview.app') end)
M.bind_pri('m',     function() a.activate('Messages.app') end)
M.bind_pri('n',     function() a.activate('Notes.app') end)
M.bind_pri('o',     function() a.activate('OmniFocus.app') end)
M.bind_pri('p',     function() a.activate('Photos.app') end)
M.bind_pri('q',     function() a.activate('Hammerspoon.app') end)
M.bind_pri('r',     function() a.activate('Calendar.app') end)
M.bind_pri('s',     function() a.activate('Safari.app') end)
M.bind_pri('t',     function() a.activate('iTerm.app') end)
M.bind_pri('u',     function() a.activate('UlyssesMac.app') end)
M.bind_pri('v',     function() a.activate('MacVim.app') end)
M.bind_pri('x',     function() a.activate('IINA.app') end)
M.bind_pri('y',     function() a.activate('Dictionary.app') end)
M.bind_pri('z',     function() a.activate('Zed.app') end)
M.bind_pri('4',     function() a.openFirefoxHomeTabs() end)
M.bind_pri('5',     function() a.openFirefoxChatTabs() end)
M.bind_pri('6',     function() a.openChromeHomeTabs() end)
M.bind_pri('7',     function() a.activate('TIDAL.app') end)

M.bind_sec('a',     function() a.activate('Activity Monitor.app') end)
M.bind_sec('c',     function() a.activate('Contacts.app') end)
M.bind_sec('f',     function() a.activate('FindMy.app') end)
M.bind_sec('o',     function() a.activate('Obsidian.app') end)
M.bind_sec('p',     function() a.activate('Photo Booth.app') end)
M.bind_sec('r',     function() a.activate('Reminders.app') end)
M.bind_sec('s',     function() a.activate('Signal.app') end)
M.bind_sec('v',     function() a.activate('Visual Studio Code.app') end)
M.bind_sec('w',     function() a.activate('WezTerm.app') end)
M.bind_sec('x',     function() a.activate('Xcode.app') end)
M.bind_sec('z',     function() a.highlightMousePointer() end)

return M
