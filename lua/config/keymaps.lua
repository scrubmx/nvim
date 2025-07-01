-------------------------------------------------
-- Conflicts
-------------------------------------------------

--[[
- WARNING In mode `n`, <gc> overlaps with <gcc>:
  - <gc>: Toggle comment
  - <gcc>: Toggle comment line
- WARNING In mode `n`, <gr> overlaps with <gri>, <grr>, <gra>, <grn>:
  - <gr>: LSP Rename all symbol references
  - <gri>: vim.lsp.buf.implementation()
  - <grr>: vim.lsp.buf.references()
  - <gra>: vim.lsp.buf.code_action()
  - <grn>: vim.lsp.buf.rename()
- WARNING In mode `n`, <sF> overlaps with <sFn>, <sFl>:
  - <sF>: Find left surrounding
  - <sFn>: Find next left surrounding
  - <sFl>: Find previous left surrounding
- WARNING In mode `n`, <sf> overlaps with <sfn>, <sfl>:
  - <sf>: Find right surrounding
  - <sfn>: Find next right surrounding
  - <sfl>: Find previous right surrounding
- WARNING In mode `n`, <sh> overlaps with <shn>, <shl>:
  - <sh>: Highlight surrounding
  - <shn>: Highlight next surrounding
  - <shl>: Highlight previous surrounding
- WARNING In mode `n`, <sd> overlaps with <sdn>, <sdl>:
  - <sd>: Delete surrounding
  - <sdn>: Delete next surrounding
  - <sdl>: Delete previous surrounding
- WARNING In mode `n`, <sr> overlaps with <srn>, <srl>:
  - <sr>: Replace surrounding
  - <srn>: Replace next surrounding
  - <srl>: Replace previous surrounding
]]

-------------------------------------------------
-- General
-------------------------------------------------

-- Increment/Decrement
vim.keymap.set('n', '+', '<C-a>', { noremap = true, silent = true })
vim.keymap.set('n', '-', '<C-x>', { noremap = true, silent = true })

-- Clear search highlight
vim.keymap.set('n', '<Leader><Space>', '<Cmd>nohlsearch<Enter>', { noremap = true, silent = true })

-- Reselect last visual selection after indent/outdent
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- Jump half page up/down and center cursor on screen
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

-- Prevent 'change' commands from yanking text
-- https://stackoverflow.com/questions/62675763/how-can-i-stop-a-change-from-copying-to-my-paste-buffer#answer-62676339
vim.keymap.set('n', 'c', '"_c', { noremap = true, silent = true })

-- Join lines and keep in the same place the cursor
-- https://github.com/adalessa/nvim/blob/9f7ef8669223eb7cdaf3f580dc8b6a7926807231/lua/config/keymaps.lua#L50C1-L50C86
vim.keymap.set('n', 'J', 'mzJ`z', { noremap = true, silent = true })

-- Move lines up and down in visual mode
-- https://youtu.be/FGVY7gbaoQI?si=E2y5ZdrcOQ91BDWS&t=745
-- TODO: Figure out the mini.move plugin and use it instead
-- vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv'", { noremap = true, silent = true, nowait = true })
-- vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv'", { noremap = true, silent = true, nowait = true })

-- Move lines up and down in normal and visual mode
-- vim.keymap.set('n', '<C-J>', ':move .+1<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<C-K>', ':move .-2<CR>', { noremap = true, silent = true })
-- vim.keymap.set('v', '<C-J>', ':move \'>+1<CR>:normal gv<CR>', { noremap = true, silent = true })
-- vim.keymap.set('v', '<C-K>', ':move \'<-2<CR>:normal gv<CR>', { noremap = true, silent = true })

