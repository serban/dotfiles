local M = {}

function M.moveApplicationToScreen(name, hint, cell)
  local app = hs.application.find(name, true)
  local screen = hs.screen(hint)
  local frame = screen:fullFrame()

  if app == nil then
    serban.logger.df(
        'moveApplicationToScreen(): %16s → ∅', name)
    return
  end

  for _, window in pairs(app:allWindows()) do
    serban.logger.df(
        'moveApplicationToScreen(): %16s → %23s [%4d×%4d] › %s',
        name, screen:name(), frame.w, frame.h, string.sub(window:title(), 1, 20))
    hs.grid.set(window, cell, screen)
  end
end

function M.placeWindows()
  local numScreens = math.min(2, #hs.screen.allScreens())
  serban.logger.f('Placing windows on %d screens…', numScreens)
  for _, a in pairs(serban.apps.kPlacement) do
    M.moveApplicationToScreen(a['app'], table.unpack(a[numScreens]))
  end
end

return M
