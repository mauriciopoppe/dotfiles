local Utils = require("my.util")
local M = {}

---@class LazyVimConfig
local defaults = {
  -- icons used by other plugins
  icons = {
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
  },
  -- I took these colors by looking at the theme I applied to iTerm
  themes = {
    -- Colors from w0ng/vim-hybrid
    -- https://github.com/w0ng/vim-hybrid/blob/master/colors/hybrid.vim#L87
    dark = {
      transparent = "#232c31",
      light = "#2d3c46",
      medium = "#424f58",
      dark = "#8abdb6",
    },
    -- Colors from mvpopuk/inspiried-github.vim
    -- https://github.com/mvpopuk/inspired-github.vim/blob/main/config/lualine.lua
    light = {
      transparent = "#eee8d5",
      light = "#f5f5f5",
      medium = "#f5f5f5",
      dark = "#a2a2a2",
    },
  },
}

local options

-- Setup setups my options, needs to be sourced before require("lazy").setup()
function M.setup()
  vim.g.mapleader = ","

  -- Load options before sourcing plugin modules
  -- https://github.com/LazyVim/LazyVim/blob/2e18998c9ed7d2fa773b782f3aa3c0d5ac5cc21d/lua/lazyvim/config/init.lua#L160-L163
  require("my.config.options")
  require("my.config.autocommand")
  require("my.config.mappings")

  vim.schedule(function()
    if not Utils.connected_to_internet() then
      vim.notify("Not connected to the internet, some options might not be enabled")
    end
  end)

  -- theme is loaded as a dependency of plenary, see the first lines of /neovim/lua/plugins.lua
end

setmetatable(M, {
  __index = function(_, key)
    if options == nil then
      return vim.deepcopy(defaults)[key]
    end
    ---@cast options LazyVimConfig
    return options[key]
  end,
})

return M
