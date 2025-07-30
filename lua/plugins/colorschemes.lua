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
      vim.cmd.highlight "Normal guibg=NONE ctermbg=NONE"
      vim.cmd.highlight "SignColumn guibg=NONE"
      vim.cmd.highlight "LineNr guibg=NONE"
      vim.cmd.highlight "EndOfBuffer guibg=NONE"
      vim.cmd.highlight "WinSeparator guibg=NONE"
      vim.cmd.highlight "NormalNC guibg=NONE ctermbg=NONE"
      vim.cmd.highlight "NormalSB guibg=NONE ctermbg=NONE"
    end,
  },
}
