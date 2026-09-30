-- Markdown Preview Plugin for Neovim
-- https://github.com/iamcco/markdown-preview.nvim
--
-- Installation & Usage:
-- https://github.com/iamcco/markdown-preview.nvim#installation--usage
return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  ft = { 'markdown' },
}
