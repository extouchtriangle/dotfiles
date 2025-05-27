return {
  {
    "romgrk/kirby.nvim",
    lazy = false,
    dependencies = {
      { "romgrk/fzy-lua-native", build = "make install" },
      { "romgrk/kui.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-lua/plenary.nvim" },
    },
  },
}
