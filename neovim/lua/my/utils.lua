local api = vim.api
local M = {}

--[[
CopyAbsolutePathToClipboard copies the absolute path of the focused file to the clipboard.
--]]
function M.CopyAbsolutePathToClipboard()
  api.nvim_exec('let @" = expand("%:p") | execute \'OSCYankReg "\'', true)
end

--[[
CopyRelativePathToClipboard copies the relative path of the focused file to the clipboard.
--]]
function M.CopyRelativePathToClipboard()
  api.nvim_exec('let @" = expand("%") | execute \'OSCYankReg "\'', true)
end

--[[
CopyFilenameToClipboard copies the filename the focused file to the clipboard.
--]]
function M.CopyFilenameToClipboard()
  api.nvim_exec('let @" = expand("%:t") | execute \'OSCYankReg "\'', true)
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

-- : create a togglable terminal
-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
---@param opts? LazyCmdOptions|{interactive?:boolean}
function M.float_term(cmd, opts)
  opts = vim.tbl_deep_extend("force", {
    size = { width = 0.9, height = 0.9 },
  }, opts or {})
  require("lazy.util").float_term(cmd, opts)
end

return M

