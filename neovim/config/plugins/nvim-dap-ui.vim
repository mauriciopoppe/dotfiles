lua << EOF

local dap, dapui = require("dap"), require("dapui")

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>", "o" },
    open = "O",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      -- You can change the order of elements in the sidebar
      elements = {
        -- Provide as ID strings or tables with "id" and "size" keys
        {
          id = "scopes",
          size = 0.25, -- Can be float or integer > 1
        },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 00.25 },
      },
      size = 40,
      position = "left", -- Can be "left", "right", "top", "bottom"
    },
    {
      elements = { "repl" },
      size = 10,
      position = "bottom", -- Can be "left", "right", "top", "bottom"
    }
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})

function _G.dap_preview_scopes()
  opts = {
    width = 200,
    height = 15,
    enter = true,
  }
  dapui.float_element("scopes", opts)
end

-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   -- using schedule gives an error
--   dap_preview_scopes()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

-- preview window under cursor
vim.api.nvim_set_keymap('n', '<Leader>bp', ':lua dap_preview_scopes()<CR>', { noremap = true, silent = true })

-- eval visually highlighted word
vim.api.nvim_set_keymap('v', '<M-k>', ':lua require("dapui").eval()<CR>', { noremap = true, silent = true })

EOF
