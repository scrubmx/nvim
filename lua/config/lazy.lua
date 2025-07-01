-- 💤 A modern plugin manager for Neovim
-- https://github.com/folke/lazy.nvim
-- https://lazy.folke.io/spec#spec-loading

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Import your plugins
    { import = "plugins" },
    { import = "plugins.lsp" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- Colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin-mocha" } },
  -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
  ui = { border = "rounded" },
  -- Automatically check for plugin updates
  checker = { enabled = true },
  change_detection = { notify = false },
})
