return {
  -- Main Telescope plugin (fuzzy finder)
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = {
    -- Required dependency for Telescope
    'nvim-lua/plenary.nvim',

    -- Native FZF sorter (compiled for performance)
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },

    -- Adds Telescope integration for `vim.ui.select()`
    'nvim-telescope/telescope-ui-select.nvim',

    -- Optional: file icons if Nerd Font is available
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_fonts },
  },

  config = function()
    -- Set up Telescope with UI-select dropdown style
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Load extensions if available
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- Telescope builtins for various pickers
    local builtin = require 'telescope.builtin'

    -- Key mappings for frequently used pickers
    vim.keymap.set('n', '<leader>fh', builtin.help_tags,
      { desc = '[F]ind [H]elp' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps,
      { desc = '[F]ind [K]eymaps' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files,
      { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>fs', builtin.builtin,
      { desc = '[F]ind [S]elect Telescope' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string,
      { desc = '[F]ind current [W]ord' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep,
      { desc = '[F]ind by [G]rep' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics,
      { desc = '[F]ind [D]iagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume,
      { desc = '[F]ind [R]esume' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles,
      { desc = '[F]ind Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers,
      { desc = '[ ] Find existing buffers' })

    -- Fuzzy search within current buffer using dropdown UI
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
  end
}
