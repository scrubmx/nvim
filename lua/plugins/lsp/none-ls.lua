-- https://github.com/nvimtools/none-ls.nvim
-- https://github.com/nvimtools/none-ls.nvim#setup
-- https://github.com/nvimtools/none-ls-extras.nvim
return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      -- Built-in Sources
      -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
      -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
      sources = {
        -- Code Actions
        -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
        null_ls.builtins.code_actions.refactoring,

        -- Completion
        -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#completion
        -- null_ls.builtins.completion.spell,
        -- null_ls.builtins.completion.proselint,
        -- null_ls.builtins.completion.nvim_snippets,

        -- Diagnostics
        -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#diagnostics
        -- null_ls.builtins.diagnostics.write_good,
        -- null_ls.builtins.diagnostics.codespell,
        -- null_ls.builtins.diagnostics.credo,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.dotenv_linter.with({
          args = { '--plain', 'check', '$FILENAME' },
        }),

        -- Formatting
        -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#formatting
        -- null_ls.builtins.formatting.markdownlint,
        -- null_ls.builtins.formatting.phpcsfixer,
        -- null_ls.builtins.formatting.pint,
        null_ls.builtins.formatting.mix,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.nginx_beautifier,

        -- Hover
        -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#hover
        -- null_ls.builtins.hover.dictionary,
        -- null_ls.builtins.hover.printenv,

        -- Extras
        -- https://github.com/nvimtools/none-ls-extras.nvim/tree/main/lua/none-ls
        -- require('none-ls.code_actions.eslint'),
      },
    })

    -- https://github.com/nvimtools/none-ls.nvim#i-am-seeing-a-formatting-timeout-error-message
    -- vim.lsp.buf.format({ timeout_ms = 2000 })
  end,
}
