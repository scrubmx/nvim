-- A fancy, configurable, notification manager for NeoVim
-- https://github.com/rcarriga/nvim-notify
return {
  'rcarriga/nvim-notify',
  init = function()
    vim.notify = require('notify')
  end,
  opts = {
    -- The appearance of the notifications can be configured
    -- https://github.com/rcarriga/nvim-notify#render-style
    render = 'default',
    background_colour = '#11111b',
  },
}
