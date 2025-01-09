-- Plugin to improve viewing Markdown files in Neovim
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- https://github.com/MeanderingProgrammer/render-markdown.nvim#commands
-- https://github.com/MeanderingProgrammer/render-markdown.nvim#setup
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  cond = false,
  config = function()
    require('render-markdown').setup({
      sign = { enabled = false },
      heading = {
        -- icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        icons = { '󰉫 ', '󰉬 ', '󰉭 ', '󰉮 ', '󰉯 ', '󰉰 ' },
        signs = { '󰫎 ' },
        backgrounds = {
          'RenderMarkdownH1Bg',
          'RenderMarkdownH2Bg',
          'RenderMarkdownH3Bg',
          'RenderMarkdownH4Bg',
          'RenderMarkdownH5Bg',
          'RenderMarkdownH6Bg',
        },
        -- backgrounds = {},
      },
      bullet = {
        -- icons = { '●', '○', '◆', '◇' },
        icons = { '⦿', '⦾', '◆', '◇' },
      },
      checkbox = {
        unchecked = {
          icon = '󰄱 ',
        },
        checked = {
          icon = '󰱒 ',
        },
        --[[
        Define custom checkbox states, more involved as they are not part of the markdown grammar
        As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
        Can specify as many additional states as you like following the 'todo' pattern below

        The key in this case 'todo' is for healthcheck and to allow users to change its values:
        - raw                Matched against the raw text of a 'shortcut_link'
        - rendered           Replaces the 'raw' value when rendering
        - highlight          Highlight for the 'rendered' icon
        - scope_highlight    Highlight for item associated with custom checkbox
        ]]
        custom = {
          urgent = { raw = '[!]', rendered = '󰳤 ', highlight = 'RenderMarkdownUrgent', scope_highlight = nil },
          pending = { raw = '[-]', rendered = '󰐋 ', highlight = 'RenderMarkdownPending', scope_highlight = nil },
        },
        link = {
          -- Turn on / off inline link icon rendering
          enabled = true,
          -- Inlined with 'image' elements
          image = '󰥶 ',
          -- Inlined with 'email_autolink' elements
          email = '󰀓 ',
          -- Fallback icon for 'inline_link' elements
          hyperlink = '󰌹 ',
          -- Applies to the fallback inlined icon
          highlight = 'RenderMarkdownLink',
          -- Applies to WikiLink elements
          wiki = { icon = '󱗖 ', highlight = 'RenderMarkdownWikiLink' },
          -- Define custom destination patterns so icons can quickly inform you of what a link
          -- contains. Applies to 'inline_link' and wikilink nodes.
          -- Can specify as many additional values as you like following the 'web' pattern below
          --   The key in this case 'web' is for healthcheck and to allow users to change its values
          --   'pattern':   Matched against the destination text see :h lua-pattern
          --   'icon':      Gets inlined before the link text
          --   'highlight': Highlight for the 'icon'
          custom = {
            web = { pattern = '^http[s]?://', icon = ' ', highlight = 'RenderMarkdownLink' },
          },
        },
      },
    })

    -- Customize colosr for the custom tasks
    vim.api.nvim_set_hl(0, 'RenderMarkdownUnchecked', { fg = '#a0a8b7' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownChecked', { fg = '#a6e3a1' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownUrgent', { fg = '#f38ba8' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownPending', { fg = '#f9e2af' })

    require('render-markdown').enable()
  end,
}
