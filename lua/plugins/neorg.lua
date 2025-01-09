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
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true,   -- This automatically runs `require('luarocks-nvim').setup()`
  },
  {
    'nvim-neorg/neorg',
    lazy = true,
    version = '*',
    ft = 'norg',
    -- config = true,
    -- build = ':Neorg sync-parsers'
    dependencies = { 'luarocks.nvim' },
    opts = {
      load = {
        ['core.defaults'] = {},
        ['core.keybinds'] = {},
        ['core.concealer'] = {
          config = {
            icons = {
              todo = {
                -- cancelled = { icon = '󰩺' },
                on_hold = { icon = '⏸' },
                pending = { icon = '' },
                recurring = { icon = '' },
                uncertain = { icon = '?' },
                urgent = { icon = '!' },
              },
            },
          },
        },
      },
    },
  },
}
