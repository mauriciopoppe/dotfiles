local Utils = require("my/utils")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      -- custom command palette
      "FeiyouG/command_center.nvim",
      -- vim bookmarks loader
      "tom-anders/telescope-vim-bookmarks.nvim",
    },
    branch = "0.1.x",
    keys = {
      -- Mappings for a better UI
      { "[ui]f", ":<C-u>Telescope live_grep<CR>", silent = true, desc = "[F]ind files" },
      { "[ui]b", ":<C-u>Telescope buffers<CR>", silent = true, desc = "[B]uffers" },
      { "[ui]o", ":<C-u>Telescope find_files<CR>", silent = true, desc = "[O]pen files" },
      { "[ui]r", ":<C-u>Telescope resume<CR>", silent = true, desc = "[R]esume" },
      { "[ui]l", ":<C-u>Telescope current_buffer_fuzzy_find<CR>", silent = true, desc = "Find in [L]ine" },
      { "[ui]p", ":<C-u>Telescope command_center<CR>", silent = true, desc = "Command [P]alette" },
      { "[ui]w", ":<C-u>Telescope grep_string<CR>", silent = true, desc = "Search with [W]ord" },
      { "[ui]q", ":<C-u>Telescope quickfix<CR>", silent = true, desc = "[Q]uickfix" },
      { "[ui]m", ":<C-u>Telescope vim_bookmarks all<CR>", silent = true, desc = "Book[m]arks"},
      -- Mappings to navigate on the code
      { "<leader>a", ":<C-u>Telescope lsp_code_actions<CR>", silent = true, desc = "LSP code [a]ctions"},
      { "<leader>d", ":<C-u>Telescope lsp_definitions<CR>", silent = true, desc = "LSP [d]efinitions" },
      { "<leader>t", ":<C-u>Telescope lsp_type_definitions<CR>", silent = true, desc = "LSP [t]ype definitions" },
      { "<leader>i", ":<C-u>Telescope lsp_implementations<CR>", silent = true, desc = "LSP [i]mplementations" },
      { "<leader>r", ":<C-u>Telescope lsp_references<CR>", silent = true, desc = "LSP [r]eferences" },
      { "<leader>ci", ":<C-u>Telescope lsp_incoming_calls<CR>", silent = true, desc = "LSP incoming calls [ci]" },
      { "<leader>co", ":<C-u>Telescope lsp_outgoing_calls<CR>", silent = true, desc = "LSP outgoing calls [co]" },
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

      -- Custom actions
      local command_center = require('command_center')
      command_center.add({
        {
          desc = "Copy absolute path",
          cmd = function() vim.api.nvim_exec('let @" = expand("%:p") | execute \'OSCYankReg "\'', true) end,
        },
        {
          desc = "Copy relative path",
          cmd = function() vim.api.nvim_exec('let @" = expand("%") | execute \'OSCYankReg "\'', true) end,
        },
        {
          desc = "Copy filename only",
          cmd = function() vim.api.nvim_exec('let @" = expand("%:t") | execute \'OSCYankReg "\'', true) end,
        },
      }, {
        mode = command_center.mode.ADD,
      })

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
        }
      }

      require('telescope').load_extension('command_center')
      require('telescope').load_extension('vim_bookmarks')

    end
  }
}
