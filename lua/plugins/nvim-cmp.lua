-- A completion plugin for neovim coded in Lua
-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Autocompletion
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    -- 'lukas-reineke/cmp-under-comparator', -- Better sort underscore items

    -- Snippets
    { 'L3MON4D3/LuaSnip', version = 'v2.*', run = 'make install_jsregexp' },
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',

    -- Icons and Colors
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    -- Snippets configuration
    luasnip.config.set_config({
      region_check_events = 'InsertEnter',
      delete_check_events = 'InsertLeave',
    })

    -- Load custom user snipets
    -- https://github.com/L3MON4D3/LuaSnip#add-snippets
    require('luasnip.loaders.from_vscode').lazy_load({ paths = { '~/.config/nvim/snippets' } })

    -- Helper to insert text in a more natural way
    local function has_words_before()
      if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
        return false
      end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
    end

    -- Nvim Cmp Configuration
    -- https://github.com/hrsh7th/nvim-cmp
    cmp.setup({
      completion = {
        -- completeopt = 'menu,menuone,preview,noinsert,noselect',
        completeopt = 'menuone,preview,noinsert,noselect',
      },
      performance = {
        max_view_entries = 25,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
      },
      window = {
        completion = cmp.config.window.bordered({
          border = 'rounded',
          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
          col_offset = -2,  -- Offsets the completion window relative to the cursor
          side_padding = 1, -- The padding to add to the completion window sides
        }),
        documentation = cmp.config.window.bordered({
          border = 'rounded',
          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
        }),
      },
      formatting = {
        -- https://github.com/onsails/lspkind.nvim#configuration
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#show-devicons-as-kind-field
        -- https://github.com/onsails/lspkind.nvim/blob/d79a1c3299ad0ef94e255d045bed9fa26025dab6/lua/lspkind/init.lua#L8-L32
        --
        -- TODO: https://www.reddit.com/r/neovim/comments/103zetf/how_can_i_get_a_vscodelike_tailwind_css
        -- TODO: https://github.com/roobert/tailwindcss-colorizer-cmp.nvim
        format = lspkind.cmp_format({
          mode = 'symbol_text',     -- Options: 'text', 'text_symbol', 'symbol', 'symbol_text'
          show_labelDetails = true, -- Show labelDetails in menu. Disabled by default
          menu = {
            nvim_lsp = '[LSP]',
            nvim_lsp_signature_help = '[LSP]',
            luasnip = '[Snip]',
            nvim_lua = '[Lua]',
            buffer = '[Buff]',
            path = '[Path]',
          },
          symbol_map = {
            Copilot = '',
            Supermaven = '',
            Snippet = '',
            Function = '󰊕',
            Method = '',
            Field = '',
            Variable = '',
            Module = '',
          },
        }),
      },
      -- https://github.com/VonHeikemen/lsp-zero.nvim#keybindings-1
      mapping = cmp.mapping.preset.insert({
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        ['<CR>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Tab>'] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work)
    -- https://github.com/hrsh7th/cmp-cmdline#setup
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work)
    -- https://github.com/hrsh7th/cmp-cmdline#setup
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          option = { ignore_cmds = { 'Man', '!' } },
        },
      }),
      -- matching = { disallow_symbol_nonprefix_matching = false },
    })

    vim.cmd [[highlight! default link CmpItemKind CmpItemMenuDefault]]

    vim.diagnostic.config({
      signs = true,
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
