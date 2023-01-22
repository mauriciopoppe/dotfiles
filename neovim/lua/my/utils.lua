local api = vim.api
local M = {}

-- [[
-- Checks if a plugin was loaded by vim-plug.
-- ]]
function M.PluginLoaded(repository)
  return vim.g.plugs[repository] ~= nil
end

-- [[
-- CopyAbsolutePathToClipboard copies the absolute path of the focused file to the clipboard.
-- ]]
function M.CopyAbsolutePathToClipboard()
  api.nvim_exec('let @" = expand("%:p") | execute \'OSCYankReg "\'', true)
end

-- [[
-- CopyRelativePathToClipboard copies the relative path of the focused file to the clipboard.
-- ]]
function M.CopyRelativePathToClipboard()
  api.nvim_exec('let @" = expand("%") | execute \'OSCYankReg "\'', true)
end

-- [[
-- CopyFilenameToClipboard copies the filename the focused file to the clipboard.
-- ]]
function M.CopyFilenameToClipboard()
  api.nvim_exec('let @" = expand("%:t") | execute \'OSCYankReg "\'', true)
end

-- local lua_profiler = require('my/lua_profiler')
-- profiler = lua_profiler.newProfiler()
-- function M.profile_fn(fn)
--   profiler:start()
--   fn()
--   profiler:stop()
--   local outfile = io.open("profile.txt", "w+")
--   profiler:report(outfile)
--   outfile:close()
--   print("profile complete!")
-- end

--[[
-- AutoWriteOnFocusLost writes the current buffer if it's a normal buffer
-- more info at https://neovim.io/doc/user/options.html#'buftype'
--]]
function M.AutoWriteOnFocusLost()
  -- current_buffer_number = api.nvim_eval('bufnr("%")')
  -- current_buffer_info = api.nvim_eval(string.format('getbufinfo(%s)[0]', current_buffer_number))
  -- print(vim.inspect(current_buffer_info.name))
  if vim.bo.buftype == "" then
    local current_buffer_number = api.nvim_eval('bufnr("%")')
    local current_buffer_info = api.nvim_eval(string.format('getbufinfo(%s)[0]', current_buffer_number))
    if current_buffer_info.changed ~= 0 then
      api.nvim_command('write')
    end
  end
end

-- [[
-- TrimWhitespace trims the whitespace at the end of all lines,
-- it also preserves the cursor position and search
-- ]]
function M.TrimWhitespace()
  local _s = vim.fn.getreg('@/')
  local l = vim.fn.line(".")
  local c = vim.fn.col(".")
  vim.cmd("execute 'keeppatterns %s/\\s\\+$//e'")
  vim.fn.setreg('@/', _s)
  vim.fn.cursor(l, c)
end

function M.Setup()
  api.nvim_command('augroup autowrite')
    api.nvim_command('autocmd!')
    api.nvim_command('autocmd BufWritePre * :lua require\'my/utils\'.TrimWhitespace()')
    api.nvim_command('autocmd FocusLost,BufLeave * :lua require\'my/utils\'.AutoWriteOnFocusLost()')
  api.nvim_command('augroup END')
end

return M

