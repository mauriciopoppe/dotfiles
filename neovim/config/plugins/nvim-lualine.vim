lua << EOF

local colors = {
  bg1 = '#2d3c46',
  fg1 = '#8abdb6',
  bg2 = '#424f58',
  fg2 = '#232c31',
  bg3 = '#2d3c46',
  fg3 = '#425059',
}
local custom = require'lualine.themes.material'
-- Change the background of lualine_c section for normal mode
custom.normal.a.bg = colors.fg1
custom.normal.a.fg = colors.fg2
custom.normal.b.bg = colors.bg2
custom.normal.b.fg = colors.fg1
-- custom.normal.b.fg = colors.fg1
custom.normal.c.bg = colors.bg1
custom.normal.c.fg = colors.fg1

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = custom,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF
