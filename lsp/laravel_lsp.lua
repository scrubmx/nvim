--- https://github.com/laravel/lsp#neovim
--- Install with `composer global require laravel/lsp`.

---@type vim.lsp.Config
return {
  cmd = { vim.fn.expand('~/.composer/vendor/bin/laravel-lsp') },
  filetypes = { 'php', 'blade' },
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(vim.api.nvim_buf_get_name(bufnr), { 'artisan' })

    if root then
      on_dir(root)
    end
  end,
}
