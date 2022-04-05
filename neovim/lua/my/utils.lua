local api = vim.api
local M = {}

--[[
-- AutoWriteOnFocusLost writes the current buffer if it's a normal buffer
-- more info at https://neovim.io/doc/user/options.html#'buftype'
--]]
function M.AutoWriteOnFocusLost()
  -- current_buffer_number = api.nvim_eval('bufnr("%")')
  -- current_buffer_info = api.nvim_eval(string.format('getbufinfo(%s)[0]', current_buffer_number))
  -- print(vim.inspect(current_buffer_info.name))
  if vim.bo.buftype == "" then
    current_buffer_number = api.nvim_eval('bufnr("%")')
    current_buffer_info = api.nvim_eval(string.format('getbufinfo(%s)[0]', current_buffer_number))
    if current_buffer_info.changed ~= 0 then
      api.nvim_command('write')
    end
  end
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

function M.Setup()
  api.nvim_command('augroup autowrite')
    api.nvim_command('autocmd!')
    api.nvim_command('autocmd FocusLost,BufLeave * :lua require\'my/utils\'.AutoWriteOnFocusLost()')
  api.nvim_command('augroup END')
end

return M
