local M = {}

function M.moveFocusedWindowToScreen(hint)
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

function M.stackFrontmostApplicationWindows()
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

function M.maximizeAllWindows()
  for _, w in pairs(hs.window.allWindows()) do
    local a = w:application():name()
    if a ~= 'Finder' and a ~= 'Audio Hijack' and a ~= 'Hammerspoon' then
      hs.grid.set(w, serban.grid.kGridMaximized)
    end
  end
end

return M
