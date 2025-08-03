return {
  {
    -- Syntax-aware parsing and highlighting using Tree-sitter
    "nvim-treesitter/nvim-treesitter",
    -- Automatically update parsers after install/update
    build = ":TSUpdate",
    -- Load on demand to reduce startup time
    event = { "VeryLazy" },
    opts = {
      highlight = {
        enable = true,
        -- Fall back to Vim regex-based highlighting for Ruby
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = {
        enable = true,
        disable = { "ruby" }, -- Ruby indentation is still unreliable
      },
      -- Parsers to ensure are installed
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
