-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- vim.bo.filetype
require("lint").linters_by_ft = {
  tex = { "chktex", "lacheck" },
  python = { "dmypy" },
}
vim.cmd([[
augroup vimrc
  autocmd!
augroup END
autocmd vimrc BufNewFile,BufRead *.tsqx setfiletype tsqx
autocmd vimrc BufRead *.tex syntax off " We don't need syntax when we have treesitter
]])
require("lspconfig").arduino_language_server.setup({})
