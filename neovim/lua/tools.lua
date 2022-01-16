local api = vim.api
local utils = {}

--[[
-- AutoWriteOnFocusLost writes the current buffer if it's a normal buffer
-- more info at https://neovim.io/doc/user/options.html#'buftype'
--]]
function utils.AutoWriteOnFocusLost()
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

function utils.Setup()
  api.nvim_command('augroup autowrite')
    api.nvim_command('autocmd!')
    api.nvim_command('autocmd FocusLost,BufLeave * :lua require\'tools\'.AutoWriteOnFocusLost()')
  api.nvim_command('augroup END')
end

return utils
