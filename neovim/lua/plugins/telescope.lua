local utils = require("my.utils")

return {
  {
    "tom-anders/telescope-vim-bookmarks.nvim",
    lazy = true,
    dependencies = { "MattesGroeger/vim-bookmarks" },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      -- custom command palette
      "FeiyouG/commander.nvim",
      -- vim bookmarks loader
      "tom-anders/telescope-vim-bookmarks.nvim",
      -- recent files
      "smartpde/telescope-recent-files",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
    },
    branch = "0.1.x",
    -- stylua: ignore start
    keys = {
      -- Mappings for a better UI
      { "[ui]f", ":<C-u>Telescope live_grep<CR>", silent = true, desc = "[F]ind files" },
      { "[ui]g", ":<C-u>Telescope git_status<CR>", silent = true, desc = "[G]it status" },
      { "[ui]o", ":<C-u>Telescope find_files<CR>", silent = true, desc = "[O]pen files" },
      { "[ui]r", ":<C-u>Telescope resume<CR>", silent = true, desc = "[R]esume" },
      { "[ui]l", ":<C-u>Telescope current_buffer_fuzzy_find<CR>", silent = true, desc = "Find in [L]ine" },
      { "[ui]p", ":<C-u>Telescope commander<CR>", silent = true, desc = "Command [P]alette" },
      { "[ui]w", ":<C-u>Telescope grep_string<CR>", silent = true, desc = "Search with [W]ord" },
      { "[ui]q", ":<C-u>Telescope quickfix<CR>", silent = true, desc = "[Q]uickfix" },
      { "[ui]m", ":<C-u>Telescope vim_bookmarks all<CR>", silent = true, desc = "Book[m]arks" },
      { "[ui]b", [[<cmd>lua  require('telescope').extensions.recent_files.pick()<CR>]], silent = true, desc = "[B] Recent Files", },
      -- Mappings to navigate on the code
      { "<leader>a", ":<C-u>Telescope lsp_code_actions<CR>", silent = true, desc = "LSP code [a]ctions" },
      { "<leader>d", ":<C-u>Telescope lsp_definitions<CR>", silent = true, desc = "LSP [d]efinitions" },
      { "<leader>t", ":<C-u>Telescope lsp_type_definitions<CR>", silent = true, desc = "LSP [t]ype definitions" },
      { "<leader>i", ":<C-u>Telescope lsp_implementations<CR>", silent = true, desc = "LSP [i]mplementations" },
      { "<leader>r", ":<C-u>Telescope lsp_references<CR>", silent = true, desc = "LSP [r]eferences" },
      { "<leader>ci", ":<C-u>Telescope lsp_incoming_calls<CR>", silent = true, desc = "LSP incoming calls [ci]" },
      { "<leader>co", ":<C-u>Telescope lsp_outgoing_calls<CR>", silent = true, desc = "LSP outgoing calls [co]" },
      { "<leader>cr", function() require("telescope").extensions.refactoring.refactors() end, silent = true, desc = "Refactor", mode = { "n", "x" }, },
    },
    -- stylua: ignore end
    config = function()
      local actions = require("telescope.actions")
      local split_vertical_theme = {
        theme = "dropdown",
        -- option to set the filename width, this is useful for long go filenames
        -- ref https://github.com/nvim-telescope/telescope.nvim/blob/203bf5609137600d73e8ed82703d6b0e320a5f36/lua/telescope/make_entry.lua#L456
        fname_width = 60,
        layout_config = {
          preview_cutoff = 5,
          width = function(_, max_columns, _)
            return math.min(max_columns, math.floor(vim.fn.winwidth(0) * 0.8))
          end,
          height = function(_, _, max_lines)
            return math.min(max_lines, math.floor(vim.fn.winheight(0) * 0.5))
          end,
        },
      }

      local function with_path(expansion)
        return function()
          require("osc52").copy(vim.fn.expand(expansion))
        end
      end

      -- Custom actions
      local commander = require("commander")
      commander.add({
        { desc = "Copy absolute path", cmd = with_path("%:p") },
        { desc = "Copy relative path", cmd = with_path("%:.") },
        { desc = "Copy filename only", cmd = with_path("%:t") },
        {
          desc = "Copy line with github sha",
          cmd = function()
            local permalink = utils.get_github_permalink_at_current_line()
            require("osc52").copy(permalink)
          end,
        },
      }, {
        show = true,
      })
      commander.setup({
        integration = {
          telescope = {
            enable = true,
          },
        },
      })

      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-c>"] = actions.close,
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
          recent_files = {
            only_cwd = true,
          },
        },
      })

      require("telescope").load_extension("vim_bookmarks")
      require("telescope").load_extension("recent_files")
      require("telescope").load_extension("refactoring")
      require("telescope").load_extension("fzf")
    end,
  },
}
