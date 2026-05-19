-- A blazing fast and easy to configure neovim statusline plugin
-- https://github.com/nvim-lualine/lualine.nvim
-- https://github.com/nvim-lualine/lualine.nvim#lua-functions-as-lualine-component
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- local current_date = function() return os.date("%a %d %b") end
    -- local current_time = function() return os.date("%H:%M") end

    -- https://catppuccin.com/palette/#flavor-mocha
    local ok_palette, palette = pcall(require, 'catppuccin.palettes')
    local colors = {}

    if not ok_palette then
      -- Fallback colors if palette is not available
      colors = {
        text = '#cdd6f4',
        blue = '#89b4fa',
        surface0 = '#313244',
        base = '#1e1e2e',
        mantle = '#181825',
      }

      vim.api.nvim_echo({ { 'lualine: catppuccin.palettes not found!', 'WarningMsg' } }, true, {})
    else
      colors = palette.get_palette('mocha')
    end

    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'catppuccin-mocha',
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        component_separators = '',
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
      },
      -- General component options
      -- https://github.com/nvim-lualine/lualine.nvim#general-component-options
      sections = {
        lualine_a = {
          'mode', -- { 'mode', icon = '' },
        },
        lualine_b = {
          -- { 'branch', icon = { '' }, separator = '', color = { fg = '', bg = '' } },
          {
            'branch',
            icon = { '' },
            separator = { right = '' },
            color = { bg = colors.surface0 },
            colored = true,
          },
          -- { 'diff' },
          -- { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } },
          -- { 'diff', symbols = { added = '＋', modified = '～', removed = '－' } },
          {
            'diff',
            symbols = { added = '+', modified = '±', removed = '-' },
            separator = { right = '' },
            color = { bg = colors.base },
            colored = true,
          },
        },
        lualine_c = {
          -- { 'filetype', colored = true, icon_only = true, icon = { align = 'left' } },
          {
            'filename',
            newfile_status = false, -- Display new file status (new file means no write after created)
            file_status = true, -- Displays file status (readonly status, modified status)
            -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory
            path = 1,
            -- padding = -10,
          },
        },
        lualine_x = {
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })

              if #clients == 0 then
                return 'None'
              end

              return #clients
            end,
            color = { fg = colors.text },
            icon = { '', color = { fg = colors.blue } },
            spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }, -- Standard unicode symbols to cycle through for LSP progress (I dont know if this works)
            on_click = function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              local names = {}

              for _, client in ipairs(clients) do
                table.insert(names, ' • ' .. client.name)
              end

              local ok_notify, notify = pcall(require, 'notify')

              if not ok_notify then
                vim.api.nvim_echo({ { 'LSP Clients: ' .. table.concat(names, ''), 'InfoMsg' } }, true, {})

                return
              end

              if #names == 0 then
                notify('No active LSP clients', vim.log.levels.WARN, { title = 'LSP Clients' })
              else
                notify(table.concat(names, '\n'), vim.log.levels.INFO, { title = 'LSP Clients' })
              end
            end,
          },
          -- {
          --   'lsp_status', -- https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/components/lsp_status.lua
          --   icon = { '󰆧', color = { fg = colors.blue } },
          --   color = { fg = colors.text },
          --   symbols = {
          --     spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }, -- Standard unicode symbols to cycle through for LSP progress
          --     done = '✓', -- Standard unicode symbol for when LSP is done
          --     separator = ' ', -- Delimiter inserted between LSP names
          --   },
          --   ignore_lsp = { 'copilot', 'emmet_ls', 'graphql', 'null-ls' }, -- List of LSP names to ignore (e.g. 'null-ls')
          -- },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }, -- hint = ' '
            -- symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }, -- hint = ' '
            separator = { left = '' },
            color = { bg = colors.mantle },
            colored = true,
          },
          -- { current_date },
          -- {
          --   current_time,
          --   icon = { '', color = { fg = colors.blue } },
          --   color = { fg = colors.text },
          -- },
          {
            'filetype',
            color = { bg = colors.base },
            separator = { left = '' },
            colored = true,
            icon = { align = 'left' },
          },
        },
        lualine_y = {
          'progress',
        },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            newfile_status = false, -- Display new file status (new file means no write after created)
            file_status = true, -- Displays file status (readonly status, modified status)
            -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory
            path = 1,
          },
        },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      -- Available extensions
      -- https://github.com/nvim-lualine/lualine.nvim#available-extensions
      extensions = {
        'fugitive',
        'lazy',
        'man',
        'mason',
        'neo-tree',
        -- 'aerial',
        -- 'assistant',
        -- 'avante',
        -- 'chadtree',
        -- 'ctrlspace',
        -- 'fern',
        -- 'fzf',
        -- 'mundo',
        -- 'nerdtree',
        -- 'nvim-dap-ui',
        -- 'nvim-tree',
        -- 'oil',
        -- 'overseer',
        -- 'quickfix',
        -- 'symbols-outline',
        -- 'toggleterm',
        -- 'trouble',
      },
    })
  end,
}
