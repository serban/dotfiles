local M = {}

function M.disableAXEnhancedUserInterfaceForApp(app)
  if not app then
    return
  end

  local axuie = hs.axuielement.applicationElement(app)
  if axuie.AXEnhancedUserInterface then
    serban.logger.f('                        › %s', app:name())
    axuie.AXEnhancedUserInterface = false
  end
end

function M.disableAXEnhancedUserInterfaceForAll()
  for _, app in ipairs(hs.application.runningApplications()) do
    M.disableAXEnhancedUserInterfaceForApp(app)
  end
end

-- https://bugzilla.mozilla.org/show_bug.cgi?id=1865755
-- https://bugzilla.mozilla.org/show_bug.cgi?id=1872714
-- https://github.com/Hammerspoon/hammerspoon/issues/2794#issuecomment-1637453743
-- https://github.com/Hammerspoon/hammerspoon/issues/3224#issuecomment-1294359070
-- https://github.com/Hammerspoon/hammerspoon/issues/3224#issuecomment-1295677320
-- https://github.com/Hammerspoon/hammerspoon/issues/3297#issuecomment-1298544048
function M.disableAXEnhancedUserInterface(notify)
  serban.logger.i('AXEnhancedUserInterface › ─────────────────────────────────')
  M.disableAXEnhancedUserInterfaceForApp(hs.application.find('Firefox', true))
  if notify then
    hs.notify.new(nil, {
      title='AXEnhancedUserInterface', subTitle='Done', withdrawAfter=2,
    }):send()
  end
end

M._timer = hs.timer.doEvery(300.0, M.disableAXEnhancedUserInterface)

return M
