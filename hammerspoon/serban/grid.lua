local M = {}

M.kScreenLeft     = '0 0'
M.kScreenCenter   = '1 0'
M.kScreenRight    = '2 0'

M.kGridMaximized  = {0, 0, 7, 9}
M.kGridCenter     = {1, 1, 5, 7}
M.kGridLeft       = {0, 0, 3, 9}
M.kGridRight      = {3, 0, 4, 9}
M.kGridTop        = {0, 0, 7, 5}
M.kGridBottom     = {0, 5, 7, 4}

hs.grid.setGrid('7x9')
hs.grid.setMargins('6x6')

return M
