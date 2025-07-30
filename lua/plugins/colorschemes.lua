return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      require("tokyonight").setup {
        tranparent = false,
        styles = {
          comments = { italic = false },
        },
      }
      vim.cmd.colorscheme "tokyonight-night"
    end,
  },
}
