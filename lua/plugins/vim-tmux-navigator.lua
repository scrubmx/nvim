-- Seamless navigation between tmux panes and vim splits
-- https://github.com/christoomey/vim-tmux-navigator
return {
  'christoomey/vim-tmux-navigator',
  lazy = true,
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  keys = {
    { '<C-h>',  '<Cmd>TmuxNavigateLeft<CR>' },
    { '<C-j>',  '<Cmd>TmuxNavigateDown<CR>' },
    { '<C-k>',  '<Cmd>TmuxNavigateUp<CR>' },
    { '<C-l>',  '<Cmd>TmuxNavigateRight<CR>' },
    { '<C-\\>', '<Cmd>TmuxNavigatePrevious<CR>' },
  },
}
