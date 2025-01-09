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
          { 'branch', icon = { '' } },
          -- { 'diff' },
          -- { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } },
          -- { 'diff', symbols = { added = '＋', modified = '～', removed = '－' } },
          { 'diff', symbols = { added = '+', modified = '±', removed = '-' } },
        },
        lualine_c = {
          -- { 'filetype', colored = true, icon_only = true, icon = { align = 'left' } },
          {
            'filename',
            newfile_status = false, -- Display new file status (new file means no write after created)
            file_status = true,     -- Displays file status (readonly status, modified status)
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
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
          },
          -- { current_date },
          -- {
          --   current_time,
          --   icon = { '', color = { fg = '#61afef' } },
          --   color = { fg = '#a0a8b7' },
          -- },
          { 'filetype' },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            newfile_status = false, -- Display new file status (new file means no write after created)
            file_status = true,     -- Displays file status (readonly status, modified status)
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
