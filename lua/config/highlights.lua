-----------------------------------------------------------
-- Override theme colors
-----------------------------------------------------------

-- Use Treesitter :Inspect command to view the AST
-- https://www.youtube.com/watch?v=MpnjYb-t12A
--
-- Theme Colors:
-- https://catppuccin.com/palette#flavor-mocha
local M = {}

function M.apply()
  local colors = require('config.colors')

  -- Elixir Syntax ------------------------------------------

  -- vim.cmd('highlight @string.special.symbol.elixir guifg=#89dceb')
  vim.api.nvim_set_hl(0, '@string.special.symbol.elixir', { fg = colors.sky })

  -- Neorg Syntax -------------------------------------------

  vim.api.nvim_set_hl(0, '@neorg.anchors.declaration.norg', { fg = colors.teal })
  vim.api.nvim_set_hl(0, '@neorg.headings.1.title.norg', { fg = colors.red })
  vim.api.nvim_set_hl(0, '@neorg.links.description.norg', { fg = colors.sapphire })
  vim.api.nvim_set_hl(0, '@neorg.links.location.url.norg', { fg = colors.sapphire })
  vim.api.nvim_set_hl(0, '@neorg.lists.unordered.prefix.norg', { fg = colors.lavender })
  vim.api.nvim_set_hl(0, '@neorg.markup.spoiler', { fg = colors.overlay0, bg = 'none' })
  vim.api.nvim_set_hl(0, '@neorg.todo_items.cancelled.norg', { fg = colors.surface2 })
  vim.api.nvim_set_hl(0, '@neorg.todo_items.on_hold.norg', { fg = colors.sapphire })
  vim.api.nvim_set_hl(0, '@neorg.todo_items.pending.norg', { fg = colors.yellow })
  vim.api.nvim_set_hl(0, '@neorg.todo_items.urgent.norg', { fg = colors.red })

  vim.api.nvim_set_hl(0, '@markup.strong', { fg = colors.text })
  vim.api.nvim_set_hl(0, '@markup.italic', { fg = colors.text })

  -- Make LSP hover panels readable against the transparent editor background.
  -- vim.api.nvim_set_hl(0, 'NormalFloat', { fg = colors.text, bg = colors.base })
  -- vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.base, bg = colors.base })
  -- vim.api.nvim_set_hl(0, 'FloatShadow', { bg = colors.crust, blend = 30 })
  -- vim.api.nvim_set_hl(0, 'FloatShadowThrough', { bg = colors.crust, blend = 30 })
  vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = colors.surface0 })
  vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', { bg = colors.surface0 })
  -- vim.api.nvim_set_hl(0, "BorderBG", { fg = colors.overlay2 })
  -- vim.api.nvim_set_hl(0, 'Pmenu', { fg = colors.text })
  -- vim.api.nvim_set_hl(0, 'PmenuSel', { fg = colors.red })

  vim.api.nvim_set_hl(0, 'CmpItemKindSupermaven', { fg = '#61afef' })
end

return M
