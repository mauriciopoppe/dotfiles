return {
  -- custom command palette
  "LinArcX/telescope-command-palette.nvim",
  -- vim bookmarks loader
  "tom-anders/telescope-vim-bookmarks.nvim",
  {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  config = function()
local actions = require("telescope.actions")
local split_vertical_theme = {
  theme = "dropdown",
  layout_config = {
    preview_cutoff = 1,
    width = function(_, max_columns, _)
      return math.min(max_columns, 180)
    end,
    height = function(_, _, max_lines)
      return math.min(max_lines, 30)
    end,
  },
}
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
    },
    lsp_references = split_vertical_theme,
    lsp_implementations = split_vertical_theme,
  },
  extensions = {
    command_palette = {
      {"Vim",
        { "Copy absolute path", ":lua require'my/utils'.CopyAbsolutePathToClipboard()" },
        { "Copy relative path", ":lua require'my/utils'.CopyRelativePathToClipboard()" },
        { "Copy filename", ":lua require'my/utils'.CopyFilenameToClipboard()" },
      }
    }
  }
}

require('telescope').load_extension('command_palette')
require('telescope').load_extension('vim_bookmarks')

local builtin = require('telescope.builtin')

local keymap = vim.keymap.set
keymap("n", "[ui]f", ":<C-u>Telescope live_grep<CR>", { noremap = true, silent = true })
keymap("n", "[ui]b", ":<C-u>Telescope buffers<CR>", { noremap = true, silent = true })
keymap("n", "[ui]o", ":<C-u>Telescope find_files<CR>", { noremap = true, silent = true })
keymap("n", "[ui]r", ":<C-u>Telescope resume<CR>", { noremap = true, silent = true })
keymap("n", "[ui]l", ":<C-u>Telescope current_buffer_fuzzy_find<CR>", { noremap = true, silent = true })
keymap("n", "[ui]p", ":<C-u>Telescope command_palette<CR>", { noremap = true, silent = true })
keymap("n", "[ui]w", ":<C-u>Telescope grep_string<CR>", { noremap = true, silent = true })
keymap("n", "[ui]q", ":<C-u>Telescope quickfix<CR>", { noremap = true, silent = true })
keymap("n", "[ui]m", ":<C-u>Telescope vim_bookmarks all<CR>", { noremap = true, silent = true })

keymap("n", "<leader>a", ":<C-u>Telescope lsp_code_actions<CR>", { noremap = true, silent = true })
keymap("n", "<leader>d", ":<C-u>Telescope lsp_definitions<CR>", { noremap = true, silent = true })
keymap("n", "<leader>t", ":<C-u>Telescope lsp_type_definitions<CR>", { noremap = true, silent = true })
keymap("n", "<leader>i", ":<C-u>Telescope lsp_implementations<CR>", { noremap = true, silent = true })
keymap("n", "<leader>r", ":<C-u>Telescope lsp_references<CR>", { noremap = true, silent = true })
keymap("n", "<leader>ci", ":<C-u>Telescope lsp_incoming_calls<CR>", { noremap = true, silent = true })
keymap("n", "<leader>co", ":<C-u>Telescope lsp_outgoing_calls<CR>", { noremap = true, silent = true })

  end
}
}
