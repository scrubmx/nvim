-- Set conceallevel to conceal links and other stuff in norg files
-- See `:help conceallevel`
--
--  0  Text is shown normally
--  1  Text is replaced with one character (fallbacks to `listchars`)
--  2  Text is hidden unless it has a custom replacement (see `:syn-cchar`)
--  3  Text is completely hidden
vim.opt_local.conceallevel = 3
vim.opt_local.spell = true
