-- This plugin adds indentation guides to Neovim.
-- It uses Neovim's virtual text feature and no conceal
-- https://github.com/lukas-reineke/indent-blankline.nvim
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = 'VeryLazy',
  config = function()
    local hooks = require('ibl.hooks')

    -- https://catppuccin.com/palette#flavor-mocha
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#181825' })
      vim.api.nvim_set_hl(0, 'IblWhitespace', { fg = '#313244' })
      vim.api.nvim_set_hl(0, 'IblScope', { fg = '#313244' })
    end)

    require('ibl').setup({
      indent = {
        -- Character, or list of characters, that get used to display the indentation guide
        -- Manual: `:help ibl.config.indent.char`
        -- GitHub: http://bit.ly/41xyKzc
        --
        -- Left empty for now as I believe the UI looks cleaner this way
        char = ' ', -- Options: '│', '╎', '┆', '╏', '▏'
        highlight = 'IblIndent',
        smart_indent_cap = true,
      },
      whitespace = {
        highlight = 'IblWhitespace',
        remove_blankline_trail = true,
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        char = '▏',
        highlight = 'IblScope',
        injected_languages = true,
        include = {
          node_type = {
            -- lua = { 'return_statement', 'table_constructor' },
            lua = { 'table_constructor' },
          },
        },
      },
    })

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
