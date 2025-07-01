-- Plugin to manage the file system and other tree like structures
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim#minimal-quickstart
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = 'Neotree',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- Not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    -- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  keys = {
    { '<Leader>1', '<Cmd>Neotree toggle reveal=true<CR>' },
  },
  init = function()
    vim.g.neo_tree_theme = 'catppuccin-mocha'
    vim.g.neo_tree_remove_legacy_commands = true
  end,
  config = function()
    -- https://github.com/nvim-neo-tree/neo-tree.nvim#quickstart
    require('neo-tree').setup({
      close_if_last_window = true,
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = false,
      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 0,
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
          with_expanders = false,
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = '',
          default = '',
          highlight = 'NeoTreeFileIcon',
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
        },
        git_status = {
          symbols = {
            -- Change type
            added = '', -- or '✚', '' but this is redundant info if you use git_status_colors on the name
            modified = '', -- or '', '' but this is redundant info if you use git_status_colors on the name
            deleted = '✖', -- or '', this can only be used in the git_status source
            renamed = '', -- or '➜','', this can only be used in the git_status source
            -- Status type
            untracked = '', -- or ''
            ignored = '', -- or ''
            unstaged = '', -- or '󰅘', '', but this is redundant info if you use git_status_colors on the name
            staged = '', -- or ''
            conflict = '',
          },
        },
      },
      window = {
        position = 'left',
        width = 40,
        mappings = {
          ['<2-LeftMouse>'] = 'open',
          ['<CR>'] = 'open',
          ['o'] = 'open',
          ['S'] = 'open_split',
          ['s'] = 'open_vsplit',
          ['T'] = 'open_tabnew',
          ['C'] = 'close_node',
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
          ['H'] = 'toggle_hidden',
          ['/'] = 'fuzzy_finder',
          ['f'] = 'filter_on_submit',
          ['<C-x>'] = 'clear_filter',
          ['A'] = 'add_directory',
          ['a'] = 'add',
          ['d'] = 'delete',
          ['R'] = 'refresh',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['P'] = { 'toggle_preview', config = { use_float = true } },
          ['c'] = 'copy',
          ['m'] = 'move',
          ['q'] = 'close_window',
          ['?'] = 'show_help',
        },
        fuzzy_finder_mappings = {
          ['<Down>'] = 'move_cursor_down',
          ['<C-n>'] = 'move_cursor_down',
          ['<Up>'] = 'move_cursor_up',
          ['<C-p>'] = 'move_cursor_up',
        },
      },
      nesting_rules = {},
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            '_build',
            'deps',
            'node_modules',
            'undodir',
            'vendor',
          },
          never_show = { -- Remains hidden even if visible is toggled to true, this overrides always_show
            '.DS_Store',
            '__pycache__',
            'thumbs.db',
          },
          always_show = { -- Remains visible even if other settings would normally hide it
            '.gitignored',
          },
          always_show_by_pattern = { -- Uses glob style patterns
            '.env*',
          },
        },
        follow_current_file = {
          enabled = false,                      -- This will find and focus the file in the active buffer every time
        },
        hijack_netrw_behavior = 'open_current', -- Netrw disabled, opening a directory opens neo-tree, options: 'open_current', 'open_default', 'disabled'
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ['<BS>'] = 'navigate_up',
            ['.'] = 'set_root',
            ['H'] = 'toggle_hidden',
            ['/'] = 'fuzzy_finder',
            ['D'] = 'fuzzy_finder_directory',
            ['#'] = 'fuzzy_sorter', -- Fuzzy sorting using the fzy algorithm
            ['f'] = 'filter_on_submit',
            ['<C-x>'] = 'clear_filter',
          },
          fuzzy_finder_mappings = {
            -- Define keymaps for filter popup window in fuzzy_finder_mode
            ['<Down>'] = 'move_cursor_down',
            ['<C-n>'] = 'move_cursor_down',
            ['<up>'] = 'move_cursor_up',
            ['<C-p>'] = 'move_cursor_up',
          },
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
        },
        show_unloaded = true,
        window = {
          mappings = {
            ['bd'] = 'buffer_delete',
            ['<BS>'] = 'navigate_up',
            ['.'] = 'set_root',
          },
        },
      },
      git_status = {
        window = {
          position = 'float',
          mappings = {
            ['A'] = 'git_add_all',
            ['ga'] = 'git_add_file',
            ['gc'] = 'git_commit',
            ['gg'] = 'git_commit_and_push',
            ['gp'] = 'git_push',
            ['gr'] = 'git_revert_file',
            ['gu'] = 'git_unstage_file',
            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
            ['oc'] = { 'order_by_created', nowait = false },
            ['od'] = { 'order_by_diagnostics', nowait = false },
            ['om'] = { 'order_by_modified', nowait = false },
            ['on'] = { 'order_by_name', nowait = false },
            ['os'] = { 'order_by_size', nowait = false },
            ['ot'] = { 'order_by_type', nowait = false },
          },
        },
      },
      event_handlers = {
        {
          event = 'vim_buffer_enter',
          handler = function(_)
            if vim.bo.filetype == 'neo-tree' then
              vim.wo.signcolumn = 'auto'
            end
          end,
        },
      },
    })
  end,
}
