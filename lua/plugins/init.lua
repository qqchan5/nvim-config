return {
  -- Looks at content and guess desired intentation level
  { 'NMAC427/guess-indent.nvim', opts = {} },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },
}