-- Search and replace the word under the cursor
-- TODO: Figure out how to make this work with having to press space after
vim.keymap.set('n', '<Leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { noremap = true, silent = true })

-------------------------------------------------
-- VIM hard mode (disable backspace and arrows)
-- https://www.mailslurp.com/blog/vim-hard-mode
-------------------------------------------------

local hardmode = true

if hardmode then
  -- Show an error message if a disabled key is pressed
  local msg = [[<Cmd>echohl Error | echo "KEY DISABLED" | echohl None<CR>]]

  -- Disable arrow keys in insert mode with a styled message
  vim.keymap.set('i', '<Up>', '<C-o>' .. msg, { noremap = true, silent = false })
  vim.keymap.set('i', '<Down>', '<C-o>' .. msg, { noremap = true, silent = false })
  vim.keymap.set('i', '<Left>', '<C-o>' .. msg, { noremap = true, silent = false })
  vim.keymap.set('i', '<Right>', '<C-o>' .. msg, { noremap = true, silent = false })
  -- vim.keymap.set('i', '<Del>', '<C-o>' .. msg, { noremap = true, silent = false })
  -- vim.keymap.set('i', '<BS>', '<C-o>' .. msg, { noremap = true, silent = false })

  -- Disable arrow keys in normal mode with a styled message
  vim.keymap.set('n', '<Up>', msg, { noremap = true, silent = false })
  vim.keymap.set('n', '<Down>', msg, { noremap = true, silent = false })
  vim.keymap.set('n', '<Left>', msg, { noremap = true, silent = false })
  vim.keymap.set('n', '<Right>', msg, { noremap = true, silent = false })
  -- vim.keymap.set('n', '<BS>', msg, { noremap = true, silent = false })
end

-------------------------------------------------
-- Splits/Tabs
-------------------------------------------------

-- Switch between tabs
-- 1gt, 2gt, 3gt, ...

-- Create a new tab
-- vim.keymap.set('n', 'te', '<Cmd>tabedit<Return>', { silent = true })

-- Split window and move focus to new splits
vim.keymap.set('n', 'ss', '<Cmd>split<Return><C-w>j', { silent = true })
vim.keymap.set('n', 'sv', '<Cmd>vsplit<Return><C-w>l', { silent = true })

-------------------------------------------------
-- NeoTree
-------------------------------------------------

-- Press <Leader>1 to reveal neo-tree
-- Press (a) to add a new file
-- Press (A) to add a new directory
-- Press (c) to copy a file
-- Press (C) to close tree node
-- Press (d) to delete a file
-- Press (m) to move a file
-- Press (q) to quit
-- Press (r) to rename a file
-- Press (R) to refresh
-- Press (s) to open file in v-split
-- Press (S) to open file in split
-- Press (t) to open file in a new tab

-------------------------------------------------
-- Code Folding
-------------------------------------------------

-- ,zf#j creates a fold from the cursor down # lines
-- ,zf/ string creates a fold from the cursor to string
-- ,zj moves the cursor to the next fold
-- ,zk moves the cursor to the previous fold
-- ,za toggle a fold at the cursor
-- ,zo opens a fold at the cursor
-- ,zO opens all folds at the cursor
-- ,zc closes a fold under cursor
-- ,zm increases the foldlevel by one
-- ,zM closes all open folds
-- ,zr decreases the foldlevel by one
-- ,zR decreases the foldlevel to zero -- all folds will be open
-- ,zd deletes the fold at the cursor
-- ,zE deletes all folds
-- ,[z move to start of open fold
-- ,]z move to end of open fold

-------------------------------------------------
-- Delete Commands
-------------------------------------------------

-- x            Delete the current character
-- 10x          Delete ten characters
-- dw           Delete the current word
-- 4dw          Delete the next four words
-- dd           Delete the current line
-- 5dd          Delete five lines
-- d$           Delete to the end of the line
-- d0           Delete to the beginning of line
-- <Cmd>1,.d    Delete to beginning of file
-- <Cmd>.,$d    Delete to end of file

-------------------------------------------------
-- Quickfix Commands
-------------------------------------------------

-- Tutorial                      https://www.youtube.com/watch?v=wOdL2T4hANk
-- <Cmd>copen                    Open the quickfix list
-- <Cmd>cclose                   Close the quickfix list
-- <Cmd>cnext                    Go to the next quickfix entry
-- <Cmd>cprev                    Go to the previous quickfix entry
-- <Cmd>cdo                      Run a commands on quickfix entries
-- <Cmd>cdo s/term/replace/gc    Replace term on each of the quickfix entries
