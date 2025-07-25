local Utils = require("my.util")

return {
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<leader>bb", function() require("dap").toggle_breakpoint() end, },
      { "<leader>bc", function() require("dap").continue() end, },
    },
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")

      local function c(func, opts)
        return function()
          func(opts)
        end
      end

      -- preview window under cursor
      vim.keymap.set("n", "<Leader>bp", function()
        local opts = { width = 200, height = 15, enter = true }
        local dapui = require("dapui")
        dapui.float_element("scopes", opts)
      end)

      vim.keymap.set("n", "<leader>b.", c(dap.run_to_cursor))
      vim.keymap.set("n", "<leader>bj", c(dap.down))
      vim.keymap.set("n", "<leader>bk", c(dap.up))
      vim.keymap.set("n", "<leader>bL", function()
        dap.list_breakpoints()
        vim.cmd.copen()
      end)
      vim.keymap.set("n", "<leader>bt", function()
        dap.terminate()
        require("dapui").close()
      end)
      vim.keymap.set("n", "<leader>bb", c(dap.toggle_breakpoint))

      -- The following mapping is the trigger to lazy load nvim-dap-ui
      -- so it's commented here
      vim.keymap.set("n", "<leader>bj", c(dap.step_into))
      vim.keymap.set("n", "<leader>bk", c(dap.step_out))
      vim.keymap.set("n", "<leader>bl", c(dap.step_over))
      vim.keymap.set("n", "<leader>br", c(dap.run_last))
      vim.keymap.set("n", "<leader>bx", c(dap.clear_breakpoints))

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "WarningMsg" })
      vim.fn.sign_define("DapStopped", { text = "▶", linehl = "CursorLine" })

      dap.listeners.after.event_initialized["dap_debug_mappings"] = function()
        vim.keymap.set("n", "H", c(dap.continue))
        vim.keymap.set("n", "J", c(dap.step_into))
        vim.keymap.set("n", "K", c(dap.step_out))
        vim.keymap.set("n", "L", c(dap.step_over))
      end
      dap.listeners.after.event_exited["dap_debug_mappings"] = function()
        -- TODO: this isn't working, need to figure out how to remove the keymaps
        vim.keymap.del("n", "H")
        vim.keymap.del("n", "J")
        vim.keymap.del("n", "K")
        vim.keymap.del("n", "L")
      end

      -- setup adapter for go config taken from
      -- https://github.com/leoluz/nvim-dap-go/blob/4dd9c899997599c93a28aadf864a7924a4031f3e/lua/dap-go.lua#L55
      dap.adapters.go = function(callback, config)
        local stdout = vim.loop.new_pipe(false)
        local stderr = vim.loop.new_pipe(false)
        local handle
        local pid_or_err
        local host = config.host or "127.0.0.1"
        local port = config.port or "38697"
        local addr = string.format("%s:%s", host, port)
        if config.request == "attach" and config.mode == "remote" then
          local msg = string.format("connecting to server at '%s'...", addr)
          print(msg)
        else
          local opts = {
            stdio = { nil, stdout, stderr },
            -- To enable debugging:
            -- - Uncomment the following line (and comment the other args line below)
            -- - Check ~/.cache/nvim/dap.log (I saw set breakpoint errors here)
            -- stylua: ignore
            -- args = { "dap", "-l", addr, "--log", "--log-output", "rpc,dap", "--log-dest", "/tmp/dap.log", "--only-same-user=false" },
            args = { "dap", "-l", addr, "--only-same-user=false" },
            detached = true,
          }

          handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
            stdout:read_stop()
            stderr:read_stop()
            stdout:close()
            stderr:close()
            handle:close()
            if code ~= 0 then
              print("ERROR: dlv exited with code", code)
            end
          end)
          assert(handle, "Error running dlv: " .. tostring(pid_or_err))

          stdout:read_start(function(err, chunk)
            assert(not err, err)
            if chunk then
              vim.schedule(function()
                require("dap.repl").append(chunk)
              end)
            end
          end)
          stderr:read_start(function(err, chunk)
            assert(not err, err)
            if chunk then
              vim.schedule(function()
                require("dap.repl").append(chunk)
              end)
            end
          end)
        end

        -- Wait for delve to start
        vim.defer_fn(function()
          callback({ type = "server", host = host, port = port })
        end, 100)
      end

      local function kubernetes_path()
        if Utils.is_linux() then
          -- Assume that when building on linux it's for the same platform
          -- so the binaries don't need to be compiled i.e. that the kubernetes
          -- binaries will be in k8s.io/kubernetes/_output/bin
          return "${env:HOME}/go/src/k8s.io/kubernetes"
        end
        -- Assume that if running on MacOS that the kubelet was cross-compiled,
        -- therefore, the path to the binaries is different.
        return "${env:HOME}/go/src/k8s.io/kubernetes/_output/local/go/src/k8s.io/kubernetes"
      end

      -- Documents to read to configure nvim-dap:
      --
      -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
      -- https://github.com/go-delve/delve/tree/master/Documentation/api/dap
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug test", -- configuration for debugging test files
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        -- works with go.mod packages and sub packages
        {
          type = "go",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
        -- debug my kubernetes-playground project
        {
          type = "go",
          name = "Attach kubernetes playground (remote)",
          debugAdapter = "dlv-dap",
          request = "attach",
          mode = "remote",
          host = "127.0.0.1",
          port = "56268",
          stopOnEntry = false,
          substitutePath = {
            {
              from = "${workspaceFolder}",
              to = "/go/src/github.com/mauriciopoppe/kubernetes-playground",
            },
          },
        },
        -- debug kube-controller-manager binary
        {
          type = "go",
          name = "Debug kube-controller-manager (local)",
          request = "launch",
          mode = "exec",
          program = "./_output/bin/kube-controller-manager",
          args = {
            "--kubeconfig=/Users/mauriciopoppe/.kube/config",
            "--leader-elect=false",
            "--controllers=*",
          },
          stopOnEntry = false,
          substitutePath = {
            {
              from = "${workspaceFolder}",
              to = kubernetes_path(),
            },
          },
        },
        {
          type = "go",
          name = "Attach to kubelet (remote)",
          debugAdapter = "dlv-dap",
          request = "attach",
          mode = "remote",
          host = "127.0.0.1",
          port = "56268",
          stopOnEntry = false,
          -- I started the kubelet in kind through dlv listening on port 56268
          -- next I connected to it through `dlv connect :56268`
          -- inside it I run `sources` and it printed the list of files in the kubelet
          -- together with the right path, later I added this path to the substitutePath
          -- option in the config below
          substitutePath = {
            {
              from = "${workspaceFolder}",
              to = kubernetes_path(),
            },
          },
        },
        -- To run a remote debug session, you need to run the following command:
        --
        -- dlv --listen :38697 --accept-multiclient --api-version=2 --headless \
        --   exec ./_output/bin/kube-controller-manager -- \
        --   --kubeconfig=${HOME}/.kube/config --leader-elect=false --controllers="*"
        {
          type = "go",
          name = "Attach to kube-controller-manager (remote)",
          debugAdapter = "dlv-dap",
          request = "attach",
          mode = "remote",
          host = "127.0.0.1",
          port = "38697",
          stopOnEntry = false,
          substitutePath = {
            {
              from = "${workspaceFolder}",
              to = "${env:HOME}/go/src/k8s.io/kubernetes/_output/local/go/src/k8s.io/kubernetes",
            },
          },
        },
      }
      -- Requires cpptools to be installed by Mason
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7", -- if you use mason
      }
      dap.configurations.c = {
        -- Start the kernel in qemu with the -s -S flags to enable debugging.
        {
          name = "Attach to QEMU (GDB Remote)",
          type = "cppdbg",
          request = "launch",
          program = "${workspaceFolder}/vmlinux",
          miDebuggerPath = "gdb",
          miDebuggerServerAddress = "localhost:1234",
          cwd = "${workspaceFolder}",
          targetArchitecture = "arm64",
          stopAtEntry = false,
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "enable pretty printing",
              ignoreFailures = false,
            },
            {
              text = "file /home/mauriciopoppe.linux/linux/kernel/vmlinux",
              description = "load kernel symbols",
              ignoreFailures = false,
            },
            {
              text = "set architecture aarch64",
              description = "Set target architecture",
              ignoreFailures = false,
            },
            {
              text = "source /home/mauriciopoppe.linux/linux/kernel/scripts/gdb/vmlinux-gdb.py",
              description = "Load kernel GDB helper scripts",
              ignoreFailures = false,
            },
          },
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    -- stylua: ignore
    keys = {
      { "<leader>bc", function() require("dap").continue() end, },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      local function c(func, opts)
        return function()
          func(opts)
        end
      end

      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<space>", "<2-LeftMouse>", "o" },
          open = "O",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        expand_lines = true,
        -- Layouts define sections of the screen to place windows.
        -- The position can be "left", "right", "top" or "bottom".
        -- The size specifies the height/width depending on position. It can be an Int
        -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
        -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
        -- Elements are the elements shown in the layout (in order).
        -- Layouts are opened in order so that earlier layouts take priority in window sizing.
        layouts = {
          {
            -- You can change the order of elements in the sidebar
            elements = {
              -- Provide as ID strings or tables with "id" and "size" keys
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left", -- Can be "left", "right", "top", "bottom"
          },
          {
            elements = {
              "repl",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
          },
        },
        controls = {
          -- Requires Neovim nightly (or 0.8 when released)
          enabled = true,
          -- Display controls in this element
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
          },
        },
      })

      -- dap.listeners.after.event_initialized["dapui_config"] = function()
      --   -- using schedule gives an error
      --   dap_preview_scopes()
      -- end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end

      dap.listeners.after.event_initialized["dapui_config"] = c(dapui.open)
      dap.listeners.after.event_loadedSource["dapui_config"] = c(dapui.open)
      dap.listeners.after.event_exited["dapui_config"] = c(dapui.close)

      vim.keymap.set("v", "<leader>be", function()
        dapui.eval(nil, { enter = true })
      end)
    end,
  },
  -- mason.nvim integration
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,
      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},
      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
      -- stylua: ignore
      keys = {
        { "<leader>bPt", function() require('dap-python').test_method() end, desc = "Debug Method" },
        { "<leader>bPc", function() require('dap-python').test_class() end, desc = "Debug Class" },
      },
    config = function()
      local path = vim.fn.exepath("debugpy")
      require("dap-python").setup(path .. "/venv/bin/python")
    end,
  },
}
