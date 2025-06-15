-- init.lua
--
--[[

My neovim config is a modified copy of LazyVim's config.
I use a lot of its utility functions but not LazyVim directly.

File structure:

./init.lua - Is this file
./lua/my/*.lua - These are configurations for core stuff (outside custom plugin setup), loaded *manually* through my/utils
./lua/plugins/*.lua - Additional configs which are more complex, loaded by lazy.vim

For more info about the plugin load order run:

:Lazy

Inspired by:

- https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim
- https://github.com/folke/lazy.nvim
- https://www.lazyvim.org/

--]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- My setup
require("my.config").setup()

-- I know what I'm doing with the plugin loading order.
vim.g.lazyvim_check_order = false

local spec = {
  { import = "plugins" },
}
-- Conditionally import my google3 stuff if it's available
-- (it'd only be available at work).
if os.getenv("DOTFILES_DIRECTORY_ALT") ~= nil then
  local my_google3_module = {
    dir = os.getenv("DOTFILES_DIRECTORY_ALT") .. "/nvim_google3",
    import = "nvim_google3",
  }
  table.insert(spec, my_google3_module)
end

-- Custom setup copied from LazyVim starter
-- https://github.com/LazyVim/starter/blob/main/lua/config/lazy.lua
require("lazy").setup({
  defaults = {
    version = false,
  },
  spec = spec,
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
    },
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
