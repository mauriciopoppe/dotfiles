-- init.lua
--
--[[

File structure:

./init.lua - Is this file
./plugin/*.{lua,vim} - These are configurations for core stuff (outside custom plugin setup)
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
vim.keymap.set("n", "<Space>", "<Nop>")
vim.keymap.set("x", "<Space>", "<Nop>")
vim.keymap.set("n", ",", "<Nop>")
vim.keymap.set("x", ",", "<Nop>")
vim.keymap.set("n", ";", "<Nop>")
vim.keymap.set("x", ";", "<Nop>")

-- ; the secondary leader, mapped to [ui]
vim.keymap.set("n", "[ui]", "<Nop>")
vim.keymap.set("x", "[ui]", "<Nop>")
vim.keymap.set("n", ";", "[ui]", { remap = true })
vim.keymap.set("x", ";", "[ui]", { remap = true })

-- Turn off builtin plugins I do not use
require("my.disable_builtin")

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

require("lazy").setup("plugins", {
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
})

-- at work alt.vim is a symlink to my work neovim config
-- see the output of `ls -la neovim/config/alt.vim`
local abspath = vim.fn.expand("~/.config/nvim/alt.vim")
if vim.loop.fs_stat(abspath) then
  vim.cmd("source " .. abspath)
end
