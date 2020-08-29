local function activate(name)
  hs.application.launchOrFocus(name)
  hs.application.frontmostApplication():activate(true)
end

local function stackApplicationWindows()
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

local function highlightMousePointer()
  local m = hs.mouse.getAbsolutePosition()
  hs.canvas.new({x=m.x-150, y=m.y-150, w=300, h=300}):appendElements({
    type='circle', action='fill', fillColor={hex='#ff4081', alpha=0.5}, -- 2014 Material Design A200
  }):show():delete(0.75)
end

hs.window.animationDuration = 0

hs.grid.setGrid('7x9')
hs.grid.setMargins('6x6')

hs.hotkey.bind('⌃⌥⇧⌘', "'",     function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 9}) end) -- Maximize
hs.hotkey.bind('⌃⌥⇧⌘', '\\',    function() hs.grid.set(hs.window.focusedWindow(), {1, 0, 5, 9}) end) -- Center Tall
hs.hotkey.bind('⌃⌥⇧⌘', '0',     function() hs.grid.set(hs.window.focusedWindow(), {2, 0, 3, 9}) end) -- Center Skinny
hs.hotkey.bind('⌃⌥⇧⌘', ';',     function() hs.grid.set(hs.window.focusedWindow(), {1, 1, 5, 7}) end) -- Center
hs.hotkey.bind('⌃⌥⇧⌘', 'left',  function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 3, 9}) end) -- Left
hs.hotkey.bind('⌃⌥⇧⌘', 'right', function() hs.grid.set(hs.window.focusedWindow(), {3, 0, 4, 9}) end) -- Right
hs.hotkey.bind('⌃⌥⇧⌘', 'up',    function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 5}) end) -- Top
hs.hotkey.bind('⌃⌥⇧⌘', 'down',  function() hs.grid.set(hs.window.focusedWindow(), {0, 5, 7, 4}) end) -- Bottom
hs.hotkey.bind('⌃⌥⇧⌘', 'f9',    function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 3, 5}) end) -- Top Left
hs.hotkey.bind('⌃⌥⇧⌘', 'f10',   function() hs.grid.set(hs.window.focusedWindow(), {3, 0, 4, 5}) end) -- Top Right
hs.hotkey.bind('⌃⌥⇧⌘', 'f11',   function() hs.grid.set(hs.window.focusedWindow(), {0, 5, 3, 4}) end) -- Bottom Left
hs.hotkey.bind('⌃⌥⇧⌘', 'f12',   function() hs.grid.set(hs.window.focusedWindow(), {3, 5, 4, 4}) end) -- Bottom Right

hs.hotkey.bind('⌃⌥⇧⌘', '-', function() stackApplicationWindows() end)

hs.hotkey.bind('⌃⌥⇧⌘', '1', function() hs.window.focusedWindow():moveToScreen('1440x900',  false, true); hs.grid.maximizeWindow(); hs.mouse.setRelativePosition(hs.geometry( 720, 450), hs.screen('1440x900' )) end) -- Built-in Display
hs.hotkey.bind('⌃⌥⇧⌘', '2', function() hs.window.focusedWindow():moveToScreen('2560x1440', false, true); hs.grid.maximizeWindow(); hs.mouse.setRelativePosition(hs.geometry(1280, 720), hs.screen('2560x1440')) end) -- Thunderbolt Display
hs.hotkey.bind('⌃⌥⇧⌘', '3', function() hs.window.focusedWindow():moveToScreen('1920x1200', false, true); hs.grid.maximizeWindow(); hs.mouse.setRelativePosition(hs.geometry( 960, 600), hs.screen('1920x1200')) end) -- Old Faithful

hs.hotkey.bind('⌃⌥⇧⌘', 'f1', function() hs.mouse.setRelativePosition(hs.geometry( 720, 450), hs.screen('1440x900' )); highlightMousePointer() end) -- Built-in Display
hs.hotkey.bind('⌃⌥⇧⌘', 'f2', function() hs.mouse.setRelativePosition(hs.geometry(1280, 720), hs.screen('2560x1440')); highlightMousePointer() end) -- Thunderbolt Display
hs.hotkey.bind('⌃⌥⇧⌘', 'f3', function() hs.mouse.setRelativePosition(hs.geometry( 960, 600), hs.screen('1920x1200')); highlightMousePointer() end) -- Old Faithful

hs.hotkey.bind('⌃⌥⇧⌘', 'f8', function() hs.osascript.applescript('tell application "System Events" to tell appearance preferences to set dark mode to not dark mode') end)

hs.hotkey.bind('⌃⌥⇧⌘', 'b', function() activate('Firefox.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'c', function() activate('Google Chrome.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'f', function() activate('Finder.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'g', function() activate('Chat.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'h', function() activate('Audio Hijack.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'i', function() activate('Sublime Text.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'j', function() activate('Sublime Merge.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'k', function() activate('Activity Monitor.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'l', function() activate('Spotify.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'm', function() activate('Messages.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'n', function() activate('Obsidian.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'o', function() activate('OmniFocus.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'p', function() activate('Photo Booth.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'q', function() hs.mouse.setRelativePosition(hs.geometry(1280, 720), hs.screen('2560x1440')); highlightMousePointer() end)
hs.hotkey.bind('⌃⌥⇧⌘', 'r', function() activate('Calendar.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 's', function() activate('Safari.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 't', function() activate('iTerm.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'u', function() activate('UlyssesMac.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'v', function() activate('MacVim.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'x', function() activate('Signal.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'y', function() activate('Dictionary.app') end)
hs.hotkey.bind('⌃⌥⇧⌘', 'z', function() highlightMousePointer() end)
