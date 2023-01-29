return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      -- custom command palette
      "LinArcX/telescope-command-palette.nvim",
      -- vim bookmarks loader
      "tom-anders/telescope-vim-bookmarks.nvim",
    },
    branch = "0.1.x",
    keys = {
      { "[ui]f", ":<C-u>Telescope live_grep<CR>", desc = "[F]ind files" },
      { "[ui]b", ":<C-u>Telescope buffers<CR>", desc = "[B]uffers" },
      { "[ui]o", ":<C-u>Telescope find_files<CR>", desc = "[O]pen files" },
      { "[ui]r", ":<C-u>Telescope resume<CR>", desc = "[R]esume" },
      { "[ui]l", ":<C-u>Telescope current_buffer_fuzzy_find<CR>", desc = "Find in [L]ine" },
      { "[ui]p", ":<C-u>Telescope command_palette<CR>", desc = "Command [P]alette" },
      { "[ui]w", ":<C-u>Telescope grep_string<CR>", desc = "Search with [W]ord" },
      { "[ui]q", ":<C-u>Telescope quickfix<CR>", desc = "[Q]uickfix" },
      { "[ui]m", ":<C-u>Telescope vim_bookmarks all<CR>", desc = "Book[m]arks"},
      { "<leader>a", ":<C-u>Telescope lsp_code_actions<CR>", desc = "LSP code [a]ctions"},
      { "<leader>d", ":<C-u>Telescope lsp_definitions<CR>", desc = "LSP [d]efinitions" },
      { "<leader>t", ":<C-u>Telescope lsp_type_definitions<CR>", desc = "LSP [t]ype definitions" },
      { "<leader>i", ":<C-u>Telescope lsp_implementations<CR>", desc = "LSP [i]mplementations" },
      { "<leader>r", ":<C-u>Telescope lsp_references<CR>", desc = "LSP [r]eferences" },
      { "<leader>ci", ":<C-u>Telescope lsp_incoming_calls<CR>", desc = "LSP incoming calls [ci]" },
      { "<leader>co", ":<C-u>Telescope lsp_outgoing_calls<CR>", desc = "LSP outgoing calls [co]" },
    },
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
  end
}
}
