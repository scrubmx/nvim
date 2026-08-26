---@brief
---
--- LSP wrapper for TypeScript extension of VSCode
---
--- https://github.com/yioneko/vtsls
---
--- Config: https://github.com/yioneko/nvim-vtsls#config
--- Snippets: https://github.com/yioneko/nvim-vtsls#other-useful-snippets
---
---@type vim.lsp.Config
return {
  cmd = { 'vtsls', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  on_attach = function(client)
    -- vtsls provides `source.*` code actions that apply to the whole file. These only appear in
    -- `vim.lsp.buf.code_action()` if specified in `context.only`.
    vim.api.nvim_buf_create_user_command(0, 'LspTypescriptSourceAction', function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, 'source.')
      end, client.server_capabilities.codeActionProvider.codeActionKinds)

      vim.lsp.buf.code_action({
        context = {
          only = source_actions,
          diagnostics = vim.diagnostic.get(0),
        },
      })
    end, {})
  end,
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = 'literals' }, -- Enable parameter names hints: 'literals' | 'all'
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
