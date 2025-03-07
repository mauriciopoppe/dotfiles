-- The definition of the module M comes from
-- https://github.com/LazyVim/LazyVim/blob/c5b22c0832603198f571ff68b6fb9d0c17f73d33/lua/lazyvim/plugins/lsp/keymaps.lua

local Utils = require("my.util")

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "smjonas/inc-rename.nvim",
      {
        "piloto/cmp-nvim-ciderlsp",
        url = "sso://user/piloto/cmp-nvim-ciderlsp",
        cond = function()
          return Utils.is_google3()
        end,
      },
    },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        -- Disable virtual_text since it's redundant due to lsp_lines.
        -- https://git.sr.ht/~whynothugo/lsp_lines.nvim
        -- virtual_text = false,
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
      servers = {},
    },
    config = function(_, opts)
      local nvim_lsp = require("lspconfig")
      -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
      -- https://github.com/neovim/nvim-lspconfig

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, buffer)
        local ok
        local format = require("plugins.lsp.format")
        ok, _ = pcall(format.on_attach, client, buffer)
        if not ok then
          vim.notify("Failed to call lsp.format.on_attach")
        end

        local keymaps = require("plugins.lsp.keymaps")
        ok, _ = pcall(keymaps.on_attach, client, buffer)
        if not ok then
          vim.notify("Failed to call lsp.keymaps.on_attach")
        end
      end

      -- servers is a list of customized servers that have their own config.
      local servers = opts.servers

      -- advertise support for completion through cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      if Utils.is_google3() then
        -- assume that there's a file BUILD in google 3 repos.
        -- the check makes sure that gopls is enabled only in non google3 repos.
        local lspconfigs = require("lspconfig.configs")
        lspconfigs.ciderlsp = {
          default_config = {
            cmd = { "/google/bin/releases/cider/ciderlsp/ciderlsp", "--tooltag=nvim-lsp", "--noforward_sync_responses" },
            filetypes = { "c", "cpp", "java", "kotlin", "objc", "proto", "textproto", "go", "python", "bzl" },
            offset_encoding = "utf-16",
            root_dir = nvim_lsp.util.root_pattern("google3/*BUILD"),
            settings = {},
          },
        }
        servers.ciderlsp = {
          mason = false,
          on_attach = on_attach,
        }
        -- from the internal piloto cmp-nvim-ciderlsp
        capabilities = require("cmp_nvim_ciderlsp").update_capabilities(capabilities)
      end

      -- setup gopls for non google3 repos.
      servers.gopls = {
        on_attach = on_attach,
        root_dir = nvim_lsp.util.root_pattern("go.work", "go.mod", ".git"),
        single_file_support = false,
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

      servers["clangd"] = {
        cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
        init_options = {
          fallbackFlags = { "-std=c++17" },
        },
        mason = false,
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
        mlsp.setup_handlers({ setup_server })
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
    "nvimtools/none-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      local sources = {
        -- code actions
        null_ls.builtins.code_actions.refactoring,
        -- diagnostics
        null_ls.builtins.diagnostics.codespell,
        -- formatting
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettierd,
      }

      -- skip go formatters if on google3
      if not Utils.is_go_mod() then
        sources[#sources + 1] = null_ls.builtins.formatting.gofmt
        sources[#sources + 1] = null_ls.builtins.formatting.goimports
      end

      return {
        debug = true,
        sources = sources,
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
        "shellcheck",
        "shfmt",
        "codespell",
        -- formatter
        "black", -- python
        "prettierd", -- typescript/javascript
        "stylua", -- lua
        -- lsp
        "gopls",
        "lua-language-server",
        "typescript-language-server",
        -- debugger
        "debugpy",
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
