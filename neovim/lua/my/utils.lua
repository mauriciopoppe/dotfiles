local M = {}

---@class LazyVimConfig
local options = {
  -- icons used by other plugins
  icons = {
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
  },
  -- I took these colors by looking at the theme I applied to iTerm
  themes = {
    -- Colors from w0ng/vim-hybrid
    -- https://github.com/w0ng/vim-hybrid/blob/master/colors/hybrid.vim#L87
    dark = {
      transparent = "#232c31",
      light = "#2d3c46",
      medium = "#424f58",
      dark = "#8abdb6",
    },
    -- Colors from mvpopuk/inspiried-github.vim
    -- https://github.com/mvpopuk/inspired-github.vim/blob/main/config/lualine.lua
    light = {
      transparent = "#eee8d5",
      light = "#f5f5f5",
      medium = "#f5f5f5",
      dark = "#383a42",
    },
  },
}

-- Setup setups my options, needs to be sourced before require("lazy").setup()
function M.setup()
  vim.g.mapleader = ","

  -- Load options before sourcing plugin modules
  -- https://github.com/LazyVim/LazyVim/blob/2e18998c9ed7d2fa773b782f3aa3c0d5ac5cc21d/lua/lazyvim/config/init.lua#L160-L163
  require("my.options")

  -- Load autocmds and keymaps lazyly
  -- https://github.com/LazyVim/LazyVim/blob/2e18998c9ed7d2fa773b782f3aa3c0d5ac5cc21d/lua/lazyvim/config/init.lua#L160-L163
  --
  if vim.fn.argc(-1) == 0 then
    -- autocmds and keymaps can wait to load
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
      pattern = "VeryLazy",
      callback = function()
        require("my.autocommand")
        require("my.mappings")
      end,
    })
  else
    -- load them now so they affect the opened buffers
    require("my.autocommand")
    require("my.mappings")
  end

  vim.schedule(function()
    if not M.connected_to_internet() then
      vim.notify("Not connected to the internet, some options might not be enabled")
    end
  end)

  -- theme is loaded as a dependency of plenary, see the first lines of /neovim/lua/plugins.lua
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

-- is_google3 checks if we're in a google3 directory
function M.is_google3()
  local pwd = os.getenv("PWD")
  return pwd ~= nil and pwd:find("^/google") ~= nil
end

-- is_go_mod checks if we're in a directory with the file go.mod
function M.is_go_mod()
  local f = io.open(os.getenv("PWD") .. "go.mod")
  if f ~= nil then
    io.close(f)
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

setmetatable(M, {
  __index = function(_, key)
    return options[key]
  end,
})

return M
