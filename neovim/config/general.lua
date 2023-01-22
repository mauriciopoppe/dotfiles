-- Basic settings {{{
-- default shell is zsh
vim.o.shell = "/bin/zsh"
-- line numbering on
vim.o.number = true
-- hide last line message (e.g. hide --INSERT--)
vim.o.showmode = false
-- wrap text at 120 characters
vim.o.textwidth = 120
-- column width indicator
vim.o.colorcolumn = "+1"
-- hiden instead of unload a buffer when abandoned
vim.o.hidden = true
-- yank operation don't need to use the *-- register (system clipboard)
vim.o.clipboard = "unnamedplus"
-- don't show matching brackets (performance improvement)
vim.o.showmatch = false
-- when switching buffers don't move to the start of the line
vim.o.startofline = false
-- minimum number of lines shown above the cursor when scrolling
vim.o.scrolloff = 5
-- allow positioning the cursor in places where there is no characters
vim.o.virtualedit = "block"
-- read file changes on update
vim.o.autoread = true
-- time to wait for a mapped sequence to complete
-- e.g. wait 500ms when typing `j` and after `k` to exit from insert mode
vim.o.timeoutlen = 500
-- }}}
-- Indentation settings {{{

-- replace tab with spaces (insert a tab with <c-v><tab>)
vim.o.expandtab = true
-- number of spaces inserted when <tab> is pressed (on insert mode)
vim.o.softtabstop = 2
-- how many columns are indented with the indent operations (<< and >>)
vim.o.shiftwidth = 2
-- how many places should a tab be seen as
vim.o.tabstop = 4
-- enable break indent
vim.o.breakindent = true
-- }}}
-- Display settings {{{

vim.o.mouse = "a"
-- wrap long lines (doesn't change what's on the buffer)
vim.o.linebreak = true
-- show invisible chars
vim.o.list = true
-- strings to use in list mode
vim.o.listchars = "tab:⋮ ,extends:❯,precedes:❮,nbsp:␣"
-- string to use at the start of lines that have been wrapped
vim.o.showbreak = "↪"

-- }}}
-- Split settings {{{

-- :hsplit will put a window below the current window
vim.o.splitbelow = true
-- :vsplit will put a window right the current window
vim.o.splitright = true
-- }}}
-- Backup settings {{{

-- disable swap files
vim.o.swapfile = false
-- disable making a backup before owerwriting a file
vim.o.backup = false
vim.o.writebackup = false
-- enable persistent undo with a filename = full path
vim.o.undofile = true
-- undo files are stored inside the following path
vim.o.undodir = vim.fn.expand("~/.config/nvim/undo")
-- }}}
-- Spelling settings {{{

-- spellfile location
vim.o.spellfile = vim.fn.expand("~/.config/nvim/spell/dictionary.utf-8.add")
-- language is US english
vim.o.spelllang = "en_us"
-- }}}
-- Search settings {{{

-- ignore case by default
vim.o.ignorecase = true
-- make search case sensitive only if it contains uppercase letters
vim.o.smartcase = true
-- search again from top when it reaches the bottom
vim.o.wrapscan = true
-- don't highlight after search
vim.o.hlsearch = false
-- }}}

-- Filetype settings {{{
-- }}}

-- Folding settings {{{

-- markers are used to specify folds
vim.o.foldmethod = "marker"
-- 2nd level folding
vim.o.foldlevelstart = 2
-- characters to fill in the fold
vim.o.fillchars = "fold: "

-- }}}
-- Omni completion settings {{{

vim.o.completeopt = "menuone,noselect"

-- enable 24bit RGB color in the TUI
vim.o.termguicolors = true

-- }}}
