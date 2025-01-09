-- https://github.com/nvimtools/none-ls.nvim
-- https://github.com/nvimtools/none-ls.nvim#setup
-- https://github.com/nvimtools/none-ls-extras.nvim
return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
        -- null_ls.builtins.completion.spell,
        -- null_ls.builtins.completion.proselint,
        -- null_ls.builtins.diagnostics.write_good,
        -- null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.formatting.mix,
        -- null_ls.builtins.diagnostics.credo,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,

        -- https://github.com/nvimtools/none-ls-extras.nvim/tree/main/lua/none-ls
        -- require('none-ls.code_actions.eslint'),
      },
    })

    -- https://github.com/nvimtools/none-ls.nvim#i-am-seeing-a-formatting-timeout-error-message
    -- vim.lsp.buf.format({ timeout_ms = 2000 })
  end
}
