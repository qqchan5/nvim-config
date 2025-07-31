return {
  {
    -- Sets up nvim-cmp for autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP-based completion
      "L3MON4D3/LuaSnip",         -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- LuaSnip completion source
      -- "rafamadriz/friendly-snippets", -- Optional: large snippet collection
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load VSCode-style snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          -- Defines how snippets are expanded
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        -- Key mappings for completion menu and snippet navigation
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),

          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),

          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-x>"] = cmp.mapping.complete(),
        },
        -- Completion sources
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      })
    end,
  },
}
