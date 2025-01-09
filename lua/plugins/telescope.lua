-- Telescope is a highly extendable fuzzy finder and picker
-- https://github.com/nvim-telescope/telescope.nvim
--
-- Introduction:
-- https://www.youtube.com/watch?v=iqdCshrIKIg
--
-- Advanced Examples:
-- https://www.youtube.com/watch?v=xdXE1tOT-qg
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  cmd = 'Telescope',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' }, -- It sets vim.ui.select to telescope
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-file-browser.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  },
  keys = {
    -- Built-in functions
    -- https://github.com/nvim-telescope/telescope.nvim#pickers
    --
    -- Default Mappings
    -- https://github.com/nvim-telescope/telescope.nvim#default-mappings
    --
    -- TODO: Make sure ripgrep is being used for `live_grep`
    -- https://github.com/nvim-telescope/telescope.nvim/issues/2924#issuecomment-1950667113
    --
    -- TIP: `:Telescope builtin` to explore all available commands
    { '<Leader>ff', '<Cmd>Telescope find_files<CR>' },
    { '<Leader>fa', '<Cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>',                     desc = 'Telescope find_all' },
    { '<Leader>fb', '<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>' },
    { '<Leader>fi', '<Cmd>Telescope current_buffer_fuzzy_find<CR>' },
    { '<Leader>fw', '<Cmd>Telescope lsp_workspace_symbols<CR>' },
    { '<Leader>fy', '<Cmd>Telescope lsp_document_symbols<CR>' },
    { '<Leader>fd', function() require('telescope.builtin').diagnostics() end,                                  desc = 'Telescope diagnostics' },
    { '<Leader>fg', function() require('telescope.builtin').live_grep() end,                                    desc = 'Telescope live_grep' },
    { '<Leader>fh', function() require('telescope.builtin').help_tags() end,                                    desc = 'Telescope help_tags' },
    { '<Leader>fo', function() require('telescope.builtin').buffers() end,                                      desc = 'Telescope buffers' },
    { '<Leader>fr', function() require('telescope.builtin').oldfiles() end,                                     desc = 'Telescope oldfiles' },
    { '<Leader>fs', function() require('telescope.builtin').spell_suggest() end,                                desc = 'Telescope spell_suggest' },
    { '<Leader>fv', function() require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') }) end, desc = 'Telescope nvim_config_files' },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local themes = require('telescope.themes')
    local fb_actions = telescope.extensions.file_browser.actions

    -- TODO: Dont preview binaries
    -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#dont-preview-binaries
    telescope.setup({
      defaults = {
        theme = 'dropdown',
        prompt_prefix = ' ',
        selection_caret = ' ',
        path_display = { 'smart' },
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        -- file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        -- grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        -- qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        -- buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
        preview = { filesize_limit = 25 }, -- Megabytes
        layout_config = {
          horizontal = { prompt_position = 'top', preview_width = 0.54, results_width = 0.8 },
          vertical = { mirror = false },
          width = 0.88,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_ignore_patterns = {
          '.DS_Store',
          '.git',
          '.idea',
          '.next',
          '.vscode',
          'bootstrap',
          'node_modules',
          'public',
          'storage',
        },
        -- https://github.com/nvim-telescope/telescope-file-browser.nvim#mappings
        mappings = {
          i = {
            ['<C-c>'] = actions.close,
            ['<C-d>'] = actions.preview_scrolling_down,
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['<C-t>'] = actions.select_tab,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-v>'] = actions.select_vertical,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-h>'] = actions.which_key,
            ['<C-?>'] = actions.which_key,
            ['<Down>'] = actions.move_selection_next,
            ['<Up>'] = actions.move_selection_previous,
            ['<Enter>'] = actions.select_default,
            ['<PageDown>'] = actions.results_scrolling_down,
            ['<PageUp>'] = actions.results_scrolling_up,
            ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
            ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
          },
          n = {
            ['<C-d>'] = actions.preview_scrolling_down,
            ['<C-t>'] = actions.select_tab,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-v>'] = actions.select_vertical,
            ['<C-x>'] = actions.select_horizontal,
            ['<Down>'] = actions.move_selection_next,
            ['<Up>'] = actions.move_selection_previous,
            ['<Enter>'] = actions.select_default,
            ['<Esc>'] = actions.close,
            ['<PageDown>'] = actions.results_scrolling_down,
            ['<PageUp>'] = actions.results_scrolling_up,
            ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
            ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
            ['G'] = actions.move_to_bottom,
            ['gg'] = actions.move_to_top,
            ['j'] = actions.move_selection_next,
            ['k'] = actions.move_selection_previous,
            ['?'] = actions.which_key,
          },
        },
      },
      -- https://github.com/nvim-telescope/telescope.nvim#extensions
      extensions = {
        -- File Browser extension for telescope.nvim
        -- https://github.com/nvim-telescope/telescope-file-browser.nvim
        file_browser = {
          hidden = true,
          hijack_netrw = true,
          mappings = {
            i = {
              ['<C-a>'] = fb_actions.create,
              ['<C-c>'] = fb_actions.copy,
              ['<C-d>'] = fb_actions.remove,
              ['<C-m>'] = fb_actions.move,
              ['<C-o>'] = fb_actions.open,
              ['<C-r>'] = fb_actions.rename,
              ['<C-t>'] = fb_actions.change_cwd,
              ['<C-g>'] = fb_actions.goto_parent_dir,
              ['<C-w>'] = fb_actions.goto_cwd,
              ['<C-f>'] = fb_actions.toggle_browser,
              ['<C-h>'] = fb_actions.toggle_hidden,
              ['<C-s>'] = fb_actions.toggle_all,
            },
            n = {
              a = fb_actions.create,
              c = fb_actions.copy,
              d = fb_actions.remove,
              m = fb_actions.move,
              o = fb_actions.open,
              r = fb_actions.rename,
              t = fb_actions.change_cwd,
              g = fb_actions.goto_parent_dir,
              w = fb_actions.goto_cwd,
              f = fb_actions.toggle_browser,
              h = fb_actions.toggle_hidden,
              s = fb_actions.toggle_all,
            },
          },
        },

        -- FZF sorter for telescope written in c
        -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
        fzf = {
          case_mode = 'smart_case',
          fuzzy = true,
          override_file_sorter = true,
          override_generic_sorter = true,
        },

        -- It sets vim.ui.select to telescope
        -- https://github.com/nvim-telescope/telescope-ui-select.nvim
        ['ui-select'] = {
          themes.get_dropdown({
            layout_config = {
              prompt_position = 'top',
            }
          }),
        },
      },
      pickers = {
        buffers = {
          ignore_current_buffer = true,
          previewer = true,
          sort_lastused = true,
        },
      },
    })

    telescope.load_extension('file_browser')
    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
  end,
}
