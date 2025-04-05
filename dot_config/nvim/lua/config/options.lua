-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.jukit_highlight_markers = 1
vim.g.jukit_pdf_viewer = "zathura"
vim.g.jukit_terminal = "kitty"
vim.g.jukit_output_new_os_window = 1
vim.g.jukit_outhist_new_os_window = 1
vim.g.jukit_enable_textcell_bg_hl = 1
vim.g.jukit_enable_textcell_syntax = 1
vim.g.jukit_hl_ext_enabled = "*"
vim.opt.swapfile = false
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.neovide_opacity = 0.8
vim.g.neovide_normal_opacity = 0.8
vim.opt.colorcolumn = "+1"
vim.opt.ruler = true
vim.opt.textwidth = 80
vim.diagnostic.config({ virtual_text = false })
vim.g.tex_flavor = "latex"
vim.cmd([[
let g:tex_items = '\\bibitem\|\\item\|\\ii'
]])
