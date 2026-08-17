--- https://github.com/detachhead/basedpyright
---
--- Basedpyright is a fork of [pyright](https://github.com/microsoft/pyright)
--- with various type checking improvements, pylance features and more.
---
--- Installation is handled by Mason.
---
--- See [documentation](https://docs.basedpyright.com)
--- See [configuration](https://docs.basedpyright.com/latest/installation/ides/#neovim)
---
---@type vim.lsp.Config
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
}
