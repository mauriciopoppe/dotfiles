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

      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local servers = {}

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
      end

      -- Checks if a path is a file.
      local function is_file(path)
        local f = io.open(path)
        return f ~= nil
      end

      -- Checks if a path is a directory.
      -- From https://stackoverflow.com/questions/2833675/using-lua-check-if-file-is-a-directory
      local function is_dir(path)
        local f = io.open(path)
        return not f:read(0) and f:seek("end") ~= 0
      end

      -- assume that there's a file BUILD in google 3 repos.
      -- the check makes sure that gopls is enabled only in non google3 repos.
      local is_google3 = is_file('BUILD') and not is_dir('BUILD')
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
              globals = {"vim"}
            },
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            telemetry = {
              enable = false
            }
          },
        },
      }

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

    end
  },
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
