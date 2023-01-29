return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
-- I took these colors by looking at the theme I applied to iTerm
local themes = {
  dark = {
    bg1 = '#2d3c46',
    fg1 = '#8abdb6',
    bg2 = '#424f58',
    fg2 = '#232c31',
  },
  light = {
    bg1 = '#eee8d5',
    fg1 = '#7eb3af',
    bg2 = '#fdf6e3',
    fg2 = '#657b83',
  },
}

local custom = require'lualine.themes.material'
local colors = {}

function _G.lualine_refresh_theme(theme)
  colors = themes[theme]

  -- Change the background of lualine_c section for normal mode
  custom.normal.a.bg = colors.fg1
  custom.normal.a.fg = colors.fg2
  custom.normal.b.bg = colors.bg2
  custom.normal.b.fg = colors.fg1
  -- custom.normal.b.fg = colors.fg1
  custom.normal.c.bg = colors.bg1
  custom.normal.c.fg = colors.fg1

  custom.inactive.c.fg = colors.fg1
  custom.inactive.c.bg = colors.bg1

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
end

-- Set the dark theme by default.
lualine_refresh_theme('dark')
    end
  }
}
