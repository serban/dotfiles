serban = {}

hs.logger.setGlobalLogLevel('warning') -- error, warning, info, debug, verbose
serban.logger = hs.logger.new('serban', 'info') -- Quiet all loggers but mine

serban.grid   = require('serban.grid')

serban.apps   = require('serban.apps')
serban.ax     = require('serban.ax')
serban.keys   = require('serban.keys')
serban.max    = require('serban.max')
serban.place  = require('serban.place')
serban.screen = require('serban.screen')

hs.window.animationDuration = 0

function b(v)
  if     v == nil then return '∅' -- utf8.len('∅') → 1, string.len('∅') → 3
  elseif v == true then return '✓' -- utf8.len('✓') → 1, string.len('✓') → 3
  elseif v == false then return '✗' -- utf8.len('✗') → 1, string.len('✗') → 3
  else return '?'
  end
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
