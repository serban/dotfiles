local M = {}

local g = serban.grid

M.kPlacement = {

  { app='1Password 7',      bun='com.agilebits.onepassword7',   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Activity Monitor', bun='com.apple.ActivityMonitor',    [1]={g.kScreenLeft, g.kGridRight},      [2]={g.kScreenLeft,   g.kGridRight},      },
  { app='Calendar',         bun='com.apple.iCal',               [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Contacts',         bun='com.apple.AddressBook',        [1]={g.kScreenLeft, g.kGridRight},      [2]={g.kScreenLeft,   g.kGridRight},      },
  { app='Dictionary',       bun='com.apple.Dictionary',         [1]={g.kScreenLeft, g.kGridRight},      [2]={g.kScreenLeft,   g.kGridRight},      },
  { app='FaceTime',         bun='com.apple.FaceTime',           [1]={g.kScreenLeft, g.kGridCenter},     [2]={g.kScreenLeft,   g.kGridCenter},     },
  { app='Find My',          bun='com.apple.findmy',             [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Firefox',          bun='org.mozilla.firefox',          [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='Google Chrome',    bun='com.google.Chrome',            [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='Hammerspoon',      bun='org.hammerspoon.Hammerspoon',  [1]={g.kScreenLeft, g.kGridRight},      [2]={g.kScreenLeft,   g.kGridRight},      },
  { app='MacVim',           bun='org.vim.MacVim',               [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='Maps',             bun='com.apple.Maps',               [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Messages',         bun='com.apple.MobileSMS',          [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Notes',            bun='com.apple.Notes',              [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Numbers',          bun='com.apple.iWork.Numbers',      [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='OmniFocus',        bun='com.omnigroup.OmniFocus4',     [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Photo Booth',      bun='com.apple.PhotoBooth',         [1]={g.kScreenLeft, g.kGridCenter},     [2]={g.kScreenLeft,   g.kGridCenter},     },
  { app='Photos',           bun='com.apple.Photos',             [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='Preview',          bun='com.apple.Preview',            [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='Reminders',        bun='com.apple.reminders',          [1]={g.kScreenLeft, g.kGridLeft},       [2]={g.kScreenLeft,   g.kGridLeft},       },
  { app='Safari',           bun='com.apple.Safari',             [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Sublime Merge',    bun='com.sublimemerge',             [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='System Settings',  bun='com.apple.systempreferences',  [1]={g.kScreenLeft, g.kGridLeft},       [2]={g.kScreenLeft,   g.kGridLeft},       },
  { app='Tidal',            bun='com.tidal.desktop',            [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Ulysses',          bun='com.ulyssesapp.mac',           [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='Weather',          bun='com.apple.weather',            [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Xcode',            bun='com.apple.dt.Xcode',           [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='iTerm2',           bun='com.googlecode.iterm2',        [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='kitty',            bun='net.kovidgoyal.kitty',         [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },

}

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
  for _, a in pairs(M.kPlacement) do
    M.moveApplicationToScreen(a['app'], table.unpack(a[numScreens]))
  end
end

return M
