-- Tiny plugin to enhance Neovim's native comments
-- https://github.com/folke/ts-comments.nvim
return {
  'folke/ts-comments.nvim',
  event = 'VeryLazy',
  enabled = vim.fn.has('nvim-0.10.0') == 1,
  config = true,
}
