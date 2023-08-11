-- The definition of the module M comes from
-- https://github.com/LazyVim/LazyVim/blob/c5b22c0832603198f571ff68b6fb9d0c17f73d33/lua/lazyvim/plugins/lsp/keymaps.lua

local Utils = require("my.utils")
local M = {
  -- autoformat through null-ls enabled by default
  autoformat = true,
}

function M.get_keymappings()
  ---@class PluginLspKeys
  -- stylua: ignore
  M._keys = M._keys or {
    -- { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
    -- { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      -- { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
      -- { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      -- { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      -- { "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
    -- { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
    { "gK", vim.lsp.buf.hover, desc = "Hover" },
    { "]d", M.diagnostic_goto(true), desc = "Next Diagnostic" },
    { "[d", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
    { "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
    { "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
    { "]w", M.diagnostic_goto(true, "WARN"), desc = "Next Warning" },
    { "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
  }

  -- enable better rename plugin
  if require("lazy.core.config").plugins["inc-rename.nvim"] ~= nil then
    M._keys[#M._keys + 1] = {
      "<leader>cr",
      function()
        local inc_rename = require("inc_rename")
        return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
      end,
      expr = true,
      desc = "Rename",
      has = "rename",
    }
  else
    M._keys[#M._keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
  end
  return M._keys
end

-- [[
-- on_attach_set_keymappings attaches keymaps on read buffers.
-- Copied from: https://github.com/LazyVim/LazyVim/blob/v2.12.1/lua/lazyvim/plugins/lsp/keymaps.lua#L68
-- ]]
function M.on_attach_set_keymappings(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {}

  for _, value in ipairs(M.get_keymappings()) do
    local keys = Keys.parse(value)
    if keys[2] == vim.NIL or keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
      local opts = Keys.opts(keys)
      ---@diagnostic disable-next-line: no-unknown
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set("n", keys[1], keys[2], opts)
    end
  end
end

-- [[
-- diagnostic_goto moves to the next/previous diagnostic.
-- Copied from: https://github.com/LazyVim/LazyVim/blob/v2.12.1/lua/lazyvim/plugins/lsp/keymaps.lua#L93
-- ]]
function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

-- [[
-- format applies a formatter through null-ls.
-- Modified copy from: https://github.com/LazyVim/LazyVim/blob/v2.12.1/lua/lazyvim/plugins/lsp/format.lua#L22
-- ]]
function M.format()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

  vim.lsp.buf.format({
    bufnr = buf,
    -- filter (function|nil): Predicate used to filter clients.
    -- Receives a client as argument and must return a boolean.
    -- Clients matching the predicate are included.
    filter = function(client)
      if have_nls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
  })
end

-- [[
-- on_attach_set_format applies autoformatting to buffers on attach.
-- Taken from: https://github.com/LazyVim/LazyVim/blob/v2.12.1/lua/lazyvim/plugins/lsp/format.lua#L42
-- ]]
function M.on_attach_set_format(client, buf)
  -- dont format if client disabled it
  if
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
      buffer = buf,
      callback = function()
        if M.autoformat then
          M.format()
        end
      end,
    })
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "smjonas/inc-rename.nvim",
    },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        -- Disable virtual_text since it's redundant due to lsp_lines.
        -- https://git.sr.ht/~whynothugo/lsp_lines.nvim
        virtual_text = false,
        severity_sort = true,
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts: any):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    config = function(_, opts)
      local nvim_lsp = require("lspconfig")
      -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
      -- https://github.com/neovim/nvim-lspconfig

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        M.on_attach_set_keymappings(client, bufnr)
        M.on_attach_set_format(client, bufnr)
      end

      -- servers is a list of customized servers that have their own config.
      local servers = {
        -- remember to set `mason = false` on lsp servers that don't can't be installed through mason
      }

      -- assume that there's a file BUILD in google 3 repos.
      -- the check makes sure that gopls is enabled only in non google3 repos.
      local lspconfigs = require("lspconfig.configs")
      lspconfigs.ciderlsp = {
        default_config = {
          cmd = { "/google/bin/releases/cider/ciderlsp/ciderlsp", "--tooltag=nvim-lsp", "--noforward_sync_responses" },
          filetypes = { "c", "cpp", "java", "kotlin", "objc", "proto", "textproto", "go", "python", "bzl" },
          root_dir = nvim_lsp.util.root_pattern("google3/*BUILD"),
          settings = {},
        },
      }
      servers.ciderlsp = {
        mason = false,
        on_attach = on_attach,
      }

      -- setup gopls for non google3 repos.
      servers.gopls = {
        on_attach = on_attach,
        root_dir = nvim_lsp.util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            env = {
              -- Enable analysis of files with the tag linux.
              -- Without this we can't analyze files that have a linux impl of a function.
              --
              -- Similar issue upstream https://github.com/golang/go/issues/29202
              -- Setting additional opts for gopls https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-v050
              GOFLAGS = "-tags=linux",

              -- In the kubernetes codebase I got errors like:
              -- Error when executing textDocument/implementation : packages.Load error: err: exit status 2:
              -- # runtime/cgo
              -- linux_syscall.c:67:13: error: implicit declaration of function 'setresgid' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
              -- linux_syscall.c:67:13: note: did you mean 'setregid'?
              --
              -- Because of the runtime/cgo above I thought I could disable it
              -- https://github.com/golang/go/issues/29202#issuecomment-496007059
              CGO_ENABLED = "0",
            },
          },
        },
      }

      servers.ruff_lsp = {
        on_attach = on_attach,
        init_options = {
          settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
          },
        },
      }

      servers.tsserver = {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
      }

      servers["lua_ls"] = {
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = Utils.icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- setup_server sets up an LSP server
      local function setup_server(server)
        local server_opts = servers[server] or {}
        server_opts.capabilities = capabilities
        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end
      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup_server(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end
      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed })
      end
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    lazy = true,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "smjonas/inc-rename.nvim",
    lazy = true,
    config = true,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          -- code actions
          null_ls.builtins.code_actions.refactoring,
          -- diagnostics
          null_ls.builtins.diagnostics.tsc,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.codespell,
          -- formatting
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.prettierd,
          -- hover
        },
      }
    end,
  },
  -- lsp package manager
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "prettierd",
        "stylua",
        "shellcheck",
        "shfmt",
        "codespell",
        -- lsp
        "clangd",
        "gopls",
        "lua-language-server",
        "typescript-language-server",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
}
