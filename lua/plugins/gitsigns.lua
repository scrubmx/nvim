-- Git integration for buffers
-- https://github.com/lewis6991/gitsigns.nvim
-- https://github.com/lewis6991/gitsigns.nvim#installation--usage
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      untracked = { text = "▎" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false,   -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',   -- 'eol' | 'overlay' | 'right_align'
    },
    current_line_blame_formatter = '<author>, <author_time:%R>',
    update_debounce = 100,
    max_file_length = 40000,
    preview_config = {
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
  }
}
