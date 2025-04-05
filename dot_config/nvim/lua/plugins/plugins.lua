return {
  {
    "3rd/image.nvim",
    opts = {
      integrations = {
        markdown = {
          resolve_image_path = function(document_path, image_path, fallback)
            -- document_path is the path to the file that contains the image
            -- image_path is the potentially relative path to the image. for
            -- markdown it's `![](this text)`

            -- you can call the fallback function to get the default behavior
            return fallback(document_path, image_path)
          end,
        },
      },
    },
  },

  {
    "sotte/presenting.nvim",
    opts = {},
    cmd = { "Presenting" },
  },
  {
    "folke/snacks.nvim",
    opts = {
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
    },
  },
}
