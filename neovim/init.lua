-- init.lua
--
--[[

My neovim config is a modified copy of LazyVim's config.
I use a lot of its utility functions but not LazyVim directly, it's synced with LazyVim v6.0.0
(https://github.com/LazyVim/LazyVim/releases/tag/v6.0.0)

File structure:

./init.lua - Is this file
./lua/my/*.lua - These are configurations for core stuff (outside custom plugin setup), loaded through this file
./lua/plugins.lua - Root config for plugins, loaded by lazy.vim
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
require("my.utils").setup()

-- Custom setup copied from LazyVim starter
-- https://github.com/LazyVim/starter/blob/main/lua/config/lazy.lua
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
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

-- at work alt.vim is a symlink to my work neovim config
-- see the output of `ls -la neovim/config/alt.vim`
local abspath = vim.fn.expand("~/.config/nvim/alt.vim")
if vim.loop.fs_stat(abspath) then
  vim.cmd("source " .. abspath)
end
