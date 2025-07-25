local Utils = require("my.util")

local M = {}

-- change_background changes the background based on the color
-- written as a string to ~/.theme
local function change_background()
  vim.g.hybrid_custom_term_colors = 1
  vim.g.hybrid_reduced_contrast = 1

  local theme = Utils.get_theme_style()
  vim.o.background = theme
  if theme == "dark" then
    vim.cmd.colorscheme("hybrid")
  elseif theme == "light" then
    vim.cmd.colorscheme("github_light_default")
  end
end

-- reset_highlight ets the highlight to default, this is needed if the
-- colorscheme is loaded many times
local function reset_highlight()
  vim.cmd([[
  " MatchParen background color
  hi MatchParen ctermbg=none guibg=#888888

  " clear background for SignColumn (any column that doesn't have a sign)
  highlight clear SignColumn

  " clear sign background
  highlight SignifySignAdd    cterm=none ctermbg=none ctermfg=lightgreen
  highlight SignifySignDelete cterm=none ctermbg=none ctermfg=red
  highlight SignifySignChange cterm=none ctermbg=none ctermfg=yellow

  " This is a hack to have the neotree file modified colors as expected,
  " the problem is the interaction between neotree and gitsigns,
  " - if gitsigns is loaded first then it sets a weird color
  " - if neotree is loaded first then it sets the right color #d7af5f
  "
  " Both are lazy loaded and if there's a buffer already opened
  " then I see the weird bug, after reading https://github.com/lewis6991/gitsigns.nvim/blob/4bd5d7702c17643ff40c035b6b936757b99743c7/lua/gitsigns/highlight.lua#L203
  " I see that it'll set the color only if it was not set, the solution
  " is to set the value of these two values to the value that neotree
  " sets which is the right one https://github.com/nvim-neo-tree/neo-tree.nvim/blob/245cf1e68840defcc75a16297740f6203f5a045d/lua/neo-tree/ui/highlights.lua#L257
  " that way, even if gitsigns is loaded first then the color will be already
  " set and it won't override it.
  highlight GitGutterChange guifg=#d7af5f
  highlight GitSignsChange guifg=#d7af5f

  " Changes the color of the context lines on top of the buffer.
  hi! NormalFloat guibg=none
  hi! TreesitterContextBottom gui=underline guisp=#888888
  hi! TreesitterContextLineNumberBottom gui=underline guisp=#888888
  ]])
end

function M.setup()
  change_background()
  reset_highlight()
end

return M
