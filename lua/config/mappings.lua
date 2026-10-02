local M = {}

local function belongs_to(map, plugin)
  if plugin.rhs and (map.rhs or ''):find(plugin.rhs, 1, true) then
    return true
  end
  if map.callback then
    return (debug.getinfo(map.callback, 'S').source or ''):find(plugin.source, 1, true) ~= nil
  end
  if map.sid <= 0 then
    return false
  end
  local script = vim.fn.getscriptinfo({ sid = map.sid })[1]
  return script ~= nil and script.name:find(plugin.source, 1, true) ~= nil
end

local function annotate(map, plugin)
  local action = map.desc or map.lhs
  local base, suffix = action, ''
  for word, key in pairs(plugin.suffixes or {}) do
    local stripped, count = action:gsub(' ' .. word .. ' ', ' ', 1)
    if count > 0 then
      base, suffix = stripped, key
    end
  end
  local info = (plugin.actions or {})[base] or {}
  local default = info.default and (info.default .. suffix)
  local description = map.description or info.description or map.desc or map.rhs or ''
  if suffix ~= '' then
    description = description .. ' (' .. (action:match('previous') and 'previous' or 'next') .. ')'
  end
  if default and default ~= map.lhs then
    description = description .. ' [default: ' .. default .. ']'
  end
  return { action, map.lhs .. (info.usage or ''), map.mode, description }
end

local function table_lines(rows)
  local widths = { 6, 11, 4, 11 }
  for _, row in ipairs(rows) do
    for i, cell in ipairs(row) do
      widths[i] = math.max(widths[i], vim.fn.strdisplaywidth(cell))
    end
  end
  local function format(row)
    local cells = {}
    for i, cell in ipairs(row) do
      cells[i] = cell .. string.rep(' ', widths[i] - vim.fn.strdisplaywidth(cell))
    end
    return table.concat(cells, ' | ')
  end
  local lines = { format({ 'Action', 'Key binding', 'Mode', 'Description' }) }
  local bars = {}
  for i, width in ipairs(widths) do
    bars[i] = string.rep('-', width)
  end
  lines[#lines + 1] = table.concat(bars, '-+-')
  for _, row in ipairs(rows) do
    lines[#lines + 1] = format(row)
  end
  return lines
end

local function show_reference(plugin, rows)
  local lines = { plugin.name .. ' — configured keymaps', '' }
  vim.list_extend(lines, table_lines(rows))
  lines[#lines + 1] = ''
  vim.list_extend(lines, plugin.notes or {})
  lines[#lines + 1] = ''
  lines[#lines + 1] = 'q: close   /: search   g?: plugin help   :Mappings: pick another plugin'
  vim.cmd('botright new')
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.wo.wrap = false
  vim.wo.spell = false
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.keymap.set('n', 'q', '<Cmd>close<CR>', { buffer = buf, nowait = true })
  if plugin.help then
    vim.keymap.set('n', 'g?', function()
      vim.cmd.help(plugin.help)
    end, { buffer = buf })
  end
end

function M.open(plugin)
  require('lazy').load({ plugins = { plugin.plugin, 'telescope.nvim' } })
  local rows = {}
  local actions = require('telescope.actions')
  local displayer = require('telescope.pickers.entry_display').create({
    separator = ' | ',
    items = {
      { width = math.min(32, math.floor(vim.o.columns * 0.25)) },
      { width = math.min(23, math.floor(vim.o.columns * 0.24)) },
      { width = 3 },
      { remaining = true },
    },
  })
  local opts = {
    prompt_title = plugin.name .. ' — configured mappings',
    results_title = 'Action | Key binding | Mode | Description (Enter: full reference)',
    modes = { 'n', 'x', 'o', 'i', 'c', 's', 't' },
    layout_strategy = 'horizontal',
    layout_config = { width = 0.98, height = 0.9, preview_cutoff = 0 },
    previewer = require('telescope.previewers').new_buffer_previewer({
      title = 'Notation / defaults',
      define_preview = function(self, entry)
        local lines = { table.concat(entry.row, ' | '), '' }
        vim.list_extend(lines, plugin.notes or {})
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
        vim.wo[self.state.winid].wrap = true
      end,
    }),
    -- Keep room for the table; <M-p> toggles the notes.
    preview = { hide_on_startup = true },
    filter = function(map)
      return belongs_to(map, plugin)
    end,
    entry_maker = function(map)
      local row = annotate(map, plugin)
      rows[#rows + 1] = row
      return {
        value = map,
        row = row,
        ordinal = table.concat(row, ' '),
        display = function()
          return displayer(row)
        end,
      }
    end,
    attach_mappings = function(prompt_bufnr, map)
      -- builtin.keymaps normally executes a mapping. This picker is reference-only.
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        table.sort(rows, function(a, b)
          return table.concat(a) < table.concat(b)
        end)
        show_reference(plugin, rows)
      end)
      map({ 'i', 'n' }, '<M-p>', require('telescope.actions.layout').toggle_preview)
      map({ 'i', 'n' }, '<C-b>', function()
        actions.close(prompt_bufnr)
        M.pick()
      end)
      return true
    end,
  }
  if plugin.keymaps then
    local maps = plugin.keymaps()
    for _, mode in ipairs(opts.modes) do
      for _, map in ipairs(vim.api.nvim_get_keymap(mode)) do
        if belongs_to(map, plugin) then
          map.scope = 'Global'
          maps[#maps + 1] = map
        end
      end
    end
    require('telescope.pickers')
      .new(opts, {
        finder = require('telescope.finders').new_table({ results = maps, entry_maker = opts.entry_maker }),
        sorter = require('telescope.config').values.generic_sorter(opts),
      })
      :find()
  else
    require('telescope.builtin').keymaps(opts)
  end
end

function M.pick()
  require('lazy').load({ plugins = { 'telescope.nvim' } })
  vim.ui.select(require('config.mapping_catalog'), {
    prompt = 'Plugin mappings',
    format_item = function(plugin)
      return plugin.name
    end,
  }, function(plugin)
    if plugin then
      M.open(plugin)
    end
  end)
end

return M
