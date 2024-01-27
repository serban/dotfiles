local M = {}

function M.logScreens()
  serban.logger.i('Layout › ──────────────────────────────────────────')
  local screens = hs.screen.allScreens()
  table.sort(screens, function(p, q)
    local px, py = p:position()
    local qx, qy = q:position()
    return px < qx
  end)
  for _, s in ipairs(screens) do
    local x, y = s:position()
    local f = s:fullFrame()
    serban.logger.f('       › (%d, %d) [%4d×%4d] %s', x, y, f.w, f.h, s:name())
  end
end

function M.setDockAutoHide()
  hs.osascript.applescript(
      'tell application "System Events" to tell dock preferences to set autohide to ' ..
      (#hs.screen.allScreens() == 1 and 'true' or 'false'))
end

function M.processScreenLayoutChange()
  M.logScreens()
  M.setDockAutoHide()
  serban.place.placeWindows()
end

function M._timerDidFire()
  serban.logger.i('Processing screen layout change…')
  M.processScreenLayoutChange()
end

function M._layoutDidChange()
  serban.logger.i('Screen layout changed')
  M._timer:start()
end

M._timer = hs.timer.delayed.new(3, M._timerDidFire)

M._screenWatcher = hs.screen.watcher.new(M._layoutDidChange)
M._screenWatcher:start()

M.processScreenLayoutChange()

return M
