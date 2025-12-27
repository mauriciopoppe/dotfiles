local utils = require("my.util")

-- cleans from cache, useful if I make changes to my lua files and reload config
package.loaded["my/util"] = nil

vim.keymap.set({ "n", "x" }, "<Space>", "<Nop>")
vim.keymap.set({ "n", "x" }, ",", "<Nop>")
vim.keymap.set({ "n", "x" }, ";", "<Nop>")

-- ; the secondary leader, mapped to [ui]
vim.keymap.set({ "n", "x" }, "[ui]", "<Nop>")
vim.keymap.set({ "n", "x" }, ";", "[ui]", { remap = true })

-- treat long lines as break lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("v", "j", "gj")
vim.keymap.set("v", "k", "gk")

-- when jumping to the next match on search center the screen
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- when jumping forward/backward center the screen
-- vim.keymap.set("n", "<C-f>", "<C-f>zz")
-- vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- move to the end of the pasted text on copy/paste
vim.keymap.set("v", "y", "y`]")
vim.keymap.set("v", "p", '"_dP`]')

-- avoid `c` from yanking to the default register
vim.keymap.set("n", "c", '"xc')
vim.keymap.set("x", "c", '"xc')

-- fix cw and dw to behave the same way
vim.keymap.set("n", "cw", "ce")
vim.keymap.set("n", "dw", "de")

-- <C-c> to exit from any mode to normal mode
vim.keymap.set("i", "<C-c>", "<ESC>", { remap = true })
vim.keymap.set("v", "<C-c>", "<ESC>", { remap = true })
vim.keymap.set("n", "<C-c>", "<ESC>", { remap = true })
vim.keymap.set("c", "<C-c>", "<ESC>", { remap = true })

-- Poweful <esc>.
vim.keymap.set({ "i", "s", "n" }, "<esc>", function()
  if require("luasnip").expand_or_jumpable() then
    require("luasnip").unlink_current()
  end
  vim.cmd("noh")
  return "<esc>"
end, { desc = "Escape, clear hlsearch, and stop snippet session", expr = true })

-- make Y behavior like D, and C
vim.keymap.set("n", "Y", "y$")

-- quickly close a window
vim.keymap.set("n", "Q", ":q<CR>")

-- since `u` undos `U` redos
vim.keymap.set("n", "U", ":redo<CR>")

-- paste from the system clipboard
vim.keymap.set("n", "<Leader>p", ':set paste<CR>"*]p:set nopaste<cr>')

-- start an external command with a single bang
vim.keymap.set("n", "!", ":!")

-- remove case transform in visual mode
vim.keymap.set("v", "u", "<Nop>")
vim.keymap.set("v", "U", "<Nop>")

-- keep the selection after an indent operation
vim.keymap.set("v", ">", ">gv|")
vim.keymap.set("v", "<", "<gv")

-- quick way to reload vim
vim.keymap.set("n", "<leader>sv", ":so $MYVIMRC<CR>")

-- space + \ = create a new vertical pane (the | key is over \)
-- space + - = create a new horizontal pane
vim.keymap.set("n", "<leader>\\", "<c-w>v<c-w>l")
vim.keymap.set("n", "<leader>-", "<c-w>s")

-- move a line in normal mode while fixing the indentation
vim.keymap.set("n", "∆", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<a-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "˚", ":m .-2<CR>==", { silent = true })
vim.keymap.set("n", "<a-k>", ":m .-2<CR>==", { silent = true })

-- move lines in visual mode while fixing the indentation
vim.keymap.set("v", "∆", ":m '>.+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<a-j>", ":m '>.+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "˚", ":m '<.-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<a-k>", ":m '<.-2<CR>gv=gv", { silent = true })

-- movement inside a line
-- ˙ = alt + h (move to the beginning of the line)
vim.keymap.set("n", "˙", "^")
vim.keymap.set("n", "<a-h>", "^")
-- ¬ = alt + l (move to the end of the line)
vim.keymap.set("n", "¬", "$")
vim.keymap.set("n", "<a-l>", "$")

-- buffer movements
vim.keymap.set("n", "[b", ":bprev<CR>")
vim.keymap.set("n", "]b", ":bnext<CR>")

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

local function float_term(cmd, opts)
  opts = vim.tbl_deep_extend("force", {
    size = { width = 0.9, height = 0.9 },
  }, opts or {})
  require("lazy.util").float_term(cmd, opts)
end

vim.keymap.set("n", "<leader>gg", function()
  float_term({ "lazygit" }, { cwd = utils.get_root() })
end, { desc = "Lazygit (root dir)" })
vim.keymap.set("n", "<leader>gG", function()
  float_term({ "lazygit" })
end, { desc = "Lazygit (cwd)" })

vim.keymap.set("n", "<leader>gp", function()
  local permalink = utils.get_github_permalink_at_current_line()
  require("osc52").copy(permalink)
end, { desc = "Copy relative github path" })

-- [[
-- diagnostic_goto moves to the next/previous diagnostic.
-- Copied from: https://github.com/LazyVim/LazyVim/blob/v2.12.1/lua/lazyvim/plugins/lsp/keymaps.lua#L93
-- ]]
local function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
