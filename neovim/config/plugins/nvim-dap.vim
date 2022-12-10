lua << EOF

local deps_ok, dapui, dapui_widgets, dap = pcall(function()
    return require "dapui", require "dap.ui.widgets", require "dap"
end)

local dap = require "dap"
local keymap = vim.keymap.set

dap.set_log_level('TRACE')

local function c(func, opts)
    return function()
        func(opts)
    end
end

keymap('n', '<leader>db', c(dap.toggle_breakpoint))

keymap("n", "<leader>d.", c(dap.run_to_cursor))
keymap("n", "<leader>dJ", c(dap.down))
keymap("n", "<leader>dK", c(dap.up))
keymap("n", "<leader>dL", function()
    dap.list_breakpoints()
    vim.cmd.copen()
end)
keymap("n", "<leader>dX", function()
    dap.terminate()
    dapui.close()
end)
keymap("n", "<leader>da", c(dap.toggle_breakpoint))
keymap("n", "<leader>dc", c(dap.continue))
keymap("n", "<leader>dh", c(dap.step_back))
keymap("n", "<leader>dj", c(dap.step_into))
keymap("n", "<leader>dk", c(dap.step_out))
keymap("n", "<leader>dl", c(dap.step_over))
keymap("n", "<leader>dr", c(dap.run_last))
keymap("n", "<leader>dx", c(dap.clear_breakpoints))

keymap("v", "<M-e>", c(dapui.eval))
keymap("n", "<leader>d?", c(dapui_widgets.hover))

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "WarningMsg" })
vim.fn.sign_define("DapStopped", { text = "▶", linehl = "CursorLine" })

dap.adapters.go = function(callback, config)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = config["port"] or 38697
  local opts = {
    stdio = {nil, stdout},
    args = {"dap", "-l", "127.0.0.1:" .. port, "--log", "--log-output=dap"},
    detached = true
  }
  if config["request"] == "launch" then
    -- opts["args"] = {"connect", "--allow-non-terminal-interactive", "127.0.0.1:" .. config["port"]}
    -- print(vim.inspect(opts))
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        print('dlv exited with code', code)
      end
    end)
    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require('dap.repl').append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(
      function()
        callback({type = "server", host = "127.0.0.1", port = port})
      end,
    100)
  else
    -- server is already up in remote mode (still needs to be deferred to avoid errors :()
    vim.defer_fn(
      function()
        callback({type = "server", host = "127.0.0.1", port = port})
      end,
    100)
  end
end

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
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
  -- debug remote process
  {
    type = "go",
    name = "Debug kubernetes playground (remote)",
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
