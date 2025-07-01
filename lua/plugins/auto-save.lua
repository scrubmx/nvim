-- Automatically save your changes in NeoVim
-- https://github.com/okuuva/auto-save.nvim
return {
  'okuuva/auto-save.nvim',
  version = '*',
  event = { 'InsertLeave', 'TextChanged' },
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = { 'BufLeave', 'FocusLost', 'QuitPre', 'VimSuspend', 'WinLeave' }, -- Events that trigger an immediate save
      defer_save = { 'InsertLeave', 'TextChanged' }, -- Events that trigger a deferred save (saves after `debounce_delay`)
      cancel_deferred_save = { 'InsertEnter' }, -- Events that cancel a pending deferred save
    },
    noautocmd = false, -- Do not execute autocmds when saving
    lockmarks = false, -- Lock marks when saving, see `:h lockmarks` for more details
    debounce_delay = 1000, -- Delay after which a pending save is executed
    condition = function(buffer)
      -- Don't save for special-buffers
      if vim.fn.getbufvar(buffer, '&buftype') ~= '' then
        return false
      end

      return true
    end,
  },
}
