-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2
-- https://github.com/ThePrimeagen/harpoon
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon = require('harpoon')

    harpoon:setup()

    -- https://github.com/ThePrimeagen/harpoon/tree/harpoon2?tab=readme-ov-file#basic-setup
    vim.keymap.set('n', '¡a', function() harpoon:list():add() end)
    vim.keymap.set('n', '¡o', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    -- Switch to any mark without bringing up the menu
    vim.keymap.set('n', '¡1', function() harpoon:list():select(1) end)
    vim.keymap.set('n', '¡2', function() harpoon:list():select(2) end)
    vim.keymap.set('n', '¡3', function() harpoon:list():select(3) end)
    vim.keymap.set('n', '¡4', function() harpoon:list():select(4) end)
    vim.keymap.set('n', '¡5', function() harpoon:list():select(5) end)
    vim.keymap.set('n', '¡6', function() harpoon:list():select(6) end)
    vim.keymap.set('n', '¡7', function() harpoon:list():select(7) end)
    vim.keymap.set('n', '¡8', function() harpoon:list():select(8) end)
    vim.keymap.set('n', '¡9', function() harpoon:list():select(9) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '¡p', function() harpoon:list():prev() end)
    vim.keymap.set('n', '¡n', function() harpoon:list():next() end)
  end,
}
