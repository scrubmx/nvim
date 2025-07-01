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

    harpoon:setup({
      global_settings = {
        save_on_toggle = true, -- Save marks when toggling the menu
        save_on_change = true, -- Save marks when changing buffers
      },
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4, -- Set menu width to current window width minus padding
      },
    })

    -- https://github.com/ThePrimeagen/harpoon/tree/harpoon2?tab=readme-ov-file#basic-setup
    vim.keymap.set('n', '¡a', function() harpoon:list():add() end, { desc = 'Harpoon: Add' })
    vim.keymap.set('n', '¡o', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon Open' })

    -- Switch to any mark without bringing up the menu
    vim.keymap.set('n', '¡1', function() harpoon:list():select(1) end, { desc = 'Harpoon toggle 1' })
    vim.keymap.set('n', '¡2', function() harpoon:list():select(2) end, { desc = 'Harpoon toggle 2' })
    vim.keymap.set('n', '¡3', function() harpoon:list():select(3) end, { desc = 'Harpoon toggle 3' })
    vim.keymap.set('n', '¡4', function() harpoon:list():select(4) end, { desc = 'Harpoon toggle 4' })
    vim.keymap.set('n', '¡5', function() harpoon:list():select(5) end, { desc = 'Harpoon toggle 5' })
    vim.keymap.set('n', '¡6', function() harpoon:list():select(6) end, { desc = 'Harpoon toggle 6' })
    vim.keymap.set('n', '¡7', function() harpoon:list():select(7) end, { desc = 'Harpoon toggle 7' })
    vim.keymap.set('n', '¡8', function() harpoon:list():select(8) end, { desc = 'Harpoon toggle 8' })
    vim.keymap.set('n', '¡9', function() harpoon:list():select(9) end, { desc = 'Harpoon toggle 9' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '¡n', function() harpoon:list():next() end, { desc = 'Harpoon next' })
    vim.keymap.set('n', '¡p', function() harpoon:list():prev() end, { desc = 'Harpoon previous' })
  end,
}
