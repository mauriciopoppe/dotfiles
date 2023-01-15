lua << EOF

local dap = require "dap"
local dapui = require "dapui"
local keymap = vim.keymap.set

dap.set_log_level('TRACE')

local function c(func, opts)
    return function()
        func(opts)
    end
end

-- preview window under cursor
keymap('n', '<Leader>bp', function()
  opts = { width = 200, height = 15, enter = true, }
  dapui.float_element("scopes", opts)
end)

keymap("n", "<leader>b.", c(dap.run_to_cursor))
keymap("n", "<leader>bJ", c(dap.down))
keymap("n", "<leader>bK", c(dap.up))
keymap("n", "<leader>bL", function()
    dap.list_breakpoints()
    vim.cmd.copen()
end)
keymap("n", "<leader>bX", function()
    dap.terminate()
    dapui.close()
end)
keymap("n", "<leader>ba", c(dap.toggle_breakpoint))
keymap("n", "<leader>bc", c(dap.continue))
keymap("n", "<leader>bj", c(dap.step_into))
keymap("n", "<leader>bk", c(dap.step_out))
keymap("n", "<leader>bl", c(dap.step_over))
keymap("n", "<leader>br", c(dap.run_last))
keymap("n", "<leader>bx", c(dap.clear_breakpoints))

keymap("v", "<M-e>", c(dapui.eval))

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "WarningMsg" })
vim.fn.sign_define("DapStopped", { text = "▶", linehl = "CursorLine" })

dap.listeners.after.event_initialized["dap_debug_mappings"] = function()
  vim.keymap.set("n", "H", c(dap.continue))
  vim.keymap.set("n", "J", c(dap.step_into))
  vim.keymap.set("n", "K", c(dap.step_out))
  vim.keymap.set("n", "L", c(dap.step_over))
end
dap.listeners.after.event_exited["dap_debug_mappings"] = function()
  vim.keymap.del('n', "H")
  vim.keymap.del('n', "J")
  vim.keymap.del('n', "K")
  vim.keymap.del('n', "L")
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
      stdio = {nil, stdout, stderr},
      -- To enable debugging:
      -- - Uncomment the following line
      -- args = {"dap", "-l", addr, "--log", "debug", "--log-output", "dap", "--log-dest", "/tmp/dap.log"},
      -- - Check ~/.cache/nvim/dap.log (I saw set breakpoint errors here)
      args = {"dap", "-l", addr},
      detached = true
    }
    print(config)
    print(opts)

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

-- Documents to read to configure nvim-dap:
--
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
-- https://github.com/go-delve/delve/tree/master/Documentation/api/dap
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "go",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
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
          to = "/Users/mauriciopoppe/go/src/k8s.io/kubernetes/_output/local/go/src/k8s.io/kubernetes",
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
    name = "Attach kube-controller-manager (remote)",
    debugAdapter = "dlv-dap",
    request = "attach",
    mode = "remote",
    host = "127.0.0.1",
    port = "38697",
    stopOnEntry = false,
    substitutePath = {
      {
          from = "${workspaceFolder}",
          to = "/Users/mauriciopoppe/go/src/k8s.io/kubernetes/_output/local/go/src/k8s.io/kubernetes",
      },
    },
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
--  {
--    type = "go",
--    name = "Debug connect",
--    request = "attach",
--    mode = "remote",
--    port = "56268",
--    apiVersion = "2",
--    showLog = "true",
--    substitutePath = {
--      {
--          from = "${workspaceFolder}",
--          to = "/",
--      },
--    },
--  }
}

EOF
