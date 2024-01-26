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

M._screenWatcher = hs.screen.watcher.new(function() -- not local to prevent garbage collection
  M.logScreens()
  M.setDockAutoHide()
end)
M._screenWatcher:start()

M.logScreens()
M.setDockAutoHide()

return M
