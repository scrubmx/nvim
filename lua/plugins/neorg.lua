-- Neorg is a tool for structured note taking, project, task management, and much more
--
-- https://github.com/nvim-neorg/neorg
-- https://github.com/nvim-neorg/neorg/wiki/Tangling
--
-- To install Neorg via lazy, first ensure that you have luarocks installed on your system.
-- https://github.com/luarocks/luarocks/wiki/Download
-- Homebrew Formulae: `brew install luarocks`
--
-- Default Keybindings
--   https://github.com/nvim-neorg/neorg/blob/6fece1546d051a5f2a2d932d5978beec1ef920ab/lua/neorg/modules/core/keybinds/keybinds.lua
-- Syntax
--   https://github.com/nvim-neorg/neorg/blob/main/doc/neorg.norg
-- Specification
--   https://github.com/nvim-neorg/norg-specs/blob/main/1.0-specification.norg
-- Semantics
--   https://github.com/nvim-neorg/norg-specs/blob/main/1.0-semantics.norg
return {
  {
    'vhyrro/luarocks.nvim',
    lazy = true,
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true,   -- This automatically runs `require('luarocks-nvim').setup()`
  },
  {
    'nvim-neorg/neorg',
    ft = 'norg',
    cmd = 'Neorg',
    version = '*',
    -- config = true,
    -- build = ':Neorg sync-parsers'
    dependencies = { 'luarocks.nvim' },
    --[[
      Neorg Keybindings
      - <LocalLeader>cm  neorg.promo.demote.range
      - <LocalLeader>id  neorg.looking-glass.magnify-code-block
      - <LocalLeader>li  neorg.tempus.insert-date
      - <LocalLeader>lt  neorg.pivot.list.invert
      - <LocalLeader>ta  neorg.pivot.list.toggle
      - <LocalLeader>td  neorg.qol.todo-items.todo.task-cancelled
      - <LocalLeader>th  neorg.qol.todo-items.todo.task-done
      - <LocalLeader>ti  neorg.qol.todo-items.todo.task-on-hold
      - <LocalLeader>tp  neorg.qol.todo-items.todo.task-important
      - <LocalLeader>tr  neorg.qol.todo-items.todo.task-pending
      - <LocalLeader>tu  neorg.qol.todo-items.todo.task-recurring
      - gO               neorg.promo.promote.range
    ]]
    keys = {
      -- { '<Leader>nc', '<Cmd>Neorg cheetsheet<CR>', desc = 'Neorg Cheatsheet' },
      -- { '<Leader>n?', '<Cmd>Neorg toggle help<CR>', desc = 'Toggle Neorg Help' },
      -- { '<Leader>nd',  '<Cmd>Neorg insert date<CR>', desc = 'Insert Neorg Date' },
      { '<Leader>ni', '<Cmd>Neorg index<CR>',             desc = 'Neorg Index' },
      -- { '<Leader>nn', '<Cmd>Neorg new note<CR>',          desc = 'New Neorg Note' },
      { '<Leader>ns', '<Cmd>Neorg summary<CR>',           desc = 'Neorg Summary' },
      { '<Leader>nt', '<Cmd>Neorg toc<CR>',               desc = 'Table of Contents' },
      { '<Leader>nw', '<Cmd>Neorg toggle workspaces<CR>', desc = 'Toggle Neorg Workspaces' },
    },
    opts = {
      load = {
        ['core.defaults'] = {},
        -- ['core.keybinds'] = {},
        ['core.summary'] = {},
        ['core.completion'] = {
          config = {
            engine = 'nvim-cmp',
          },
        },
        -- Fix norg_neta parser not found error
        ['core.integrations.treesitter'] = {
          config = {
            configure_parsers = false,
            warn_missing_parsers = false,
          },
        },
        ['core.dirman'] = {
          config = {
            workspaces = {
              vector = '~/Vector/notes',
              notes = '~/Library/Mobile Documents/com~apple~CloudDocs/Documents/Notes',
            },
          },
        },
        ['core.concealer'] = {
          config = {
            -- https://www.nerdfonts.com/cheat-sheet
            -- <Cmd>neorg-cheatsheet-lists<CR>
            icons = {
              todo = {
                done = { icon = '󰄬' }, --    
                -- cancelled = { icon = '󰖭' }, --   󰖭  󰩺 
                on_hold = { icon = '' }, --  󰏤 
                pending = { icon = '' }, --     
                -- recurring = { icon = '' }, --     
                uncertain = { icon = '?' }, --  ?
                urgent = { icon = '!' }, --  󰈅
              },
            },
          },
        },
      },
    },
  },
}
