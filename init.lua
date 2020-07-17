local function highlightMousePointer()
  local m = hs.mouse.getAbsolutePosition()
  hs.canvas.new({x=m.x-150, y=m.y-150, w=300, h=300}):appendElements({
    type='circle', action='fill', fillColor={hex='#ff4081', alpha=0.5}, -- 2014 Material Design A200
  }):show():delete(0.75)
end

hs.window.animationDuration = 0

hs.grid.setGrid('7x2')
hs.grid.setMargins('6x6')

hs.hotkey.bind("⌃⌥⇧⌘", "'",     function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 2}) end) -- Maximize
hs.hotkey.bind("⌃⌥⇧⌘", ";",     function() hs.grid.set(hs.window.focusedWindow(), {1, 0, 5, 2}) end) -- Center
hs.hotkey.bind("⌃⌥⇧⌘", "left",  function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 3, 2}) end) -- Left
hs.hotkey.bind("⌃⌥⇧⌘", "right", function() hs.grid.set(hs.window.focusedWindow(), {3, 0, 4, 2}) end) -- Right
hs.hotkey.bind("⌃⌥⇧⌘", "up",    function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 1}) end) -- Top
hs.hotkey.bind("⌃⌥⇧⌘", "down",  function() hs.grid.set(hs.window.focusedWindow(), {0, 1, 7, 1}) end) -- Bottom
hs.hotkey.bind("⌃⌥⇧⌘", "f9",    function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 3, 1}) end) -- Top Left
hs.hotkey.bind("⌃⌥⇧⌘", "f10",   function() hs.grid.set(hs.window.focusedWindow(), {3, 0, 4, 1}) end) -- Top Right
hs.hotkey.bind("⌃⌥⇧⌘", "f11",   function() hs.grid.set(hs.window.focusedWindow(), {0, 1, 3, 1}) end) -- Bottom Left
hs.hotkey.bind("⌃⌥⇧⌘", "f12",   function() hs.grid.set(hs.window.focusedWindow(), {3, 1, 4, 1}) end) -- Bottom Right

hs.hotkey.bind("⌃⌥⇧⌘", "1", function() hs.window.focusedWindow():moveToScreen('1440x900',  false, true); hs.grid.maximizeWindow(); hs.mouse.setRelativePosition(hs.geometry( 720, 450), hs.screen('1440x900' )) end) -- Built-in Display
hs.hotkey.bind("⌃⌥⇧⌘", "2", function() hs.window.focusedWindow():moveToScreen('2560x1440', false, true); hs.grid.maximizeWindow(); hs.mouse.setRelativePosition(hs.geometry(1280, 720), hs.screen('2560x1440')) end) -- Thunderbolt Display
hs.hotkey.bind("⌃⌥⇧⌘", "3", function() hs.window.focusedWindow():moveToScreen('1920x1200', false, true); hs.grid.maximizeWindow(); hs.mouse.setRelativePosition(hs.geometry( 960, 600), hs.screen('1920x1200')) end) -- Old Faithful

hs.hotkey.bind("⌃⌥⇧⌘", "b", function() hs.application.launchOrFocus("Firefox.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "c", function() hs.application.launchOrFocus("Google Chrome.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "f", function() hs.application.launchOrFocus("Finder.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "g", function() hs.application.launchOrFocus("Chat.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "h", function() hs.application.launchOrFocus("Audio Hijack.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "i", function() hs.application.launchOrFocus("Sublime Text.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "j", function() hs.application.launchOrFocus("Sublime Merge.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "k", function() hs.application.launchOrFocus("Activity Monitor.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "m", function() hs.application.launchOrFocus("Messages.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "n", function() hs.application.launchOrFocus("Obsidian.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "o", function() hs.application.launchOrFocus("OmniFocus.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "p", function() hs.application.launchOrFocus("Photo Booth.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "q", function() hs.mouse.setRelativePosition(hs.geometry(1280, 720), hs.screen('2560x1440')); highlightMousePointer() end)
hs.hotkey.bind("⌃⌥⇧⌘", "r", function() hs.application.launchOrFocus("Calendar.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "s", function() hs.application.launchOrFocus("Spotify.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "t", function() hs.application.launchOrFocus("iTerm.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "u", function() hs.application.launchOrFocus("UlyssesMac.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "v", function() hs.application.launchOrFocus("MacVim.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "x", function() hs.application.launchOrFocus("Signal.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "y", function() hs.application.launchOrFocus("Dictionary.app") end)
hs.hotkey.bind("⌃⌥⇧⌘", "z", function() highlightMousePointer() end)
