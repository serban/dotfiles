vim.g.mapleader = ' '

vim.keymap.set('n', 'q', '<Nop>')
vim.keymap.set('n', 'Q', '<Nop>')

vim.keymap.set('n', 'gQ', '<Nop>')

vim.keymap.set('c', '<F1>', '<Esc>')
vim.keymap.set('n', '<F1>', '<Esc>')
vim.keymap.set('i', '<F1>', '<Esc>')
vim.keymap.set('v', '<F1>', '<Esc>')

vim.keymap.set('n', '<C-a>', ':botright vsplit <CR>')
vim.keymap.set('n', '<C-g>', ':split <CR>')

vim.keymap.set('n', '<C-c>', ':close <CR>')

vim.keymap.set('n', '<C-b>', ':tabnew <CR>')
vim.keymap.set('n', '<C-n>', ':tabnext <CR>')
vim.keymap.set('n', '<C-p>', ':tabprevious <CR>')

vim.keymap.set('n', '<C-h>', ':wincmd h <CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j <CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k <CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l <CR>')

vim.keymap.set('n', '<C-s>', ':update <CR>')
vim.keymap.set('i', '<C-s>', '<Esc>:update <CR>')
vim.keymap.set('v', '<C-s>', '<Esc>:update <CR>')
vim.keymap.set('n', '<C-q>', vim.cmd.quitall)

vim.keymap.set('n', '<M-n>', ':bnext <CR>')
vim.keymap.set('n', '<M-p>', ':bprevious <CR>')

vim.keymap.set('n', '<Leader>Q', ':quitall! <CR>')
vim.keymap.set('n', '<Leader>z', ':nohlsearch <CR>')
