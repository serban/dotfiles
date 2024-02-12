local M = {}

M.windowFilter = hs.window.filter.new(false, 'serban-wf', 'warning')

for _, config in ipairs(serban.apps.kPlacement) do
  if config.max then
    M.windowFilter:setAppFilter(config.app, {allowRoles='AXStandardWindow'})
  end
end

M.windowFilter:subscribe(hs.window.filter.windowCreated, function(w, app, event)
  serban.logger.df(
      'New Window ›  %-18s  %-18s  %-18s  %d × %d', -- %-18s b/c of utf8.len()
      'isVisible: ' .. b(w:isVisible()),
      'isStandard: ' .. b(w:isStandard()),
      'isFullScreen: ' .. b(w:isFullScreen()),
      w:size().w, w:size().h) -- alternatively, use w:size().string
  serban.logger.df(
      '           ›  %-16s  %-16s  %-16s  %s',
      w:role(), w:subrole(), app, w:title())

  hs.grid.maximizeWindow(w)
end)

serban.logger.v(hs.inspect(M.windowFilter.filters))

return M
