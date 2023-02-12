-- init.lua
--
--[[

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
vim.g.mapleader = ","

-- Load options before sourcing plugin modules
-- https://github.com/LazyVim/LazyVim/blob/2e18998c9ed7d2fa773b782f3aa3c0d5ac5cc21d/lua/lazyvim/config/init.lua#L160-L163
require("my.options")

-- Load autocmds and keymaps lazyily
vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
  pattern = "VeryLazy",
  callback = function()
    require("my.autocommand")
    require("my.mappings")
    require("my.theme")
  end,
})

-- enable 24bit RGB color in the TUI, required for some plugins
vim.o.termguicolors = true

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
