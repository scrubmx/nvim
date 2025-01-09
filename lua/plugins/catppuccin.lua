-- Soothing pastel theme for Neovim
-- https://github.com/catppuccin/nvim
-- https://github.com/catppuccin/nvim#configuration
--
-- Catppuccin Color Palette
-- https://catppuccin.com/palette
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      transparent_background = true,
      default_integrations = true,
      -- List of supported plugins and their corresponding integration module
      -- https://github.com/catppuccin/nvim#integrations
      integrations = {
        -- diffview = true,
        -- neotest = true,
        -- noice = true,
        -- render_markdown = true,
        -- ufo = true,
        cmp = true,
        gitsigns = true,
        harpoon = true,
        markdown = true,
        mason = true,
        mini = {
          enabled = true,
          indentscope_color = '#1e1e2e',
        },
        neotree = true,
        notify = true,
        treesitter = true,
        telescope = { enabled = true },
        indent_blankline = { enabled = true },
        which_key = true,
      },
    })

    vim.cmd.colorscheme('catppuccin-mocha')
  end,
}
