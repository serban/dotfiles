local M = {}

local g = serban.grid

M.home = os.getenv('HOME') .. '/'

function M.openFinderHomeDirsStacked()
  os.execute(table.concat({'open', '-a', 'Finder',
      M.home .. 'Data',
      M.home .. 'Desktop',
      M.home .. 'Downloads',
      M.home .. 'Screenshots',
      M.home .. 'Workspace',
  }, ' '))
  serban.windows.stackFrontmostApplicationWindows()
end

function M.openFinderInHomeDir(dir)
  os.execute(table.concat({'open', '-a', 'Finder', M.home .. dir}, ' '))
end

function M.openFinderHomeDirsTiled()
  local delay = 0.1
  local screen = hs.screen(
      #hs.screen.allScreens() == 1 and g.kScreenLeft or g.kScreenCenter)

  M.openFinderInHomeDir('Desktop')
  hs.timer.doAfter(delay, function()
    g.moveFocusedWindowToScreen(screen, g.kGridTopLeft) -- Desktop

    M.openFinderInHomeDir('Downloads')
    hs.timer.doAfter(delay, function()
      g.moveFocusedWindowToScreen(screen, g.kGridTopRight) -- Downloads

      M.openFinderInHomeDir('Screenshots')
      hs.timer.doAfter(delay, function()
        g.moveFocusedWindowToScreen(screen, g.kGridBottomLeft) -- Screenshots

        M.openFinderInHomeDir('Workspace')
        hs.timer.doAfter(delay, function()
          g.moveFocusedWindowToScreen(screen, g.kGridBottomRight) -- Workspace
        end)
      end)
    end)
  end)
end

return M
