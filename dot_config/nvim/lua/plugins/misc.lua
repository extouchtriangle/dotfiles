return {
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
  },
  {
    "jim-fx/sudoku.nvim",
    cmd = "Sudoku",
    config = function()
      require("sudoku").setup({
        -- configuration ...
      })
    end,
  },
  -- {
  --   "TobinPalmer/Tip.nvim",
  --   event = "VimEnter",
  --   init = function()
  --     -- Default config
  --     --- @type Tip.config
  --     require("tip").setup({
  --       seconds = 2,
  --       title = "Tip!",
  --       url = "https://vtip.43z.one", -- Or https://vimiscool.tech/neotip
  --     })
  --   end,
  -- },
  -- {
  --   "LudoPinelli/comment-box.nvim",
  --   event = "VeryLazy",
  -- },
}
