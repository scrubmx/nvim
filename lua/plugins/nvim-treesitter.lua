-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#lazynvim
-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Extra-modules-and-plugins
--
-- TODO: Install nvim-ts-autotag to close and rename HTML tags
-- https://github.com/windwp/nvim-ts-autotag
return {
  'nvim-treesitter/nvim-treesitter',
  -- event = { 'BufReadPre', 'BufNewFile' },
  -- event = { 'BufReadPost', 'BufNewFile' },
  -- cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
  lazy = false, -- Load on startup
  branch = 'master',
  build = ':TSUpdate',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-refactor', enabled = false }, -- There is a long-standing issue specifically for “Highlight definitions leads to Error detected while processing CursorHold
    'RRethy/nvim-treesitter-endwise', -- Wisely add 'end' in Elixir, Lua, Ruby, etc.
    'windwp/nvim-ts-autotag',         -- Auto close and auto rename HTML tags
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      -- List of additional modules to load, e.g. 'nvim-treesitter-refactor'
      modules = {},

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      -- List of parsers to ignore installing (or 'all')
      ignore_install = {},

      -- Consistent syntax highlighting
      highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },

      -- Indentation based on treesitter for the = operator
      indent = {
        enable = true,
        disable = {
          'php',
        },
      },

      -- Refactor module for nvim-treesitter
      -- https://github.com/nvim-treesitter/nvim-treesitter-refactor
      refactor = {
        highlight_definitions = {
          enable = false, -- Set to false since we disabled nvim-treesitter-refactor due to an issue
          clear_on_cursor_move = true, -- Set to false if you have an `updatetime` of ~100
        },
        smart_rename = {
          enable = true,
          -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
          keymaps = {
            smart_rename = 'grr',
          },
        },
      },

      -- Wisely add 'end' in Elixir, Lua, Ruby, etc.
      -- https://github.com/RRethy/nvim-treesitter-endwise
      endwise = { enable = true },

      -- A list of parser names, or 'all' (the listed parsers MUST always be installed)
      -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
      ensure_installed = {
        'bash',
        'blade',
        'clojure',
        'css',
        'diff',
        'dockerfile',
        'dot',
        'eex',
        'elixir',
        'erlang',
        'gleam',
        'graphql',
        'heex',
        'html',
        'http',
        'javascript',
        'json',
        'jsonc',
        'latex',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'norg',
        'php',
        'phpdoc',
        'python',
        'regex',
        'ruby',
        'scss',
        'sql',
        'tmux',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'vue',
        'yaml',
      },
    })

    -- Auto close and auto rename html tags
    -- https://github.com/windwp/nvim-ts-autotag
    -- https://github.com/windwp/nvim-ts-autotag#setup
    require('nvim-ts-autotag').setup({
      opts = {
        enable_close = true,          -- Auto close tags
        enable_rename = true,         -- Auto rename pairs of tags
        enable_close_on_slash = true, -- Auto close on trailing </
      },
    })
  end,
}
