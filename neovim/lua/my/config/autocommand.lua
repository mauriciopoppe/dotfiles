local api = vim.api

-- [[
-- TrimWhitespace trims the whitespace at the end of all lines,
-- it also preserves the cursor position and search
-- ]]
function TrimWhitespace()
  local _s = vim.fn.getreg("@/")
  local l = vim.fn.line(".")
  local c = vim.fn.col(".")
  vim.cmd("execute 'keeppatterns %s/\\s\\+$//e'")
  vim.fn.setreg("@/", _s)
  vim.fn.cursor(l, c)
end

--[[
-- AutoWriteOnFocusLost writes the current buffer if it's a normal buffer
-- more info at https://neovim.io/doc/user/options.html#'buftype'
--]]
function AutoWriteOnFocusLost()
  -- current_buffer_number = api.nvim_eval('bufnr("%")')
  -- current_buffer_info = api.nvim_eval(string.format('getbufinfo(%s)[0]', current_buffer_number))
  -- print(vim.inspect(current_buffer_info.name))
  if vim.bo.buftype == "" then
    local current_buffer_number = api.nvim_eval('bufnr("%")')
    local current_buffer_info = api.nvim_eval(string.format("getbufinfo(%s)[0]", current_buffer_number))
    -- only save if the buffer contents changed and if the buffer has a name (e.g. if it's not a :new buffer)
    if current_buffer_info.changed ~= 0 and current_buffer_info.name ~= "" then
      api.nvim_command("write")
    end
  end
end

local autowrite = vim.api.nvim_create_augroup("vimrc", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = autowrite,
  callback = TrimWhitespace,
})
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = "*",
  group = autowrite,
  callback = AutoWriteOnFocusLost,
})

local setup = vim.api.nvim_create_augroup("setup", { clear = true })
-- hide preview on complete
vim.api.nvim_create_autocmd({ "CompleteDone" }, {
  pattern = "*",
  group = setup,
  command = "pclose",
})
-- highlight yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  group = setup,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 1000, on_visual = true })
  end,
})
local checktime = vim.api.nvim_create_augroup("checktime", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = checktime,
  command = "checktime",
})

vim.cmd([[
augroup FTCheck
  autocmd!
  autocmd BufRead,BufNewFile *.md           set ft=markdown
  autocmd BufRead,BufNewFile *.pom          set ft=xml
  autocmd BufRead,BufNewFile .babelrc       set ft=json
  autocmd BufRead,BufNewFile *named.conf*   set ft=named
  autocmd BufRead,BufNewFile fluent.conf    set ft=fluentd
  autocmd BufRead,BufNewFile Brewfile       set ft=ruby
  autocmd BufRead,BufNewFile Dockerfile.*   set ft=dockerfile

  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx

  autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
  autocmd FileType go setlocal ts=4 sts=4 sw=4
  autocmd FileType markdown setlocal ts=2 sts=2 sw=2

  " hide preview window
  " autocmd FileType go setlocal completeopt-=preview

  " in makefiles, don't expand tabs to spaces, since actual tab characters are
  " needed, and have indentation at 8 chars to be sure that all indents are tabs
  " (despite the mappings later):
  autocmd FileType make         setlocal noexpandtab ts=4 sw=4 sts=4

  " alternative: set no limit on the text width
  " autocmd FileType markdown set textwidth=0
  autocmd FileType apache       setlocal commentstring=#\ %s

  " <C-x>! sets the shebang
  autocmd FileType sh,zsh,csh,tcsh inoremap <silent> <buffer> <C-X>! #!/bin/<C-R>=&ft<CR>

  "spell check when writing commits
  autocmd FileType git,gitcommit setlocal foldmethod=syntax foldlevel=1
  autocmd FileType svn,gitcommit setlocal spell

  autocmd FileType help setlocal ai fo+=2n | silent! setlocal nospell
  autocmd FileType help nnoremap <silent><buffer> q :q<CR>

  autocmd FileType markdown,terraform,python,zsh,sh setlocal wrap textwidth=0 wrapmargin=0

  autocmd FileType proto setlocal wrap textwidth=120 wrapmargin=0 ts=4 sw=4

augroup END
]])
