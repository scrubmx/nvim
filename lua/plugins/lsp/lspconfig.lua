-- Quickstart configs for Nvim LSP
-- https://github.com/neovim/nvim-lspconfig
-- https://youtu.be/6pAG3BHurdM?si=mK3TD6qWHDP8Tv2W&t=3653
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'folke/neodev.nvim',
    'hrsh7th/cmp-nvim-lsp',
    -- 'hrsh7th/cmp-buffer',
    -- 'hrsh7th/cmp-cmdline',
    -- 'hrsh7th/cmp-nvim-lua', ?
    -- 'hrsh7th/cmp-nvim-lsp-signature-help', ?
    -- 'saadparwaiz1/cmp_luasnip', ?
    -- 'hrsh7th/cmp-path',
    -- {
    --   'folke/lazydev.nvim',
    --   ft = 'lua',
    --   opts = {
    --     library = {
    --       -- See the configuration section for more details
    --       -- Load luvit types when the `vim.uv` word is found
    --       { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    --     },
    --   },
    -- },

    -- Automatically install LSPs and related tools to stdpath for neovim
    -- 'williamboman/mason.nvim',
    -- 'williamboman/mason-lspconfig.nvim',
    -- 'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('LspConfigGroup', { clear = true }),
      callback = function(event)
        -- Buffer local keymaps
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { buffer = event.buf, silent = true, noremap = true }

        -- vim.keymap.set('n', 'gR', '<Cmd>Telescope lsp_references<CR>', bufopts)
        -- vim.keymap.set('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', bufopts)
        -- vim.keymap.set('n', 'gi', '<Cmd>Telescope lsp_implementations<CR>', bufopts)
        -- vim.keymap.set('n', 'gt', '<Cmd>Telescope lsp_type_definitions<CR>', bufopts)
        -- vim.keymap.set('n', '<Leader>D', '<Cmd>Telescope diagnostics bufnr=0<CR>', bufopts)
        -- vim.keymap.set('n', '<Leader>d', vim.diagnostics.open_float, bufopts)

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
          vim.tbl_extend('keep', bufopts, { desc = 'LSP Jump to declaration' }))
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
          vim.tbl_extend('keep', bufopts, { desc = 'LSP Jump to definition' }))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references,
          vim.tbl_extend('keep', bufopts, { desc = 'LSP List all references' }))
        vim.keymap.set('n', 'K', vim.lsp.buf.hover,
          vim.tbl_extend('keep', bufopts, { desc = 'LSP Display information about the symbol' }))
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
          vim.tbl_extend('keep', bufopts, { desc = 'LSP Display signature information' }))
        vim.keymap.set('n', '<Space>r', vim.lsp.buf.rename,
          vim.tbl_extend('keep', bufopts, { desc = 'LSP Rename all symbol references' }))
        vim.keymap.set('n', '<Space>f', function() vim.lsp.buf.format({ async = true }) end,
          vim.tbl_extend('keep', bufopts, { desc = 'LSP Format the current buffer' }))
        vim.keymap.set({ 'n', 'v' }, '<Space>a', vim.lsp.buf.code_action,
          vim.tbl_extend('keep', bufopts, { desc = 'LSP Display code actions menu' }))

        local opts = { noremap = true, silent = true }

        vim.keymap.set('n', 'çn', vim.diagnostic.goto_next,
          vim.tbl_extend('keep', opts, { desc = 'Move to the next diagnostic' }))
        vim.keymap.set('n', 'çb', vim.diagnostic.goto_prev,
          vim.tbl_extend('keep', opts, { desc = 'Move to the previous diagnostic' }))
        vim.keymap.set('n', 'çp', vim.diagnostic.goto_prev,
          vim.tbl_extend('keep', opts, { desc = 'Move to the previous diagnostic' }))
      end,
    })

    -- Setup diagnostic symbols for each error level
    local symbols = { Error = ' ', Hint = ' ', Info = ' ', Warn = ' ' }

    for type, icon in pairs(symbols) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    -- LSP servers and clients can communicate to each other what features they support.
    -- By default, Neovim doesn't support everything in the LSP specification.
    -- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    -- So, we create new capabilities with nvim-cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Use mason-lspconfig to setup default and custom server handlers
    require('mason-lspconfig').setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      -- TODO: Don't know if this is necessary or smart (maybe remove it?)
      -- lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, function(config)
      --   if config.name == "elixirls" then
      --     local custom_server_prefix = "/Users/scrub/.local/share/nvim/mason"
      --     config.cmd = { custom_server_prefix .. "/bin/elixir-ls" }
      --   end
      -- end)

      -- https://github.com/elixir-lsp/elixir-ls
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
      elixirls = function()
        lspconfig.elixirls.setup({
          capabilities = capabilities,
          cmd = { '/Users/scrub/.local/share/nvim/mason/bin/elixir-ls' },
          settings = {
            elixirLS = {
              dialyzerEnabled = true,
              enableTestLenses = false,
              fetchDeps = false,
              suggestSpecs = true,
              hint = { enabled = true },
            },
          },
        })
      end,

      graphql = function()
        lspconfig.graphql.setup({
          capabilities = capabilities,
          filetypes = { 'graphql', 'gql', 'elixir', 'typescriptreact', 'javascriptreact' },
        })
      end,

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
      lua_ls = function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              telemetry = { enable = false },
              diagnostics = {
                globals = { 'vim' },
                neededFileStatus = { ['codestyle-check'] = 'Any' },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- format = {
              --   enable = true,
              --   defaultConfig = {
              --     indent_style = 'space',
              --     indent_size = '2',
              --   },
              -- },
            },
          },
        })
      end,
    })

    -- require('lspconfig').lua_ls.setup({})
    --
    -- vim.api.nvim_create_autocmd('LspAttach', {
    --   callback = function(args)
    --     local client = vim.lsp.get_client_by_id(args.data.client_id)
    --
    --     if not client then return end
    --
    --     if client.supports_method('textDocument/formatting') then
    --       -- Format the current buffer on save
    --       vim.api.nvim_create_autocmd('BufWritePre', {
    --         buffer = args.buf,
    --         callback = function()
    --           vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
    --         end,
    --       })
    --     end
    --   end,
    -- })
  end,
}
