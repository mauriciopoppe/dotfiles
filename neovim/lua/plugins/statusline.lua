local Utils = require("my.utils")

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local custom = require("lualine.themes.material")
      local icons = Utils.icons
      local themes = Utils.themes
      local colors = {}

      function _G.lualine_refresh_theme(theme)
        colors = themes[theme]

        -- Change the background of lualine_c section for normal mode
        custom.normal.a.bg = colors.dark
        custom.normal.a.fg = colors.light
        custom.normal.b.bg = colors.medium
        custom.normal.b.fg = colors.dark
        custom.normal.c.bg = colors.light
        custom.normal.c.fg = colors.dark

        custom.insert.b.bg = colors.medium
        custom.insert.b.fg = colors.dark

        custom.visual.b.bg = colors.medium
        custom.visual.b.fg = colors.dark

        custom.inactive.c.bg = colors.light
        custom.inactive.c.fg = colors.dark

        local function fg(name)
          return function()
            ---@type {foreground?:number}?
            local hl = vim.api.nvim_get_hl_by_name(name, true)
            return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
          end
        end

        require("lualine").setup({
          options = {
            icons_enabled = true,
            theme = custom,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
            always_divide_middle = true,
          },
          sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch" },
            lualine_c = {
              {
                "diagnostics",
                symbols = {
                  error = icons.diagnostics.Error,
                  warn = icons.diagnostics.Warn,
                  info = icons.diagnostics.Info,
                  hint = icons.diagnostics.Hint,
                },
              },
              { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
              { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            },
            lualine_x = {
              -- stylua: ignore
              {
                function() return require("noice").api.status.command.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                color = fg("Statement")
              },
              -- stylua: ignore
              {
                function() return require("noice").api.status.mode.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                color = fg("Constant") ,
              },
              { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
              {
                "diff",
                symbols = {
                  added = icons.git.added,
                  modified = icons.git.modified,
                  removed = icons.git.removed,
                },
              },
            },
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
              { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
          },
          tabline = {},
          extensions = { "neo-tree" },
        })
      end

      -- Set the dark theme by default.
      lualine_refresh_theme("dark")
    end,
  },
}
