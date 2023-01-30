local api = vim.api
local M = {}

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

return M

