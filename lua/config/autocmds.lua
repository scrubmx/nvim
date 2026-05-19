-----------------------------------------------------------
-- Auto Commands
-----------------------------------------------------------

-- Show cursor line only in active window
local cursor_group = vim.api.nvim_create_augroup('CursorGroup', { clear = true })

vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  desc = 'Enable `cursorline` when window gains focus',
  pattern = '*',
  group = cursor_group,
  -- command = 'set cursorline',
  callback = function()
    -- vim.opt_local.cursorline = true
    vim.wo.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  desc = 'Disable `cursorline` when window loses focus',
  pattern = '*',
  group = cursor_group,
  -- command = 'setlocal nocursorline',
  callback = function()
    -- vim.opt_local.cursorline = false
    vim.wo.cursorline = false
  end,
})

-- Neovim deprecated the 'paste' option in 0.9
-- Paste handling is automatic in the TUI and GUI now.
-- That makes this autocmd obsolete.
--
-- Turn off paste mode when leaving insert mode
-- vim.api.nvim_create_autocmd('InsertLeave', {
--   desc = 'Turn off paste mode when leaving insert mode',
--   pattern = '*',
--   group = vim.api.nvim_create_augroup('PasteGroup', { clear = true }),
--   -- command = 'set nopaste',
--   callback = function()
--     vim.opt.paste = false
--   end,
-- })

-- Highlight when yanking text
-- Try it with `yap` in normal mode
-- See `:help vim.highlight.on_yank()`
local textyank_group = vim.api.nvim_create_augroup('TextYankGroup', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = textyank_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Theme Colors:
-- https://catppuccin.com/palette#flavor-mocha
local highlights = require('config.highlights')
local highlight_group = vim.api.nvim_create_augroup('UserHighlights', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'Reapply custom highlight overrides after colorscheme changes',
  group = highlight_group,
  callback = highlights.apply,
})

highlights.apply()

-- DEPRECATED RePLACED by ftplugin/norg.lua
-- Set conceallevel to conceal links and other stuff in norg files
-- See `:help conceallevel`
--
--  0  Text is shown normally
--  1  Text is replaced with one character (fallbacks to `listchars`)
--  2  Text is hidden unless it has a custom replacement (see `:syn-cchar`)
--  3  Text is completely hidden
-- vim.cmd("autocmd BufNewFile,BufRead *.norg setlocal conceallevel=3")
-- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
--   desc = 'Set `conceallevel` for norg files (3 – Concealed text is completely hidden)',
--   pattern = '*.norg',
--   group = vim.api.nvim_create_augroup('ConcealLevelGroup', { clear = true }),
--   -- command = 'setlocal conceallevel=3',
--   callback = function()
--     vim.opt_local.conceallevel = 3
--   end,
-- })

-- Set the filetypes for specific file extensions
-- vim.cmd("autocmd BufNewFile,BufRead *.blade.php setlocal filetype=blade")
-- vim.cmd("autocmd BufNewFile,BufRead *.zsh-theme setlocal filetype=zsh")
-- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
--   desc = 'Set the filetypes for specific file extensions',
--   pattern = '*.zsh-theme',
--   group = vim.api.nvim_create_augroup('FileTypeGroup', { clear = true }),
--   -- command = 'setlocal filetype=zsh',
--   callback = function()
--     vim.opt_local.filetype = 'zsh'
--   end,
-- })

-- REPLACED by ftplugin/php.lua and ftplugin/blade.lua
-- Set indentation width for specific filetypes
-- vim.cmd("autocmd FileType php setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab")
-- vim.cmd("autocmd FileType blade setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab")
-- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
--   desc = 'Set indentation width to 4 for specific filetypes',
--   pattern = '*.php',
--   group = vim.api.nvim_create_augroup('BufferGroup', { clear = true }),
--   callback = function()
--     -- vim.opt_local.shiftwidth = 4
--     -- vim.opt_local.softtabstop = 4
--     -- vim.opt_local.tabstop = 4
--     vim.opt_local.shiftwidth = 2
--     vim.opt_local.softtabstop = 2
--     vim.opt_local.tabstop = 2
--   end,
-- })

-- REPLACED by ftplugin/php.lua and ftplugin/blade.lua
-- For FileType, the pattern should be the filetype name, e.g. php, not *.php.
-- local indentation_group = vim.api.nvim_create_augroup('IndentationFileTypeGroup', { clear = true })
--
-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   desc = 'Set indentation width for PHP files',
--   pattern = 'php',
--   group = indentation_group,
--   callback = function()
--     vim.opt_local.shiftwidth = 2
--     vim.opt_local.softtabstop = 2
--     vim.opt_local.tabstop = 2
--     vim.opt_local.expandtab = true
--   end,
-- })

-- DEPRECATED Replaced by ftplugin/norg.lua, ftplugin/markdown, and ftplugin/gitcommit.lua
-- Enable spell check for certain filetypes
-- https://github.com/adalessa/nvim/blob/9f7ef8669223eb7cdaf3f580dc8b6a7926807231/lua/config/autocmds.lua#L27C1-L33C3
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'gitcommit', 'markdown', 'norg' },
--   group = vim.api.nvim_create_augroup('SpellGroup', { clear = true }),
--   callback = function()
--     -- vim.opt_local.wrap = true
--     vim.opt_local.spell = true
--   end,
-- })

-- Those are old Vim-era termcap tweaks.
-- Neovim explicitly documents that it does not use special t_XX options or termcap-style terminal capability config.
-- So these lines are legacy cargo-cult in Neovim and should go.
-- Undercurl (Let's try it out for a few days)
-- vim.cmd([[let &t_Cs = "\e[4:3m]"]])
-- vim.cmd([[let &t_Ce = "\e[4:0m]"]])
