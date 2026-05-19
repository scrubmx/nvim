-- Quickstart configs for Nvim LSP
-- https://github.com/neovim/nvim-lspconfig
-- https://youtu.be/6pAG3BHurdM?si=mK3TD6qWHDP8Tv2W&t=3653
--
-- TODO: Checkout https://github.com/SylvanFranklin/.config/blob/main/nvim/lua/sylvanfranklin/plugins/lsp.lua
return {
  'neovim/nvim-lspconfig',
  tag = 'v1.8.0',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'folke/neodev.nvim',
    'hrsh7th/cmp-nvim-lsp',
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
  },
  config = function()
    local lspconfig = require('lspconfig')

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('LspConfigGroup', { clear = true }),
      callback = function(event)
        local map = vim.keymap.set
        local merge = function(table, extra)
          return vim.tbl_extend('keep', table, extra)
        end

        -- Buffer local keymaps
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { buffer = event.buf, silent = true, noremap = true }

        --[[
        Telescope LSP features:
          - Telescope lsp_definitions
          - Telescope lsp_document_symbols
          - Telescope lsp_dynamic_workspace_symbols
          - Telescope lsp_implementations
          - Telescope lsp_incoming_calls
          - Telescope lsp_outgoing_calls
          - Telescope lsp_references
          - Telescope lsp_type_definitions
          - Telescope lsp_workspace_symbols

        Nvim LSP features:
          - vim.lsp.buf.hover()
          - vim.lsp.buf.format()
          - vim.lsp.buf.rename()
          - vim.lsp.buf.completion()
          - vim.lsp.buf.definition()
          - vim.lsp.buf.formatting()
          - vim.lsp.buf.references()
          - vim.lsp.buf.code_action()
          - vim.lsp.buf.declaration()
          - vim.lsp.buf.server_ready()
          - vim.lsp.buf.typehierarchy()
          - vim.lsp.buf.incoming_calls()
          - vim.lsp.buf.outgoing_calls()
          - vim.lsp.buf.signature_help()
          - vim.lsp.buf.implementation()
          - vim.lsp.buf.document_symbol()
          - vim.lsp.buf.execute_command()
          - vim.lsp.buf.formatting_sync()
          - vim.lsp.buf.type_definition()
          - vim.lsp.buf.clear_references()
          - vim.lsp.buf.range_formatting()
          - vim.lsp.buf.workspace_symbol()
          - vim.lsp.buf.range_code_action()
          - vim.lsp.buf.document_highlight()
          - vim.lsp.buf.add_workspace_folder()
        --]]
        map('n', 'gr', vim.lsp.buf.rename, merge(bufopts, { desc = 'LSP Rename all symbol references' }))
        map('n', 'gd', vim.lsp.buf.definition, merge(bufopts, { desc = 'LSP Jump to symbol definition' }))
        map('n', 'K', vim.lsp.buf.hover, merge(bufopts, { desc = 'LSP Display symbol information' }))
        map('n', '<C-k>', vim.lsp.buf.signature_help, merge(bufopts, { desc = 'LSP Display signature information' }))
        map('n', '<Space>f', function()
          vim.lsp.buf.format({ async = true })
        end, merge(bufopts, { desc = 'LSP Format the current buffer' }))
        map(
          { 'n', 'v' },
          '<Space>a',
          vim.lsp.buf.code_action,
          merge(bufopts, { desc = 'LSP Display code actions menu' })
        )
        map('n', '<Space>d', '<Cmd>Telescope lsp_definitions<CR>', bufopts)
        map('n', '<Space>r', '<Cmd>Telescope lsp_references<CR>', bufopts)
        map('n', '<Space>s', '<Cmd>Telescope lsp_document_symbols<CR>', bufopts)
        map('n', '<Space>S', '<Cmd>Telescope lsp_workspace_symbols<CR>', bufopts)

        local opts = { noremap = true, silent = true }

        map('n', 'çd', '<Cmd>Telescope diagnostics bufnr=0<CR>', opts)
        -- map('n', 'çn', vim.diagnostic.goto_next, merge(opts, { desc = 'Move to the next diagnostic' }))
        -- map('n', 'çp', vim.diagnostic.goto_prev, merge(opts, { desc = 'Move to the previous diagnostic' }))
      end,
    })

    -- Setup diagnostic symbols for each error level
    -- local symbols = { Error = ' ', Hint = ' ', Info = ' ', Warn = ' ' }
    --
    -- for type, icon in pairs(symbols) do
    --   local hl = 'DiagnosticSign' .. type
    --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    -- end

    -- LSP servers and clients can communicate to each other what features they support.
    -- By default, Neovim doesn't support everything in the LSP specification.
    -- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    -- So, we create new capabilities with nvim-cmp, and then broadcast that to the servers.
    local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = vim.tbl_deep_extend('force', lsp_capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- -- Add the border on hover and on signature help popup window
    -- local handlers = {
    --   ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    --     border = 'rounded',
    --     focusable = false,
    --     max_width = 100,
    --     max_height = 25,
    --     highlight = 'NormalFloat',
    --   }),
    --   ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    --     border = 'rounded',
    --     focusable = false,
    --   }),
    -- }

    -- Nvim 11.0+ supports the `vim.lsp.config` function to configure LSP servers
    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    -- "ts_ls" or "vtsls" for TypeScript
    local ts_server = vim.g.lsp_typescript_server or 'ts_ls'

    -- Enable LSP servers for Neovim 0.11+
    vim.lsp.enable({
      ts_server,
      'lua_ls', -- Lua
      -- 'cssls',        -- CSS
      -- 'dockerls',     -- Docker
      -- 'elixirls',     -- Elixir
      'eslint',       -- ESLint
      -- 'html',         -- HTML
      'intelephense', -- PHP
      -- 'jsonls',       -- JSON
      -- 'marksman',     -- Markdown
      'tailwindcss', -- Tailwind CSS
      -- 'yamlls',       -- YAML
      -- 'biome',       -- Biome = Eslint + Prettier
      -- 'pyright',     -- Python
    })

    -- Load Lsp on-demand, e.g: eslint is disable by default
    -- e.g: We could enable eslint by set vim.g.lsp_on_demands = {"eslint"}
    if vim.g.lsp_on_demands then
      vim.lsp.enable(vim.g.lsp_on_demands)
    end

    -- require('mason-lspconfig').setup({
    --   ensure_installed = { 'lua_ls' },
    --   automatic_enable = true,
    -- })

    -- Use mason-lspconfig to setup default and custom server handlers
    -- require('mason-lspconfig').setup_handlers({
    --   function(server_name)
    --     lspconfig[server_name].setup({
    --       capabilities = capabilities,
    --       handlers = handlers,
    --     })
    --   end,

    -- cssls = function()
    --   lspconfig.cssls.setup({
    --     capabilities = capabilities,
    --     handlers = handlers,
    --     settings = {
    --       css = {
    --         lint = {
    --           unknownAtRules = 'ignore',
    --         },
    --       },
    --     },
    --   })
    -- end,

    -- https://github.com/elixir-lsp/elixir-ls
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
    -- elixirls = function()
    --   lspconfig.elixirls.setup({
    --     capabilities = capabilities,
    --     handlers = handlers,
    --     cmd = { '/Users/scrub/.local/share/nvim/mason/bin/elixir-ls' },
    --     settings = {
    --       elixirLS = {
    --         dialyzerEnabled = true,
    --         enableTestLenses = false,
    --         fetchDeps = false,
    --         suggestSpecs = true,
    --         hint = { enabled = true },
    --       },
    --     },
    --   })
    -- end,

    -- graphql = function()
    --   lspconfig.graphql.setup({
    --     capabilities = capabilities,
    --     handlers = handlers,
    --     filetypes = { 'graphql', 'gql', 'elixir', 'typescriptreact', 'javascriptreact' },
    --   })
    -- end,
    --
    --

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
    lspconfig.lua_ls.setup({
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            },
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
            -- library = vim.api.nvim_get_runtime_file("", true)
          },
        })
      end,
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
        },
      },
    })

    -- })
    -- vim.cmd([[highlight! default link CmpItemKind CmpItemMenuDefault]])
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.HINT] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      },
      underline = true,
      virtual_text = true,
      float = {
        source = false,
        focusable = false,
        show_header = true,
        border = 'rounded',
      },
    })
  end,
}
