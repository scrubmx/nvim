-- Plugin that displays possible keybindings when you start typing a command
-- https://github.com/folke/which-key.nvim
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  cmd = 'WhichKey',
  opts = {
    win = { border = 'rounded' },
  },
}
