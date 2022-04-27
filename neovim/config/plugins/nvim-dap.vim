lua << EOF
local dap = require "dap"

dap.set_log_level('TRACE')

function _G.dap_toggle_breakpoint()
  dap.toggle_breakpoint()
end
vim.api.nvim_set_keymap('n', '<Leader>bb', ':lua dap_toggle_breakpoint()<CR>', { noremap = true, silent = true })

function _G.dap_continue()
  dap.continue()
end
vim.api.nvim_set_keymap('n', '<Leader>br', ':lua dap_continue()<CR>', { noremap = true, silent = true })

-- nnoremap <leader>w :<C-u>call DebuggerStepInto()<CR>
-- nnoremap <leader>W :<C-u>call DebuggerStepOut()<CR>
-- nnoremap <leader>e :<C-u>call DebuggerStepOver()<CR>

vim.api.nvim_set_keymap('n', '<Leader>w', ':lua require("dap").step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>W', ':lua require("dap").step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>e', ':lua require("dap").step_over()<CR>', { noremap = true, silent = true })

dap.adapters.go = function(callback, config)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = config["port"] or 38697
  local opts = {
    stdio = {nil, stdout},
    args = {"dap", "-l", "127.0.0.1:" .. port},
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
    name = "Debug remote",
    debugAdapter = "dlv-dap",
    request = "attach",
    mode = "remote",
    host = "127.0.0.1",
    port = "56268",
    stopOnEntry = false,
    -- substitutePath = {
    --   {
    --       from = "${workspaceFolder}",
    --       to = "/go/src/github.com/mauriciopoppe/kubernetes-playground",
    --   },
    -- },
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
