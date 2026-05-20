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
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- Prefer external formatters where none-ls is configured, and avoid ts_ls/vtsls
    -- formatting for JavaScript and TypeScript buffers.
    local format_client_priority_by_ft = {
      lua = { 'null-ls', 'lua_ls' },

      javascript = { 'null-ls', 'eslint' },
      javascriptreact = { 'null-ls', 'eslint' },
      ['javascript.jsx'] = { 'null-ls', 'eslint' },
      typescript = { 'null-ls', 'eslint' },
      typescriptreact = { 'null-ls', 'eslint' },
      ['typescript.tsx'] = { 'null-ls', 'eslint' },

      css = { 'null-ls', 'cssls' },
      scss = { 'null-ls', 'cssls' },
      less = { 'null-ls', 'cssls' },
      html = { 'null-ls', 'html' },
      json = { 'null-ls', 'jsonls' },
      jsonc = { 'null-ls', 'jsonls' },

      php = { 'intelephense' },

      elixir = { 'null-ls' },
      eelixir = { 'null-ls' },
      heex = { 'null-ls' },
      nginx = { 'null-ls' },
    }

    local function select_format_client(bufnr)
      local clients = vim.lsp.get_clients({
        bufnr = bufnr,
        method = 'textDocument/formatting',
      })

      if #clients == 0 then
        return nil
      end

      local priority = format_client_priority_by_ft[vim.bo[bufnr].filetype]

      if priority then
        for _, client_name in ipairs(priority) do
          for _, client in ipairs(clients) do
            if client.name == client_name then
              return client
            end
          end
        end

        return nil
      end

      if #clients == 1 then
        return clients[1]
      end

      table.sort(clients, function(a, b)
        return a.name < b.name
      end)

      return clients[1]
    end

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
          local client = select_format_client(event.buf)

          if not client then
            vim.notify('No LSP formatter configured for ' .. vim.bo[event.buf].filetype, vim.log.levels.WARN)
            return
          end

          vim.lsp.buf.format({
            async = true,
            bufnr = event.buf,
            filter = function(format_client)
              return format_client.id == client.id
            end,
          })
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

        map('n', 'çd', '<Cmd>Telescope diagnostics bufnr=0<CR>', merge(bufopts, { desc = 'LSP Buffer diagnostics' }))
        -- map('n', 'çn', vim.diagnostic.goto_next, merge(bufopts, { desc = 'Move to the next diagnostic' }))
        -- map('n', 'çp', vim.diagnostic.goto_prev, merge(bufopts, { desc = 'Move to the previous diagnostic' }))
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
