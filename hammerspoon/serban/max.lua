local M = {}

M.wf = hs.window.filter.new(false, 'serban-wf', 'warning')

for _, app in ipairs({'Firefox', 'Google Chrome', 'MacVim', 'OmniFocus',
                      'Preview', 'Sublime Merge', 'iTerm2', 'kitty'}) do
  M.wf:setAppFilter(app, {allowRoles='AXStandardWindow'})
end

M.wf:subscribe(hs.window.filter.windowCreated, function(w, app, event)
  serban.logger.df(
      'New Window ›  %-18s  %-18s  %-18s  %d × %d', -- %-18s b/c of utf8.len()
      'isVisible: ' .. b(w:isVisible()),
      'isStandard: ' .. b(w:isStandard()),
      'isFullScreen: ' .. b(w:isFullScreen()),
      w:size().w, w:size().h) -- alternatively, use w:size().string
  serban.logger.df(
      '           ›  %-16s  %-16s  %-16s  %s',
      w:role(), w:subrole(), app, w:title())

  hs.grid.set(w, {0, 0, 7, 9})
end)

serban.logger.v(hs.inspect(M.wf.filters))

return M
