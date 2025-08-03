return {
  {
    -- Tokyonight is the main colorscheme
    "folke/tokyonight.nvim",
    lazy = false,      -- Load immediately at startup
    priority = 1000,   -- Load before all other plugins to avoid flicker
    config = function ()
      require("tokyonight").setup {
        transparent = true,
        styles = {
          comments = { italic = false },
        },
      }
      vim.cmd.colorscheme "tokyonight-night"
    end,
  },
}
