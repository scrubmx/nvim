-- Run with the normal config: make test
local function check()
  local actions = require('telescope.actions')
  local state = require('telescope.actions.state')
  local function picker()
    local current
    assert(
      vim.wait(1500, function()
        current = state.get_current_picker(vim.api.nvim_get_current_buf())
        return current and current.manager and current.manager:num_results() > 0
      end, 20),
      'Picker did not populate'
    )
    return current
  end

  -- Exercise the real user command, Dressing/Telescope selection, and plugin loading.
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { 'Keep (this) text unchanged.' })
  vim.cmd.Mappings()
  local plugins = picker()
  assert(plugins.manager:num_results() == 3, 'Expected Mini.Surround, Telescope, and Neo-tree')
  actions.select_default(plugins.prompt_bufnr)
  local keys = picker()
  assert(keys.prompt_title:find(require('config.mapping_catalog')[1].name, 1, true))
  assert(keys.manager:num_results() == 29, 'Missing installed mappings/modes')
  local seen = {}
  for entry in keys.manager:iter() do
    seen[entry.value.mode .. ':' .. entry.value.lhs] = true
    assert(not entry.row[4]:find('[default:', 1, true), 'Unexpected default difference')
  end
  assert(seen['n:sdn'] and seen['x:sa'] and seen['o:sFl'])
  for _, lhs in ipairs({ 'sd', 'sr', 'sh', 'sf', 'sF' }) do
    for _, suffix in ipairs({ '', 'l', 'n' }) do
      assert(seen['n:' .. lhs .. suffix], 'Missing Normal mapping ' .. lhs .. suffix)
      if lhs == 'sf' or lhs == 'sF' then
        assert(seen['x:' .. lhs .. suffix] and seen['o:' .. lhs .. suffix], 'Missing motion mode')
      end
    end
  end
  assert(not seen['n:sn'], 'Obsolete setting must not appear as active')
  require('telescope.actions.layout').toggle_preview(keys.prompt_bufnr)
  assert(
    vim.wait(500, function()
      local preview = keys.previewer.state
      return preview
        and preview.bufnr
        and table.concat(vim.api.nvim_buf_get_lines(preview.bufnr, 0, -1, false), '\n'):find('Literal keys', 1, true)
    end, 20),
    'Notation preview did not render'
  )
  vim.wait(50, function()
    return false
  end) -- finish Telescope's scheduled layout update
  actions.select_default(keys.prompt_bufnr)
  local reference = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
  assert(vim.bo.buftype == 'nofile' and not vim.bo.modifiable)
  assert(reference:find('sa{motion}{out}', 1, true) and reference:find('Legacy setting', 1, true))
  assert(vim.fn.maparg('q', 'n', false, true).buffer == 1)
  vim.cmd.close()
  assert(vim.api.nvim_get_current_line() == 'Keep (this) text unchanged.', 'Reference executed a mapping')

  -- Read live remaps, retaining annotations and documenting the old default.
  local original = vim.fn.maparg('sa', 'n', false, true)
  vim.keymap.del('n', 'sa')
  vim.keymap.set('n', 'za', original.callback, { expr = true, desc = original.desc })
  vim.keymap.set('n', 'szz', function() end, { desc = 'Unrelated surrounding map' })
  require('config.mappings').open(require('config.mapping_catalog')[1])
  keys = picker()
  local remapped = false
  for entry in keys.manager:iter() do
    assert(entry.value.lhs ~= 'szz', 'Filter matched an unrelated mapping')
    assert(not (entry.value.mode == 'n' and entry.value.lhs == 'sa'))
    if entry.value.lhs == 'za' then
      remapped = entry.row[2] == 'za{motion}{out}' and entry.row[4]:find('[default: sa]', 1, true)
    end
  end
  assert(remapped, 'Live remap/default annotation missing')
  -- Exercise the actual back binding, then cancel the plugin picker.
  local back = vim.fn.maparg('<C-b>', 'i', false, true)
  back.callback()
  plugins = picker()
  assert(plugins.manager:num_results() == 3)
  actions.close(plugins.prompt_bufnr)

  -- Command and callback launchers must both appear in the Telescope catalog.
  require('config.mappings').open(require('config.mapping_catalog')[2])
  keys = picker()
  assert(keys.manager:num_results() == 14, 'Missing Telescope launcher bindings')
  local telescope_keys = {}
  for entry in keys.manager:iter() do
    telescope_keys[entry.value.lhs] = true
    assert(entry.value.mode == 'n' and entry.value.desc, 'Expected named Normal-mode launchers')
  end
  for _, suffix in ipairs({ 'ff', 'fa', 'fb', 'fi', 'fw', 'fy', 'fd', 'fg', 'fc', 'fh', 'fr', 'fs', 'fo', 'fv' }) do
    assert(telescope_keys[vim.g.mapleader .. suffix], 'Missing Telescope launcher ' .. suffix)
  end
  actions.select_default(keys.prompt_bufnr)
  reference = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
  assert(reference:find('Find all files', 1, true) and reference:find('FILE BROWSER', 1, true))
  vim.cmd.close()

  -- Source-local Neo-tree controls must be searchable even with no tree buffer open.
  assert(vim.bo.filetype ~= 'neo-tree')
  require('config.mappings').open(require('config.mapping_catalog')[3])
  keys = picker()
  assert(keys.manager:num_results() > 26, 'Neo-tree picker is missing tree-local mappings')
  local neo_rows = {}
  for entry in keys.manager:iter() do
    neo_rows[entry.value.scope .. ':' .. entry.value.lhs] = entry.row
  end
  assert(neo_rows['Global:' .. vim.g.mapleader .. '1'], 'Missing Neo-tree launcher')
  assert(neo_rows['filesystem:S'] and neo_rows['filesystem:s'], 'Missing configured split bindings')
  for _, lhs in ipairs({
    '<2-leftmouse>',
    '<cr>',
    'o',
    'S',
    's',
    'T',
    'C',
    '<bs>',
    '.',
    'H',
    '/',
    'f',
    '<c-x>',
    'A',
    'a',
    'd',
    'R',
    'r',
    'y',
    'x',
    'p',
    'P',
    'c',
    'm',
    'q',
    '?',
  }) do
    assert(neo_rows['filesystem:' .. lhs], 'Missing configured tree-local key: ' .. lhs)
  end
  assert(neo_rows['buffers:bd'] and neo_rows['git_status:ga'], 'Missing source-specific bindings')
  assert(
    neo_rows['filesystem:o'][1] == 'Open' and neo_rows['git_status:o'][1] == 'Show help',
    'Source overrides were lost'
  )
  assert(neo_rows['filesystem:<cr>'] and neo_rows['filesystem:<2-leftmouse>'], 'Missing configured open bindings')
  assert(neo_rows['filesystem popup:<c-n>'], 'Missing fuzzy-popup navigation')
  -- Changing source config must update the picker, rather than leaving a static sheet.
  local neo = require('neo-tree').ensure_config()
  local split = neo.filesystem.window.mappings.S
  neo.filesystem.window.mappings.S = 'none'
  neo.filesystem.window.mappings.Z = split
  actions.close(keys.prompt_bufnr)
  require('config.mappings').open(require('config.mapping_catalog')[3])
  keys = picker()
  local remapped_split = false
  for entry in keys.manager:iter() do
    assert(not (entry.value.scope == 'filesystem' and entry.value.lhs == 'S'), 'Disabled source mapping still visible')
    if entry.value.scope == 'filesystem' and entry.value.lhs == 'Z' then
      remapped_split = entry.row[1] == 'Open split' and entry.row[4]:find('default action:', 1, true)
    end
  end
  assert(remapped_split, 'Source remap not reflected in searchable rows')
  neo.filesystem.window.mappings.S = split
  neo.filesystem.window.mappings.Z = nil
  actions.select_default(keys.prompt_bufnr)
  reference = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
  for _, section in ipairs({ '[filesystem]', '[filesystem popup]', '[buffers]', '[git_status]' }) do
    assert(reference:find(section, 1, true), 'Missing Neo-tree source reference: ' .. section)
  end
  assert(reference:find('Show help', 1, true) and reference:find('default action:', 1, true))
  vim.cmd.close()

  -- Additional plugins need only catalog data; no picker or display changes.
  require('config.mappings').open({
    name = 'mini.bufremove',
    plugin = 'mini.bufremove',
    source = '/lua/plugins/mini.lua',
  })
  keys = picker()
  assert(keys.manager:num_results() == 2, 'Second-plugin catalog example failed')
  actions.select_default(keys.prompt_bufnr)
  reference = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
  assert(reference:find('Delete Buffer', 1, true))
  vim.cmd.close()
  print(
    'PASS: plugin picker, surround/Telescope mappings, searchable Neo-tree sources, source remaps/defaults, reference, filter, catalog extension'
  )
end

local ok, err = xpcall(check, debug.traceback)
if not ok then
  vim.api.nvim_err_writeln(err)
  vim.cmd('cquit 1')
end
vim.cmd('qa!')
