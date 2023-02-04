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
    { "K", vim.lsp.buf.hover, desc = "Hover" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
    { "]d", M.diagnostic_goto(true), desc = "Next Diagnostic" },
    { "[d", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
    { "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
    { "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
    { "]w", M.diagnostic_goto(true, "WARN"), desc = "Next Warning" },
    { "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
    { "<leader>cf", M.format, desc = "Format Document", has = "documentFormatting" },
    { "<leader>cf", M.format, desc = "Format Range", mode = "v", has = "documentRangeFormatting" },
    { "<leader>cr", M.rename, expr = true, desc = "Rename", has = "rename" },
  }
  return M._keys
end

function M.rename()
  if pcall(require, "inc_rename") then
    return ":IncRename " .. vim.fn.expand("<cword>")
  else
    vim.lsp.buf.rename()
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

function M.on_attach_set_keymappings(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

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
      opts.silent = true
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
    end
  end
end

function M.format()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0
  print(have_nls)

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

function M.on_attach_set_format(client, buffer)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. buffer, {}),
      buffer = buffer,
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
    },
    opts = {
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
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
      -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
      -- https://github.com/neovim/nvim-lspconfig

      local servers = {}

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        M.on_attach_set_keymappings(client, bufnr)
        M.on_attach_set_format(client, bufnr)
      end

      -- assume that there's a file BUILD in google 3 repos.
      -- the check makes sure that gopls is enabled only in non google3 repos.
      local is_google3 = Utils.is_google3()
      if not is_google3 then
        servers.gopls = {
          on_attach = on_attach,
          flags = {
            debounce_text_changes = 150,
          },
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
      end

      if Utils.is_google3() then
        -- configure ciderlsp on google3 repos
        local nvim_lsp = require("lspconfig")
        local configs = require("lspconfig.configs")
        configs.ciderlsp = {
          default_config = {
            cmd = {
              "/google/bin/releases/cider/ciderlsp/ciderlsp",
              "--tooltag=nvim-lsp",
              "--noforward_sync_responses",
            },
            filetypes = { "c", "cpp", "java", "proto", "textproto", "go", "python", "bzl" },
            root_dir = nvim_lsp.util.root_pattern("BUILD"),
            settings = {},
          },
        }
        servers.ciderlsp = {
          on_attach = on_attach,
        }
      end

      servers.tsserver = {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
      }

      servers["sumneko_lua"] = {
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

      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local function setup(server)
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

      local mlsp = require("mason-lspconfig")
      local available = mlsp.get_available_servers()

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup_handlers({ setup })
    end,
  },
  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          -- nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.flake8,
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
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
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
