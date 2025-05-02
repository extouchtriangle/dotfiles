return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {},
      zen = {
        show = {
          statusline = true,
        },
        on_open = function(win)
          vim.cmd([[silent !kitten @ set-font-size 21]])
        end,
        on_close = function(win)
          vim.cmd([[silent !kitten @ set-font-size 18]])
        end,
      },
      styles = {
        zen = {
          backdrop = { transparent = false },
        },
      },
      scroll = { enabled = false },
      notifier = { enabled = false },
    },
  },
}
