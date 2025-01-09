-- Easily install and manage LSP servers, DAP servers, linters, and formatters
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason.nvim#default-configuration
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    -- Easily install and manage LSPs, linters, and formatters
    -- https://github.com/williamboman/mason.nvim
    -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
    require('mason').setup({
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
    })

    -- Install and upgrade third party tools automatically
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    require('mason-tool-installer').setup({
      ensure_installed = {
        'stylua',
        'prettierd',
      },
    })

    -- Extension to mason.nvim that makes it easier to use lspconfig with mason
    -- https://github.com/williamboman/mason-lspconfig.nvim
    require('mason-lspconfig').setup({
      automatic_installation = true,

      -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
      -- https://www.elixir-tools.dev/docs/next-ls/installation/#masonnvim
      -- https://github.com/elixir-tools/elixir-tools.nvim
      ensure_installed = {
        -- 'erlangls',
        -- 'intelephense',
        -- 'phpactor',
        'bashls',
        'cmake',
        'cssls',
        'dotls',
        'elixirls',
        'emmet_ls',
        'eslint',
        'graphql',
        'html',
        'jsonls',
        'lua_ls',
        'marksman',
        'pylsp',
        'tailwindcss',
        'ts_ls',
        'yamlls',
      },
    })
  end,
}
