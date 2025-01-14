local M = {}

function M.toggleDarkMode()
  hs.osascript.applescript([[
    tell application "System Events"
      tell appearance preferences
        set dark mode to not dark mode
      end tell
    end tell
  ]])
end

function M.activate(name)
  hs.application.launchOrFocus(name)
  hs.application.frontmostApplication():activate(true)
end

function M.highlightMousePointer()
  local m = hs.mouse.absolutePosition()
  hs.canvas.new({x=m.x-150, y=m.y-150, w=300, h=300}):appendElements({
    type='circle', action='fill', fillColor={hex='#ff4081', alpha=0.5}, -- 2014 Material Design A200
  }):show():delete(0.75)
end

function M.moveMouseToScreen(hint)
  local s = hs.screen(hint)
  local f = s:fullFrame()
  local x, y = f.w // 2, f.h // 2
  serban.logger.df(
      ' Mouse → %23s [%4d×%4d] › Mouse → (%4d, %4d)',
      s:name(), f.w, f.h, x, y)
  hs.mouse.setRelativePosition(hs.geometry(x, y), s)
  M.highlightMousePointer()
end

function M.openFirefoxHomeTabs()
  M.activate('Firefox.app')
  os.execute(table.concat({'/Applications/Firefox.app/Contents/MacOS/firefox',
      'https://app.todoist.com',
      'https://mail.google.com/mail/u/0/#inbox',
      'https://calendar.google.com/calendar/u/0/r/month',
      'https://app.ynab.com',
  }, ' '))
  hs.timer.doAfter(0.2, function()
    serban.grid.moveFocusedWindow(serban.grid.kGridMaximized)
  end)
end

function M.openFirefoxChatTabs()
  M.activate('Firefox.app')
  os.execute(table.concat({'/Applications/Firefox.app/Contents/MacOS/firefox',
      'https://discord.com/channels/@me',
      'https://app.element.io/#/home',
      'https://web.whatsapp.com',
      'https://www.messenger.com',
  }, ' '))
  hs.timer.doAfter(0.2, function()
    serban.grid.moveFocusedWindow(serban.grid.kGridMaximized)
  end)
end

function M.openChromeHomeTabs()
  M.activate('Google Chrome.app')
  os.execute(table.concat({
      '"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"',
          '--new-window',
          'https://calendar.google.com/calendar/u/0/r/week',
          'https://mail.google.com/mail/u/0/#inbox',
  }, ' '))
  hs.timer.doAfter(0.2, function()
    serban.grid.moveFocusedWindow(serban.grid.kGridMaximized)
  end)
end

return M
