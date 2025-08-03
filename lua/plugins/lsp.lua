return {
  {
    -- Configures Lua LSP for Neovim development
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Include luv types when `vim.uv` is used
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Sets up core LSP functionality
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- LSP installer
      { "mason-org/mason.nvim", opts = {} },
      -- Bridges Mason with lspconfig
      "mason-org/mason-lspconfig.nvim",
      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local _border = "rounded"

      -- Configure LSP client capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- Keybindings for LSP functionality
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "K", function()
          vim.lsp.buf.hover({ border = _border })
        end, "Hover")
        map("n", "<C-k>", function()
          vim.lsp.buf.signature_help({ border = _border })
        end, "Signature Help")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>d", function()
          vim.diagnostic.open_float(nil, { focus = false })
        end, "Show Diagnostics at Cursor")
        map("n", "<leader>w", function()
          local new_state = not vim.diagnostic.config().virtual_lines
          vim.diagnostic.config({virtual_lines = new_state})
        end, "Toggle Diagnostics")
      end

      -- LSP servers and config overrides
      local servers = {
        lua_ls = {},
        bashls = {},
        clangd = {},
        jsonls = {},
        pyright = {},
        ts_ls = {},
      }

      -- Ensure specified LSP servers are installed (but not auto-configured)
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_enable = false,
      })

      -- Manual setup of LSP servers with shared config
      for name, opts in pairs(servers) do
        opts.capabilities = capabilities
        opts.on_attach = on_attach
        require("lspconfig")[name].setup(opts)
      end

      -- Global diagnostic UI configuration
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = _border, source = 'if_many' },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN]  = '󰀪 ',
            [vim.diagnostic.severity.INFO]  = '󰋽 ',
            [vim.diagnostic.severity.HINT]  = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }
    end,
  }
}
