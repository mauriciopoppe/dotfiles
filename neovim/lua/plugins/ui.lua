local Config = require("my.config")
local Utils = require("my.util")
local LazyVim = require("lazyvim.util")
local Snacks = require("snacks")

return {

  -- buffers tabline
  {
    "willothy/nvim-cokeline",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      vim.opt.termguicolors = true
      local colors = {}

      function _G.bufferline_refresh_theme(theme)
        colors = Config.themes[theme]
        local bufferline = require("cokeline")

        vim.api.nvim_set_hl(0, "TabLineFill", { bg = colors.transparent })

        bufferline.setup({
          default_hl = {
            fg = function(buffer)
              return buffer.is_focused and colors.dark or colors.medium
            end,
            bg = function(buffer)
              return buffer.is_focused and colors.transparent or colors.transparent
            end,
          },
          components = {
            {
              text = " ",
            },
            {
              text = function(buffer)
                return buffer.filename
              end,
              bold = function(buffer)
                return buffer.is_focused
              end,
            },
            {
              text = " 󰖭 ",
              on_click = function(_, _, _, _, buffer)
                buffer:delete()
              end,
            },
          },
        })
      end

      local theme_style = Utils.get_theme_style()
      bufferline_refresh_theme(theme_style)
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local custom = require("lualine.themes.material")
      local icons = Config.icons
      local colors = {}

      function _G.lualine_refresh_theme(theme)
        colors = Config.themes[theme]

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

      local theme_style = Utils.get_theme_style()
      lualine_refresh_theme(theme_style)
    end,
  },

  {
    "snacks.nvim",
    opts = {
      notifier = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
    },
    -- stylua: ignore
    keys = {
      { "<leader>n", function()
        if Snacks.config.picker and Snacks.config.picker.enabled then
          Snacks.picker.notifications()
        else
          Snacks.notifier.show_history()
        end
      end, desc = "Notification History" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    },
  },
}
