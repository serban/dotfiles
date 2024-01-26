serban = {}

hs.logger.setGlobalLogLevel('warning') -- error, warning, info, debug, verbose
serban.logger = hs.logger.new('serban', 'info') -- Quiet all loggers but mine

serban.screen = require('serban.screen')

hs.window.animationDuration = 0

hs.grid.setGrid('7x9')
hs.grid.setMargins('6x6')

function b(v)
  if     v == nil then return '∅' -- utf8.len('∅') → 1, string.len('∅') → 3
  elseif v == true then return '✓' -- utf8.len('✓') → 1, string.len('✓') → 3
  elseif v == false then return '✗' -- utf8.len('✗') → 1, string.len('✗') → 3
  else return '?'
  end
end

local nexus = hs.host.names()[1] == 'nexus.local'
local modal = hs.hotkey.modal.new('⌘', 'e', 'Hotkey')

function modal:entered()
  hs.timer.doAfter(1, function() modal:exit() end)
end

function bind(key, fn)
  hs.hotkey.bind('⌃⌥⇧⌘', key, fn)
  modal:bind('', key, function() fn(); modal:exit() end)
end

function activate(name)
  hs.application.launchOrFocus(name)
  hs.application.frontmostApplication():activate(true)
end

function stackApplicationWindows()
  local app = hs.application.frontmostApplication()
  app:activate(true)

  for _, s in pairs(hs.screen.allScreens()) do
    local windows = {}
    for _, w in pairs(app:visibleWindows()) do
      if w:screen() == s then
        table.insert(windows, w)
      end
    end

    local l = #windows
    if l > 1 then
      for i, w in ipairs(windows) do
        hs.grid.set(w, {0, 0, 5, 7})
        w:setTopLeft(s:frame() + {6 + 43*(l-i), 6 + 43*(l-i)})
      end
    end
  end
end

function maximizeWindows()
  for _, w in pairs(hs.window.allWindows()) do
    local a = w:application():name()
    if a ~= 'Finder' and a ~= 'Audio Hijack' and a ~= 'Hammerspoon' then
      hs.grid.set(w, {0, 0, 7, 9})
    end
  end
end

function highlightMousePointer()
  local m = hs.mouse.absolutePosition()
  hs.canvas.new({x=m.x-150, y=m.y-150, w=300, h=300}):appendElements({
    type='circle', action='fill', fillColor={hex='#ff4081', alpha=0.5}, -- 2014 Material Design A200
  }):show():delete(0.75)
end

function moveMouseToScreen(hint)
  local s = hs.screen(hint)
  local f = s:fullFrame()
  local x, y = f.w // 2, f.h // 2
  serban.logger.df(
      ' Mouse → %23s [%4d×%4d] › Mouse → (%4d, %4d)',
      s:name(), f.w, f.h, x, y)
  hs.mouse.setRelativePosition(hs.geometry(x, y), s)
  highlightMousePointer()
end

function moveFocusedWindowToScreen(hint)
  local w = hs.window.focusedWindow()
  local s = hs.screen(hint)
  local f = s:fullFrame()
  local x, y = f.w // 2, f.h // 2
  serban.logger.df(
      'Window → %23s [%4d×%4d] › Mouse → (%4d, %4d) › %s',
      s:name(), f.w, f.h, x, y, w:title())
  w:moveToScreen(s, false, true)
  hs.grid.maximizeWindow()
  hs.mouse.setRelativePosition(hs.geometry(x, y), s)
end

function openFirefoxHomeTabs()
  activate('Firefox.app')
  os.execute(table.concat({'/Applications/Firefox.app/Contents/MacOS/firefox',
      'https://mail.google.com/mail/u/0/#inbox',
      'https://calendar.google.com/calendar/u/0/r/month',
      'https://app.ynab.com',
  }, ' '))
  hs.timer.doAfter(0.2, function()
    hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 9})
  end)
end

function openFirefoxChatTabs()
  activate('Firefox.app')
  os.execute(table.concat({'/Applications/Firefox.app/Contents/MacOS/firefox',
      'https://web.whatsapp.com',
      'https://www.messenger.com',
  }, ' '))
  hs.timer.doAfter(0.2, function()
    hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 9})
  end)
end

function openChromeHomeTabs()
  activate('Google Chrome.app')
  os.execute(table.concat({
      '"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"',
          '--new-window',
          'https://calendar.google.com/calendar/u/0/r/week',
          'https://mail.google.com/mail/u/0/#inbox',
  }, ' '))
  hs.timer.doAfter(0.2, function()
    hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 9})
  end)
end

