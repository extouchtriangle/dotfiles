return {
  "b0o/incline.nvim",
  lazy = false,
  dependencies = {
    "echasnovski/mini.icons",
  },
  config = function()
    local helpers = require("incline.helpers")
    local MiniIcons = require("mini.icons")
    require("incline").setup({
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_iclocal
        fn = vim.fn
        local function get_color(group, attr)
          return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
        end

        local ft_icon, ft_color, is_default = MiniIcons.get("file", filename)
        ft_color = get_color(ft_color, "fg#")
        local modified = vim.bo[props.buf].modified
        return {
          ft_icon and { " ", ft_icon, " ", guifg = ft_color, guibg = "#44406e" } or "",
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          " ",
          guibg = "#44406e",
        }
      end,
    })
  end,
}
