local M = {}

-- https://github.com/Hammerspoon/hammerspoon/issues/2794#issuecomment-1637453743
-- https://github.com/Hammerspoon/hammerspoon/issues/3224#issuecomment-1294359070
-- https://github.com/Hammerspoon/hammerspoon/issues/3224#issuecomment-1295677320
-- https://github.com/Hammerspoon/hammerspoon/issues/3297#issuecomment-1298544048
function M.disableAXEnhancedUserInterface()
  serban.logger.i('AXEnhancedUserInterface › ─────────────────────────────────')
  for _, app in ipairs(hs.application.runningApplications()) do
    local axuie = hs.axuielement.applicationElement(app)
    if axuie.AXEnhancedUserInterface then
      serban.logger.f('                        › %s', app:name())
      axuie.AXEnhancedUserInterface = false
    end
  end
end

return M
