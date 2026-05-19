-- Library of 40+ independent Lua modules improving overall Neovim
-- https://github.com/echasnovski/mini.nvim
--
-- Each module is designed to solve a particular problem
-- https://github.com/echasnovski/mini.nvim#modules
return {
  -- Plugin to remove buffers
  -- https://github.com/echasnovski/mini.bufremove
  {
    'echasnovski/mini.bufremove',
    version = '*',
    keys = {
      {
        '<Leader>bd',
        function()
          require('mini.bufremove').delete(0, false)
        end,
        desc = 'Delete Buffer',
      },
      {
        '<Leader>bD',
        function()
          require('mini.bufremove').delete(0, true)
        end,
        desc = 'Delete Buffer (Force)',
      },
    },
  },

  -- Plugin to move any selection in any direction
  -- https://github.com/echasnovski/mini.move
  {
    'echasnovski/mini.move',
    version = '*',
    event = 'VeryLazy',
    cond = false, -- INFO: Don't load this plugin as Ctrl + Cmd is not working...
    opts = {
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
      mappings = {
        -- Move visual selection in Visual mode.(Ctrl + Cmd + hjkl)
        left = '<C-A-h>',
        right = '<C-A-l>',
        down = '<C-A-j>',
        up = '<C-A-k>',

        -- Move current line in Normal mode
        line_left = '<C-A-h>',
        line_right = '<C-A-l>',
        line_down = '<C-A-j>',
        line_up = '<C-A-k>',
      },
    },
  },

  -- Plugin to automatically manage character pairs (Part of mini.nvim library)
  -- https://github.com/echasnovski/mini.pairs
  -- https://github.com/echasnovski/mini.pairs#default-config
  {
    'echasnovski/mini.pairs',
    version = '*',
    event = 'VeryLazy',
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },

  -- Plugin to remove buffers (Part of mini.nvim library)
  -- https://github.com/echasnovski/mini.surround
  --
  -- Example: SomeRandomString. `saiw'` -> 'SomeRandomString'
  {
    'echasnovski/mini.surround',
    version = '*',
    event = 'VeryLazy',
    opts = {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil, -- Module mappings. Use `''` (empty string) to disable one.

      mappings = {
        add = 'sa',            -- Add surrounding in Normal and Visual modes
        delete = 'sd',         -- Delete surrounding
        find = 'sf',           -- Find surrounding (to the right)
        find_left = 'sF',      -- Find surrounding (to the left)
        highlight = 'sh',      -- Highlight surrounding
        replace = 'sr',        -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`
        suffix_last = 'l',     -- Suffix to search with "prev" method
        suffix_next = 'n',     -- Suffix to search with "next" method
      },
    },
  },
}
