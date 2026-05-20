-- Easily install and manage LSP servers, DAP servers, linters, and formatters
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason.nvim#default-configuration
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local function prepend_mason_bin()
  local mason_bin = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'bin')
  local path_sep = package.config:sub(1, 1) == '\\' and ';' or ':'
  local path = vim.env.PATH or ''

  if not vim.tbl_contains(vim.split(path, path_sep, { plain = true }), mason_bin) then
    vim.env.PATH = mason_bin .. (path == '' and '' or path_sep .. path)
  end
end

return {
  {
    'williamboman/mason.nvim',
    cmd = {
      'Mason',
      'MasonInstall',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonUpdate',
      'MasonLog',
    },
    init = prepend_mason_bin,
    opts = {
      PATH = 'skip',
      ui = {
        border = 'rounded', -- Options: 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
        width = 0.8,
        height = 0.8,
        icons = {
          package_installed = '󰗠',
          package_pending = '󰥔',
          package_uninstalled = '󰅙',
        },
      },
    },
  },

  -- Install and upgrade third party tools automatically
  -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
      ensure_installed = {
        'hadolint',
        'nginx-config-formatter',
        'prettierd',
        'stylua',
      },
      integrations = {
        ['mason-lspconfig'] = false,
        ['mason-null-ls'] = false,
        ['mason-nvim-dap'] = false,
      },
    },
  },

  -- Extension to mason.nvim that makes it easier to use lspconfig with mason
  -- https://github.com/williamboman/mason-lspconfig.nvim
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      automatic_enable = false,

      -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
      -- https://www.elixir-tools.dev/docs/next-ls/installation/#masonnvim
      -- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
      -- https://github.com/elixir-tools/elixir-tools.nvim
      ensure_installed = {
        -- 'erlangls',
        -- 'gleam',
        -- 'nextls',
        -- 'phpactor',
        'bashls',
        'cmake',
        'cssls',
        'dockerls',
        'dotls',
        'elixirls',
        'emmet_ls',
        'eslint',
        'graphql',
        'html',
        'intelephense',
        'jsonls',
        'lua_ls',
        'marksman',
        'pylsp',
        'tailwindcss',
        'ts_ls',
        'yamlls',
      },
    },
  },
}
