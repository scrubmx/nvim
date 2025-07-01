-----------------------------------------------------------
-- Auto Commands
-----------------------------------------------------------

-- Show cursor line only in active window
local cursorGroup = vim.api.nvim_create_augroup('CursorGroup', { clear = true })

vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  desc = 'Enable `cursorline` when window gains focus',
  pattern = '*',
  group = cursorGroup,
  -- command = 'set cursorline',
  callback = function() vim.opt.cursorline = true end,
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  desc = 'Disable `cursorline` when window loses focus',
  pattern = '*',
  group = cursorGroup,
  -- command = 'setlocal nocursorline',
  callback = function() vim.opt_local.cursorline = false end,
})

-- Turn off paste mode when leaving insert mode
vim.api.nvim_create_autocmd('InsertLeave', {
  desc = 'Turn off paste mode when leaving insert mode',
  pattern = '*',
  group = vim.api.nvim_create_augroup('PasteGroup', { clear = true }),
  -- command = 'set nopaste',
  callback = function() vim.opt.paste = false end,
})

-- Highlight when yanking text
-- Try it with `yap` in normal mode
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('TextYankGroup', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Set conceallevel to conceal links and other stuff in norg files
-- See `:help conceallevel`
--
--  0  Text is shown normally
--  1  Text is replaced with one character (fallbacks to `listchars`)
--  2  Text is hidden unless it has a custom replacement (see `:syn-cchar`)
--  3  Text is completely hidden
-- vim.cmd("autocmd BufNewFile,BufRead *.norg setlocal conceallevel=3")
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  desc = 'Set `conceallevel` for norg files (3 – Concealed text is completely hidden)',
  pattern = '*.norg',
  group = vim.api.nvim_create_augroup('ConcealLevelGroup', { clear = true }),
  -- command = 'setlocal conceallevel=3',
  callback = function() vim.opt_local.conceallevel = 3 end,
})

-- Set the filetypes for specific file extensions
-- vim.cmd("autocmd BufNewFile,BufRead *.blade.php setlocal filetype=blade")
-- vim.cmd("autocmd BufNewFile,BufRead *.zsh-theme setlocal filetype=zsh")
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  desc = 'Set the filetypes for specific file extensions',
  pattern = '*.zsh-theme',
  group = vim.api.nvim_create_augroup('FileTypeGroup', { clear = true }),
  -- command = 'setlocal filetype=zsh',
  callback = function() vim.opt_local.filetype = 'zsh' end,
})

-- Set indentation width for specific filetypes
-- vim.cmd("autocmd FileType php setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab")
-- vim.cmd("autocmd FileType blade setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab")
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'FileType' }, {
  desc = 'Set indentation width to 4 for specific filetypes',
  pattern = '*.php',
  group = vim.api.nvim_create_augroup('IndentationGroup', { clear = true }),
  callback = function()
    -- vim.opt_local.shiftwidth = 4
    -- vim.opt_local.softtabstop = 4
    -- vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
  end,
})

-- Enable spell check for certain filetypes
-- https://github.com/adalessa/nvim/blob/9f7ef8669223eb7cdaf3f580dc8b6a7926807231/lua/config/autocmds.lua#L27C1-L33C3
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit', 'markdown', 'norg' },
  group = vim.api.nvim_create_augroup('SpellGroup', { clear = true }),
  callback = function()
    -- vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Undercurl (Let's try it out for a few days)
vim.cmd([[let &t_Cs = "\e[4:3m]"]])
vim.cmd([[let &t_Ce = "\e[4:0m]"]])

-----------------------------------------------------------
-- Override theme colors
-----------------------------------------------------------

-- Use Treesitter :Inspect command to view the AST
-- https://www.youtube.com/watch?v=MpnjYb-t12A
--
-- Theme Colors:
-- https://catppuccin.com/palette#flavor-mocha

-- Elixir Syntax ------------------------------------------

-- vim.cmd('highlight @string.special.symbol.elixir guifg=#89dceb')
vim.api.nvim_set_hl(0, '@string.special.symbol.elixir', { fg='#89dceb' })

-- Neorg Syntax -------------------------------------------

-- vim.cmd('highlight @neorg.anchors.declaration.norg guifg=#94e2d5')
-- vim.cmd('highlight @neorg.headings.1.title.norg guifg=#f38ba8')
-- vim.cmd('highlight @neorg.links.description.norg guifg=#74c7ec')
-- vim.cmd('highlight @neorg.links.location.url.norg guifg=#74c7ec')
-- vim.cmd('highlight @neorg.lists.unordered.prefix.norg guifg=#b4befe')
-- vim.cmd('highlight @neorg.markup.spoiler guifg=#6c7086 guibg=none')
-- vim.cmd('highlight @neorg.todo_items.cancelled.norg guifg=#585b70')
-- vim.cmd('highlight @neorg.todo_items.on_hold.norg guifg=#74c7ec')
-- vim.cmd('highlight @neorg.todo_items.pending.norg guifg=#f9e2af')
-- vim.cmd('highlight @neorg.todo_items.urgent.norg guifg=#f38ba8')
--
-- vim.cmd('highlight @markup.strong guifg=#cdd6f4')
-- vim.cmd('highlight @markup.italic guifg=#cdd6f4')

vim.api.nvim_set_hl(0, '@neorg.anchors.declaration.norg', { fg='#94e2d5' })
vim.api.nvim_set_hl(0, '@neorg.headings.1.title.norg', { fg = '#f38ba8' })
vim.api.nvim_set_hl(0, '@neorg.links.description.norg', { fg='#74c7ec' })
vim.api.nvim_set_hl(0, '@neorg.links.location.url.norg', { fg='#74c7ec' })
vim.api.nvim_set_hl(0, '@neorg.lists.unordered.prefix.norg', { fg='#b4befe' })
vim.api.nvim_set_hl(0, '@neorg.markup.spoiler', { fg='#6c7086', bg='none' })
vim.api.nvim_set_hl(0, '@neorg.todo_items.cancelled.norg', { fg='#585b70' })
vim.api.nvim_set_hl(0, '@neorg.todo_items.on_hold.norg', { fg='#74c7ec' })
vim.api.nvim_set_hl(0, '@neorg.todo_items.pending.norg', { fg='#f9e2af' })
vim.api.nvim_set_hl(0, '@neorg.todo_items.urgent.norg', { fg='#f38ba8' })

vim.api.nvim_set_hl(0, '@markup.strong', { fg='#cdd6f4' })
vim.api.nvim_set_hl(0, '@markup.italic', { fg='#cdd6f4' })

-- vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
-- vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' })
-- vim.api.nvim_set_hl(0, "BorderBG", { fg = "#9399b2" })
-- vim.api.nvim_set_hl(0, 'Pmenu', { fg = '#cdd6f4' })
-- vim.api.nvim_set_hl(0, 'PmenuSel', { fg = '#f38ba8' })

vim.api.nvim_set_hl(0, 'CmpItemKindSupermaven', { fg = '#61afef' })
