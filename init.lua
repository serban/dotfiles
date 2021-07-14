hs.window.animationDuration = 0

hs.grid.setGrid('7x9')
hs.grid.setMargins('6x6')

local modal = hs.hotkey.modal.new('⌘', 'e', 'Hotkey')

function modal:entered()
  hs.timer.doAfter(1, function() modal:exit() end)
end

local function bind(key, fn)
  hs.hotkey.bind('⌃⌥⇧⌘', key, fn)
  modal:bind('', key, function() fn(); modal:exit() end)
end

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

local function maximizeWindows()
  for _, w in pairs(hs.window.allWindows()) do
    local a = w:application():name()
    if a ~= 'Audio Hijack' and a ~= 'Hammerspoon' then
      hs.grid.set(w, {0, 0, 7, 9})
    end
  end
end

local function highlightMousePointer()
  local m = hs.mouse.getAbsolutePosition()
  hs.canvas.new({x=m.x-150, y=m.y-150, w=300, h=300}):appendElements({
    type='circle', action='fill', fillColor={hex='#ff4081', alpha=0.5}, -- 2014 Material Design A200
  }):show():delete(0.75)
end

bind("'",     function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 9}) end) -- Maximize
bind('\\',    function() hs.grid.set(hs.window.focusedWindow(), {1, 0, 5, 9}) end) -- Center Tall
bind('0',     function() hs.grid.set(hs.window.focusedWindow(), {2, 0, 3, 9}) end) -- Center Skinny
bind(';',     function() hs.grid.set(hs.window.focusedWindow(), {1, 1, 5, 7}) end) -- Center
bind('left',  function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 3, 9}) end) -- Left
bind('right', function() hs.grid.set(hs.window.focusedWindow(), {3, 0, 4, 9}) end) -- Right
bind('up',    function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 7, 5}) end) -- Top
bind('down',  function() hs.grid.set(hs.window.focusedWindow(), {0, 5, 7, 4}) end) -- Bottom
bind('f9',    function() hs.grid.set(hs.window.focusedWindow(), {0, 0, 3, 5}) end) -- Top Left
bind('f10',   function() hs.grid.set(hs.window.focusedWindow(), {3, 0, 4, 5}) end) -- Top Right
bind('f11',   function() hs.grid.set(hs.window.focusedWindow(), {0, 5, 3, 4}) end) -- Bottom Left
bind('f12',   function() hs.grid.set(hs.window.focusedWindow(), {3, 5, 4, 4}) end) -- Bottom Right

bind('-',     function() stackApplicationWindows() end)
bind('=',     function() maximizeWindows() end)

bind('1',     function() hs.window.focusedWindow():moveToScreen('1440x900',  false, true); hs.grid.maximizeWindow(); hs.mouse.setRelativePosition(hs.geometry( 720, 450), hs.screen('1440x900' )) end) -- Built-in Display
bind('2',     function() hs.window.focusedWindow():moveToScreen('2560x1440', false, true); hs.grid.maximizeWindow(); hs.mouse.setRelativePosition(hs.geometry(1280, 720), hs.screen('2560x1440')) end) -- Thunderbolt Display
bind('3',     function() hs.window.focusedWindow():moveToScreen('1920x1200', false, true); hs.grid.maximizeWindow(); hs.mouse.setRelativePosition(hs.geometry( 960, 600), hs.screen('1920x1200')) end) -- Old Faithful

bind('f1',    function() hs.mouse.setRelativePosition(hs.geometry( 720, 450), hs.screen('1440x900' )); highlightMousePointer() end) -- Built-in Display
bind('f2',    function() hs.mouse.setRelativePosition(hs.geometry(1280, 720), hs.screen('2560x1440')); highlightMousePointer() end) -- Thunderbolt Display
bind('f3',    function() hs.mouse.setRelativePosition(hs.geometry( 960, 600), hs.screen('1920x1200')); highlightMousePointer() end) -- Old Faithful

bind('f8',    function() hs.osascript.applescript('tell application "System Events" to tell appearance preferences to set dark mode to not dark mode') end)

bind('b',     function() activate('Firefox.app') end)
bind('c',     function() activate('Google Chrome.app') end)
bind('f',     function() activate('Finder.app') end)
bind('g',     function() activate('Google Chat 2.app') end)
bind('h',     function() activate('Audio Hijack.app') end)
bind('i',     function() activate('Maps.app') end)
bind('j',     function() activate('Sublime Merge.app') end)
bind('k',     function() activate('Activity Monitor.app') end)
bind('l',     function() activate('Music.app') end)
bind('m',     function() activate('Messages.app') end)
bind('n',     function() activate('Notes.app') end)
bind('o',     function() activate('OmniFocus.app') end)
bind('p',     function() activate('Photo Booth.app') end)
bind('q',     function() hs.mouse.setRelativePosition(hs.geometry(1280, 720), hs.screen('2560x1440')); highlightMousePointer() end)
bind('r',     function() activate('Calendar.app') end)
bind('s',     function() activate('Google Meet.app') end)
bind('t',     function() activate('iTerm.app') end)
bind('u',     function() activate('UlyssesMac.app') end)
bind('v',     function() activate('MacVim.app') end)
bind('x',     function() activate('Signal.app') end)
bind('y',     function() activate('Dictionary.app') end)
bind('z',     function() highlightMousePointer() end)
