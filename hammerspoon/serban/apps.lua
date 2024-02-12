local M = {}

local g = serban.grid

M.kPlacement = {

  { app='1Password 7',      bun='com.agilebits.onepassword7',   max=false,  [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Activity Monitor', bun='com.apple.ActivityMonitor',    max=false,  [1]={g.kScreenLeft, g.kGridRight},      [2]={g.kScreenLeft,   g.kGridRight},      },
  { app='Calendar',         bun='com.apple.iCal',               max=false,  [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Contacts',         bun='com.apple.AddressBook',        max=false,  [1]={g.kScreenLeft, g.kGridRight},      [2]={g.kScreenLeft,   g.kGridRight},      },
  { app='Dictionary',       bun='com.apple.Dictionary',         max=false,  [1]={g.kScreenLeft, g.kGridRight},      [2]={g.kScreenLeft,   g.kGridRight},      },
  { app='FaceTime',         bun='com.apple.FaceTime',           max=false,  [1]={g.kScreenLeft, g.kGridCenter},     [2]={g.kScreenLeft,   g.kGridCenter},     },
  { app='Find My',          bun='com.apple.findmy',             max=false,  [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Firefox',          bun='org.mozilla.firefox',          max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='Google Chrome',    bun='com.google.Chrome',            max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='Hammerspoon',      bun='org.hammerspoon.Hammerspoon',  max=false,  [1]={g.kScreenLeft, g.kGridRight},      [2]={g.kScreenLeft,   g.kGridRight},      },
  { app='MacVim',           bun='org.vim.MacVim',               max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='Maps',             bun='com.apple.Maps',               max=false,  [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Messages',         bun='com.apple.MobileSMS',          max=false,  [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Notes',            bun='com.apple.Notes',              max=false,  [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Numbers',          bun='com.apple.iWork.Numbers',      max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='OmniFocus',        bun='com.omnigroup.OmniFocus4',     max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Photo Booth',      bun='com.apple.PhotoBooth',         max=false,  [1]={g.kScreenLeft, g.kGridCenter},     [2]={g.kScreenLeft,   g.kGridCenter},     },
  { app='Photos',           bun='com.apple.Photos',             max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='Preview',          bun='com.apple.Preview',            max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='Reminders',        bun='com.apple.reminders',          max=false,  [1]={g.kScreenLeft, g.kGridLeft},       [2]={g.kScreenLeft,   g.kGridLeft},       },
  { app='Safari',           bun='com.apple.Safari',             max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Sublime Merge',    bun='com.sublimemerge',             max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='System Settings',  bun='com.apple.systempreferences',  max=false,  [1]={g.kScreenLeft, g.kGridLeft},       [2]={g.kScreenLeft,   g.kGridLeft},       },
  { app='TIDAL',            bun='com.tidal.desktop',            max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Ulysses',          bun='com.ulyssesapp.mac',           max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='Weather',          bun='com.apple.weather',            max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },
  { app='Xcode',            bun='com.apple.dt.Xcode',           max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='iTerm2',           bun='com.googlecode.iterm2',        max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenCenter, g.kGridMaximized},  },
  { app='kitty',            bun='net.kovidgoyal.kitty',         max=true,   [1]={g.kScreenLeft, g.kGridMaximized},  [2]={g.kScreenLeft,   g.kGridMaximized},  },

}

return M
