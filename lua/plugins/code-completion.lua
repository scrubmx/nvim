return {
  -- Fully featured & enhanced replacement for copilot.vim
  -- https://github.com/zbirenbaum/copilot.lua
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    priority = 60,
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },

  -- The official Neovim plugin for Supermaven
  -- https://supermaven.com
  -- https://github.com/supermaven-inc/supermaven-nvim
  {
    'supermaven-inc/supermaven-nvim',
    event = 'InsertEnter',
    priority = 60,
    opts = {
      keymaps = {
        accept_suggestion = '<C-y>',
        clear_suggestion = '<C-Space>',
        next_completion = '<C-n>',
        previous_completion = '<C-p>',
      },
      disable_inline_completion = true, -- disables inline completion for use with cmp
      disable_keymaps = false, -- disables built in keymaps for more manual control
    },
  },
}
