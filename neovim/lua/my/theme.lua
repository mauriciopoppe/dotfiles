local M = {}

local function fix_options()
  vim.g.hybrid_custom_term_colors = 1
  vim.g.hybrid_reduced_contrast = 1
end

local function change_background()
  local themeFile = vim.fn.readfile(vim.fn.expand("~/.tmux.theme"))
  -- arrays are indexed at 1!
  local theme = themeFile[1]
  if theme == "dark" then
    vim.g.background = "dark"
    vim.cmd.colorscheme("hybrid")
  elseif theme == "light" then
    vim.g.background = "light"
    vim.cmd.colorscheme("solarized8")
  else
    print("No theme found")
  end
end

local function reset_highlight()
  vim.cmd([[
  " Buftabline colors
  hi! link BufTabLineCurrent PreProc
  hi! link BufTabLineActive Comment
  hi! link BufTabLineHidden Comment
  hi! link BufTabLineFill Comment

  " clear background for SignColumn (any column that doesn't have a sign)
  highlight clear SignColumn
  " clear sign background
  highlight SignifySignAdd    cterm=none ctermbg=none ctermfg=lightgreen
  highlight SignifySignDelete cterm=none ctermbg=none ctermfg=red
  highlight SignifySignChange cterm=none ctermbg=none ctermfg=yellow
  ]])
end

function M.setup()
  fix_options()
  change_background()
  reset_highlight()
end

return M