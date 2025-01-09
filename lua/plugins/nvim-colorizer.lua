-- A high-performance color highlighter for Neovim
-- https://github.com/NvChad/nvim-colorizer.lua
-- https://github.com/catgoose/nvim-colorizer.lua#customization
return {
  'NvChad/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    filetypes = {
      '*',
      css = { css = true },
    },
    -- All the sub-options of filetypes apply to buftypes
    buftypes = {
      '*',
      '!prompt', -- Exclude prompt buftypes from highlight
      '!popup',  -- Exclude popup buftypes from highlight
    },
    user_default_options = {
      names = false, -- Name codes like 'Blue' or 'blue'
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      RRGGBBAA = false, -- #RRGGBBAA hex codes
      AARRGGBB = false, -- 0xAARRGGBB hex codes
      rgb_fn = false, -- CSS rgb() and rgba() functions
      hsl_fn = false, -- CSS hsl() and hsla() functions
      css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      mode = 'virtualtext', -- Display mode, options: 'background', 'foreground', 'virtualtext'
      tailwind = false, -- Tailwind colors, options: boolean, 'normal', 'lsp', 'both'. (true is same as normal)
      sass = {
        enable = false, -- Enable sass colors
        parsers = { 'css' }, -- Parsers can contain values used in |user_default_options|
      },
      virtualtext = '■', -- Virtualtext character to use
      virtualtext_inline = true, -- Display virtualtext inline with color
      virtualtext_mode = 'foreground', -- Virtualtext highlight mode, options: 'background' and 'foreground'
      user_commands = true, -- Enable all or some usercommads, options: boolean or list of usercommands to enable
    },
  },
}
