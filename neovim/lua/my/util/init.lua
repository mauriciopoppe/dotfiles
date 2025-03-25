local LazyUtil = require("lazy.core.util")

local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("my.util." .. k)
    return t[k]
  end,
})

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

-- is_google3 checks if we're in a google3 directory
function M.is_google3()
  local pwd = os.getenv("PWD")
  return pwd ~= nil and pwd:find("^/google") ~= nil
end

-- is_go_mod checks if we're in a directory with the file go.mod
function M.is_go_mod()
  local f = io.open(os.getenv("PWD") .. "/go.mod")
  if f ~= nil then
    io.close(f)
    return true
  end
  local f2 = io.open(os.getenv("PWD") .. "/go.work")
  if f2 ~= nil then
    io.close(f2)
    return true
  end
  return false
end

-- is_personal check if neovim is running in my personal laptop.
function M.is_personal()
  local is_local_env = string.match(vim.fn.system("uname -a"), "Darwin.*Mauricio.*arm")
  return is_local_env ~= nil
end

-- connected_to_internet checks if we're connected to the internet.
function M.connected_to_internet()
  local ping = vim.fn.system("ping -c1 google.com")
  return string.match(ping, "1.*received") ~= nil
end

-- is_linux returns true if the platform is linux
function M.is_linux()
  local is_local_env = string.match(vim.fn.system("uname -a"), "Linux")
  return is_local_env ~= nil
end

-- is_macos returns true if the platform is Darwin
function M.is_macos()
  local is_local_env = string.match(vim.fn.system("uname -a"), "Darwin")
  return is_local_env ~= nil
end

-- get_theme_style reads the theme style from the filesystem.
-- The theme is set through /zsh/bin/change-background
function M.get_theme_style()
  local themeFile = vim.fn.readfile(vim.fn.expand("~/.tmux.theme"))
  local theme_style = themeFile[1]
  if theme_style == "dark" or theme_style == "light" then
    return theme_style
  else
    error("theme must be dark or light")
  end
end

function M.get_github_permalink_at_current_line()
  -- copy_line_with_github_path copies the line in the current buffer
  -- in a github permalink that contains the repo, sha, file, line number.
  local cwd = vim.loop.cwd()
  local last_line_number, _ = unpack(vim.api.nvim_win_get_cursor(0))
  -- remove prefix ~/go/src/<domain> with https://github.com
  local local_path_no_go_src = cwd:gsub("^" .. vim.fn.expand("$HOME/go/src/"), "")

  -- special case: replace known go modules with github.com because that's where the source code is.
  if local_path_no_go_src:find("^(k8s.io)") ~= nil then
    local_path_no_go_src = local_path_no_go_src:gsub("^k8s.io", "github.com/kubernetes")
  end
  if local_path_no_go_src:find("^(sigs.k8s.io)") ~= nil then
    local_path_no_go_src = local_path_no_go_src:gsub("^sigs.k8s.io", "github.com/kubernetes-sigs")
  end

  local github_project = "https://" .. local_path_no_go_src
  local commit = vim.fn.system("git rev-parse HEAD")
  local github_path = table.concat({
    github_project,
    "blob",
    commit:gsub("%s+", ""),
    vim.fn.expand("%:.") .. "#L" .. last_line_number,
  }, "/")
  return github_path
end

-- The following functions come from https://github.com/LazyVim/LazyVim/blob/eca86924510676667a3868efc512588749f6594e/lua/lazyvim/util/init.lua

---@param name string
function M.get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

---@param name string
---@param path string?
function M.get_plugin_path(name, path)
  local plugin = M.get_plugin(name)
  path = path and "/" .. path or ""
  return plugin and (plugin.dir .. path)
end

function M.has(plugin)
  return M.get_plugin(plugin) ~= nil
end

---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").spec.plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

function M.is_loaded(name)
  local Config = require("lazy.core.config")
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

return M
