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
-- NVIM CMP
-------------------------------------------------

-- <Ctrl-y>: Confirms selection
-- <Ctrl-e>: Toggles the completion (Okay, in Vim the default just cancels the completion. I set it to toggle)
-- <Up>: Navigate to the previous item on the list
-- <Down>: Navigate to the next item on the list
-- <Ctrl-p>: Navigate to the previous item on the list
-- <Ctrl-n>: Navigate to the next item on the list
--
-- <Enter>: Confirms selection
-- <Ctrl-d>: Go to the next placeholder in the snippets
-- <Ctrl-b>: Go to the previous placeholder in the snippets
-- <Tab>: Complete when the cursor is inside a word (When the menu is visible it'll navigate to the next item in the list)
-- <S-Tab>: When the completion menu is visible navigate to the previous item in the list

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