bind("'",     function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 9}) end) -- Maximize
bind('8',     function() hs.grid.set(hs.window.focusedWindow(), {2, 0, 3, 9}) end) -- Center Skinny
bind('9',     function() hs.grid.set(hs.window.focusedWindow(), {1, 0, 5, 9}) end) -- Center Tall
bind('0',     function() hs.grid.set(hs.window.focusedWindow(), {1, 0, 6, 9}) end) -- Center Right
bind('\\',    function() hs.grid.set(hs.window.focusedWindow(), {0, 1, 7, 7}) end) -- Center Wide
bind(';',     function() hs.grid.set(hs.window.focusedWindow(), {1, 1, 5, 7}) end) -- Center
bind('left',  function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 3, 9}) end) -- Left
bind('right', function() hs.grid.set(hs.window.focusedWindow(), {3, 0, 4, 9}) end) -- Right
bind('up',    function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 5}) end) -- Top
bind('down',  function() hs.grid.set(hs.window.focusedWindow(), {0, 5, 7, 4}) end) -- Bottom
bind('f9',    function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 3, 5}) end) -- Top Left
bind('f10',   function() hs.grid.set(hs.window.focusedWindow(), {3, 0, 4, 5}) end) -- Top Right
bind('f11',   function() hs.grid.set(hs.window.focusedWindow(), {0, 5, 3, 4}) end) -- Bottom Left
bind('f12',   function() hs.grid.set(hs.window.focusedWindow(), {3, 5, 4, 4}) end) -- Bottom Right

bind('-',     function() stackApplicationWindows() end)
bind('=',     function() maximizeWindows() end)

bind('1',     function() moveFocusedWindowToScreen('0 0') end) -- Left
bind('2',     function() moveFocusedWindowToScreen('1 0') end) -- Center
bind('3',     function() moveFocusedWindowToScreen('2 0') end) -- Right

bind('f1',    function() moveMouseToScreen('0 0') end) -- Left
bind('f2',    function() moveMouseToScreen('1 0') end) -- Center
bind('f3',    function() moveMouseToScreen('2 0') end) -- Right

bind('f8',    function() hs.osascript.applescript('tell application "System Events" to tell appearance preferences to set dark mode to not dark mode') end)

bind('b',     function() activate('Firefox.app') end)
bind('c',     function() activate('Google Chrome.app') end)
bind('f',     function() activate('Finder.app') end)
bind('g',     function() activate(nexus and 'Numbers.app' or 'Google Chat.app') end)
bind('h',     function() activate('Weather.app') end)
bind('i',     function() activate('Maps.app') end)
bind('j',     function() activate('Sublime Merge.app') end)
bind('k',     function() activate(nexus and 'Activity Monitor.app' or 'kitty.app') end)
bind('l',     function() activate('Preview.app') end)
bind('m',     function() activate('Messages.app') end)
bind('n',     function() activate('Notes.app') end)
bind('o',     function() activate('OmniFocus.app') end)
bind('p',     function() activate(nexus and 'Photos.app' or 'Photo Booth.app') end)
bind('q',     function() activate('Hammerspoon.app') end)
bind('r',     function() activate('Calendar.app') end)
bind('s',     function() activate(nexus and 'Safari.app' or 'Google Meet.app') end)
bind('t',     function() activate('iTerm.app') end)
bind('u',     function() activate(nexus and 'UlyssesMac.app' or 'Cider V.app') end)
bind('v',     function() activate('MacVim.app') end)
bind('x',     function() activate('IINA.app') end)
bind('y',     function() activate('Dictionary.app') end)
bind('z',     function() highlightMousePointer() end)
bind('4',     function() openFirefoxHomeTabs() end)
bind('5',     function() openFirefoxChatTabs() end)
bind('6',     function() openChromeHomeTabs() end)
bind('7',     function() activate('YouTube Music.app') end)

local wf = hs.window.filter.new(false, 'serban-wf', 'warning')
for _, app in ipairs({'Firefox', 'Google Chrome', 'MacVim', 'OmniFocus',
                      'Preview', 'Sublime Merge', 'iTerm2', 'kitty'}) do
  wf:setAppFilter(app, {allowRoles='AXStandardWindow'})
end
wf:subscribe(hs.window.filter.windowCreated, function(w, app, event)
  serban.logger.df(
      'New Window ›  %-18s  %-18s  %-18s  %d × %d', -- %-18s b/c of utf8.len()
      'isVisible: ' .. b(w:isVisible()),
      'isStandard: ' .. b(w:isStandard()),
      'isFullScreen: ' .. b(w:isFullScreen()),
      w:size().w, w:size().h) -- alternatively, use w:size().string
  serban.logger.df(
      '           ›  %-16s  %-16s  %-16s  %s',
      w:role(), w:subrole(), app, w:title())
  hs.grid.set(w, {0, 0, 7, 9})
end)
serban.logger.v(hs.inspect(wf.filters))
