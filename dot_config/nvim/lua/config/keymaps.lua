-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
require("conform").setup({
  formatters_by_ft = {
    tex = { "tex-fmt" },
    python = { "ruff" },
    ["*"] = { "trim_whitespace", "codespell" },
  },
})
vim.cmd([[
nmap @b V:<C-u>HSHighlight<cr>n
nmap @a /ANSWER<cr>@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b@b
]])
vim.keymap.set("n", "<leader>cg", ":call jukit#cells#create_below(0)<cr>")
vim.keymap.set("n", "<leader>cm", ":CompilerOpen<cr><cr>")
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsqx = {
  install_info = {
    url = "https://github.com/extouchtriangle/tree-sitter-tsqx", -- local path or git repo
    files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "tsqx", -- if filetype does not match the parser name
}
