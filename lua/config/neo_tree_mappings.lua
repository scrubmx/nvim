-- Resolve source-local mappings without opening a tree or registering extra keys.
return function()
  local config = require('neo-tree').ensure_config()
  local normalize = require('neo-tree.setup.mapping-helper').normalize_mappings
  -- Read a fresh copy: setup may have merged user mappings into the defaults module.
  local defaults = dofile(vim.api.nvim_get_runtime_file('lua/neo-tree/defaults.lua', false)[1])
  local rows = {}
  local function command(value)
    return type(value) == 'table' and value[1] or value
  end
  local function add(scope, mappings, baseline, mode, commands)
    for lhs, mapping in pairs(normalize(mappings or {})) do
      local action = command(mapping)
      if type(lhs) == 'string' and action and action ~= 'none' and action ~= 'noop' then
        local title = type(action) == 'string' and action:gsub('_', ' '):gsub('^%l', string.upper) or 'Custom action'
        local description = type(mapping) == 'table' and mapping.desc or nil
        description = '[' .. scope .. '] ' .. (description or title)
        local original = command((baseline or {})[lhs])
        if original ~= action then
          description = description
            .. ' [default action: '
            .. (type(original) == 'string' and original or 'unassigned')
            .. ']'
        end
        rows[#rows + 1] = { lhs = lhs, mode = mode, desc = title, description = description, scope = scope }
        if commands and type(action) == 'string' and commands[action .. '_visual'] then
          rows[#rows + 1] = { lhs = lhs, mode = 'x', desc = title, description = description, scope = scope }
        end
      end
    end
  end
  for _, source in ipairs(config.sources) do
    local current = config[source]
    local baseline = vim.tbl_extend(
      'force',
      normalize(defaults.window.mappings),
      normalize((defaults[source] or {}).window and defaults[source].window.mappings or {})
    )
    add(source, current.window.mappings, baseline, 'n', current.commands)
  end
  -- Simple fuzzy mappings use Insert mode; numbered tables can override other modes.
  add(
    'filesystem popup',
    config.filesystem.window.fuzzy_finder_mappings,
    normalize(defaults.filesystem.window.fuzzy_finder_mappings),
    'i'
  )
  for _, modes in ipairs(config.filesystem.window.fuzzy_finder_mappings) do
    for mode, mappings in pairs(modes) do
      local baseline = {}
      for _, default_modes in ipairs(defaults.filesystem.window.fuzzy_finder_mappings) do
        baseline = vim.tbl_extend('force', baseline, normalize(default_modes[mode] or {}))
      end
      add('filesystem popup', mappings, baseline, mode)
    end
  end
  return rows
end
