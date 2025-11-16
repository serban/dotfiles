if not vim.g.neovide then
  return
end

vim.opt.guifont = 'Monaco:h15'

vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_scroll_animation_length = 0
vim.g.neovide_input_macos_option_key_is_meta = 'both'

vim.keymap.set('v', '<D-c>', '"+y')

vim.keymap.set('n', '<D-v>', '"+p')
vim.keymap.set('c', '<D-v>', '<C-R>+')
vim.keymap.set('i', '<D-v>', '<Esc>"+pa')
