---@brief
---
--- https://intelephense.com/
---
--- `intelephense` can be installed via `npm`:
--- ```sh
--- npm install -g intelephense
--- ```
---
--- ```lua
--- -- See https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#initialisation-options
--- init_options = {
---   storagePath = …, -- Optional absolute path to storage dir. Defaults to os.tmpdir().
---   globalStoragePath = …, -- Optional absolute path to a global storage dir. Defaults to os.homedir().
---   licenceKey = …, -- Optional licence key or absolute path to a text file containing the licence key.
---   clearCache = …, -- Optional flag to clear server state. State can also be cleared by deleting {storagePath}/intelephense
--- }
--- -- See https://github.com/bmewburn/intelephense-docs
--- settings = {
---   intelephense = {
---     files = {
---       maxSize = 1000000;
---     };
---   };
--- }
--- ```
---
---@type vim.lsp.Config
return {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local cwd = assert(vim.uv.cwd())
    -- Intelephense is useful for standalone PHP files too. If no project
    -- marker exists, use the file's directory as its workspace root.
    local root = vim.fs.root(fname, { 'composer.json', '.git' }) or vim.fs.dirname(fname) or cwd

    on_dir(root)
  end,
  init_options = {
    licenceKey = '/Users/scrub/intelephense/licence.txt',
  },
  settings = {
    intelephense = {
      inlayHint = {
        returnTypes = true, -- Function return type hints
        parameterTypes = true, -- Anonymous function parameter type hints
        parameterNames = true, -- Call argument parameter name hints
      },
    },
  },
}
