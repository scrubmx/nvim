-- Smart, seamless, directional navigation and resizing splits
-- https://github.com/mrjones2014/smart-splits.nvim
return {
  'mrjones2014/smart-splits.nvim',
  keys = {
    { 'r<Left>',  function() require('smart-splits').resize_left() end,  desc = 'Split resize left' },
    { 'r<Down>',  function() require('smart-splits').resize_down() end,  desc = 'Split resize down' },
    { 'r<Up>',    function() require('smart-splits').resize_up() end,    desc = 'Split resize up' },
    { 'r<Right>', function() require('smart-splits').resize_right() end, desc = 'Split resize right' },
    { 'rh',       function() require('smart-splits').resize_left() end,  desc = 'Split resize left' },
    { 'rj',       function() require('smart-splits').resize_down() end,  desc = 'Split resize down' },
    { 'rk',       function() require('smart-splits').resize_up() end,    desc = 'Split resize down' },
    { 'rl',       function() require('smart-splits').resize_right() end, desc = 'Split resize right' },
  },
  opts = {
    -- Ignored buffer types (only while resizing)
    ignored_buftypes = {
      'nofile',
      'quickfix',
      'prompt',
    },
    -- the default number of lines/columns to resize by at a time
    default_amount = 2,
  },
}
