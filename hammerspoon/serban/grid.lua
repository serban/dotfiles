local M = {}

M.kScreenLeft       = '0 0'
M.kScreenCenter     = '1 0'
M.kScreenRight      = '2 0'

M.kGridMaximized    = {0, 0, 7, 9}
M.kGridCenter       = {1, 1, 5, 7}

M.kGridCenterSkinny = {2, 0, 3, 9}
M.kGridCenterTall   = {1, 0, 5, 9}
M.kGridCenterRight  = {1, 0, 6, 9}
M.kGridCenterWide   = {0, 1, 7, 7}

M.kGridLeft         = {0, 0, 3, 9}
M.kGridRight        = {3, 0, 4, 9}
M.kGridTop          = {0, 0, 7, 5}
M.kGridBottom       = {0, 5, 7, 4}

M.kGridTopLeft      = {0, 0, 3, 5}
M.kGridTopRight     = {3, 0, 4, 5}
M.kGridBottomLeft   = {0, 5, 3, 4}
M.kGridBottomRight  = {3, 5, 4, 4}

hs.grid.setGrid('7x9')
hs.grid.setMargins('6x6')

return M
