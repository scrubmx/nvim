---@brief
--
-- https://github.com/expert-lsp/expert
--
-- Expert requires `neovim >= 0.9.0.`
--
-- `expert` can be installed by following the instructions [here](https://github.com/expert-lsp/expert/blob/main/pages/installation.md#neovim)
--
-- 1. Homebrew: `brew install expert`
-- 2. Mason: `:MasonInstall expert`
--
-- As of neovim `0.11.3`, you can use the built-in lsp config:
--
-- ```lua
-- vim.lsp.config('expert', {
--   cmd = { 'expert', '--stdio' },
--   root_markers = { 'mix.exs', '.git' },
--   filetypes = { 'elixir', 'eelixir', 'heex' },
-- })
--
-- vim.lsp.enable 'expert'
-- ```
--
-- If you are using ``im-lspconfig` this should be handled automatically.
--
---@type vim.lsp.Config
return {
  cmd = { 'expert', '--stdio' },
  filetypes = { 'elixir', 'eelixir', 'heex' },
  root_markers = { 'mix.exs', '.git' },
}
