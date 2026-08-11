-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#lazynvim
-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Extra-modules-and-plugins
return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = {
    'TSBufDisable',
    'TSBufEnable',
    'TSBufToggle',
    'TSConfigInfo',
    'TSDisable',
    'TSEditQuery',
    'TSEditQueryUserAfter',
    'TSEnable',
    'TSInstall',
    'TSInstallFromGrammar',
    'TSInstallInfo',
    'TSInstallSync',
    'TSModuleInfo',
    'TSToggle',
    'TSUninstall',
    'TSUpdate',
    'TSUpdateSync',
  },
  branch = 'master',
  build = ':TSUpdate',
  dependencies = {
    'RRethy/nvim-treesitter-endwise', -- Wisely add 'end' in Elixir, Lua, Ruby, etc.
    'windwp/nvim-ts-autotag',         -- Auto close and auto rename HTML tags
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      -- List of additional nvim-treesitter modules to load
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

    -- tree-sitter-php 0.24 exposes "yield from" as one token, but the
    -- current php_only query still refers to a standalone "from" node.
    local php_parser = vim.api.nvim_get_runtime_file('parser/php.so', false)[1]
    if php_parser then
      pcall(vim.treesitter.language.add, 'php', { path = php_parser })
    end
    local php_ok, php_language = pcall(vim.treesitter.language.inspect, 'php')
    if php_ok and not php_language.symbols['"from"'] and php_language.symbols['"yield from"'] ~= nil then
      local query_file = vim.api.nvim_get_runtime_file('queries/php_only/highlights.scm', false)[1]
      if query_file then
        local query = table.concat(vim.fn.readfile(query_file), '\n')
        if query:find('"from" @keyword.return', 1, true) or query:find('"?>"', 1, true) then
          vim.treesitter.query.set(
            'php',
            'highlights',
            query:gsub('"from"', '"yield from"'):gsub('"%?>"', '(php_end_tag)')
          )
        end
      end
    end

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
