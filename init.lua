-----------------------------------------------------------
-- Initialization file for Neovim
-----------------------------------------------------------

--[[

  This file is where you can set up your Neovim configuration
  it is loaded before any other Lua files in your config directory,
  written in Lua instead of the classic Vimscript. Its purpose is to:

    1. Configure Neovim settings – Set options (vim.o, vim.opt), keymaps, and commands.
    2. Load plugins – Using plugin managers like lazy.nvim, packer.nvim, etc.
    3. Structure your config – Organize your setup modularly with Lua files (e.g., require("plugins"), require("keymaps")).
    4. Improve performance – Lua is faster than Vimscript, making config loading and plugin execution quicker.
    5. Enable modern Neovim features – Many newer features and plugin ecosystems (e.g., LSP, Treesitter) are Lua-first or Lua-only.

  For more information on how to use this file, see the Neovim docs:
  @see `:help lua-guide`

  A guide to using Lua in Neovim
  @link https://github.com/nanotee/nvim-lua-guide

  Example of a basic init.lua file:
  @link https://github.com/mjlbach/starter.nvim/blob/master/init.lua

  Slim Neovim config for 0.11+ with minimal plugins:
  @link https://www.youtube.com/watch?v=-N9QTQzEt0w
  @link https://github.com/jellydn/tiny-nvim

]]

vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.loader.enable()

-- EditorConfig is built in and enabled by default in Neovim
-- vim.g.editorconfig = true

vim.opt.title = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.clipboard:append('unnamedplus')
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
-- vim.opt.backspace = { 'start', 'eol', 'indent' }

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- vim.opt.colorcolumn = '120'
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.wrap = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.sidescroll = 5
vim.opt.mousescroll = 'ver:3,hor:0'

vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Configuration for nvim-ufo
vim.opt.foldcolumn = '0' -- Using ufo provider this prevents showing weird characters on the left
vim.opt.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt.foldlevel = 10

-- vim.opt.autowrite = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.opt.wildignore = { '*/cache/*', '*/tmp/*' }

vim.opt.list = true
vim.opt.listchars = { trail = '·', tab = '➞ ', extends = '◣', precedes = '◢', nbsp = '○' } -- space = '·', eol = '󰘌'
vim.opt.laststatus = 3
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.signcolumn = 'yes'    -- 'auto:4'
vim.opt.isfname:append('@-@') -- Allow '-' in file names
-- vim.opt.lazyredraw = true -- This doesn't work with noice plugin
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.updatetime = 4000 -- If nothing is typed the swap file will be written to disk (milliseconds)

vim.opt.spelllang = { 'en_us', 'es' }
vim.opt.spell = true

-- filetypes
vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'blade',
    ['.*%.zsh%-theme'] = 'zsh',
  },
})

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- To use fzf in Neovim, add the following line to your init.lua
vim.opt.rtp:append('/opt/homebrew/opt/fzf')

require('config.lazy')
require('config.autocmds')
require('config.keymaps')
