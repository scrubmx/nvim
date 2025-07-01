-- Plugin to improve the default vim.ui interface
-- https://github.com/stevearc/dressing.nvim
return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  opts = {
    input = {
      insert_only = false, -- Allow to use in normal mode
    },
    -- TODO: Review `select` options documentation
    -- select = {
    --   backend = { 'telescope', 'fzf_lua', 'fzf', 'builtin' },
    --   telescope = require('telescope.themes').get_cursor(),
    -- },
  },
}
