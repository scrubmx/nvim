-- A fancy, configurable, notification manager for NeoVim
-- https://github.com/rcarriga/nvim-notify
return {
  'rcarriga/nvim-notify',
  lazy = true,
  cmd = { 'Notifications', 'NotificationsClear' },
  init = function()
    local default_notify = vim.notify

    vim.notify = function(...)
      local ok, notify = pcall(require, 'notify')

      if ok then
        vim.notify = notify
        return notify(...)
      end

      return default_notify(...)
    end
  end,
  opts = {
    -- The appearance of the notifications can be configured
    -- https://github.com/rcarriga/nvim-notify#render-style
    render = 'default',
    background_colour = '#11111b',
  },
}
