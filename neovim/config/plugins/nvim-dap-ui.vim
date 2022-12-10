lua << EOF

local dap, dapui = require("dap"), require("dapui")

local keymap = vim.keymap.set
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
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7") == 1,
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
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
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

-- preview window under cursor
keymap('n', '<Leader>dp', function()
  opts = {
    width = 200,
    height = 15,
    enter = true,
  }
  dapui.float_element("scopes", opts)
end)

-- eval visually highlighted word
-- vim.api.nvim_set_keymap('v', '<M-k>', ':lua require("dapui").eval()<CR>', { noremap = true, silent = true })

EOF
