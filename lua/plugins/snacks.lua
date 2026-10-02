-- Improved vim.ui input and selection interfaces
-- https://github.com/folke/snacks.nvim
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    input = { enabled = true },
    picker = { enabled = true },
  },
}
