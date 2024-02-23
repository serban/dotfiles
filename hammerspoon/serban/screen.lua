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
    local g = s:frame()
    serban.logger.f(
        '       › (%d, %d) [%4d×%4d] ⟨%4d×%4d⟩ %s',
        x, y, f.w, f.h, g.w, g.h, s:name())
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
  serban.ax.disableAXEnhancedUserInterface()
  hs.timer.doAfter(2.0, serban.place.placeWindows) -- Wait for Dock to settle
end

function M._timerDidFire()
  serban.logger.i('Processing screen layout change…')
  M.processScreenLayoutChange()
end

-- NSApplicationDidChangeScreenParametersNotification fires randomly.
-- Ignore the notification if the number of screens did not change.
function M._layoutDidChange()
  local numScreens = #hs.screen.allScreens()
  if numScreens == M._numScreens then
    serban.logger.i('NSApplicationDidChangeScreenParametersNotification fired')
    return
  end
  serban.logger.f('Screen layout changed: %d → %d', M._numScreens, numScreens)
  M._numScreens = numScreens
  M._timer:start()
end

M._numScreens = #hs.screen.allScreens()

M._timer = hs.timer.delayed.new(3.0, M._timerDidFire)

M._screenWatcher = hs.screen.watcher.new(M._layoutDidChange)
M._screenWatcher:start()

M.processScreenLayoutChange()

return M
