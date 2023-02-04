return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "mrbjarksen/neo-tree-diagnostics.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "[ui]e", ":Neotree toggle<CR>", silent = true },
      { "[ui]a", ":Neotree reveal<CR>", silent = true },
      { "[ui]x", ":Neotree diagnostics toggle bottom<CR>", silent = true },
    },
    branch = "v2.x",
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    config = function()
      local neotree = require("neo-tree.command.init")
      local cc = require("neo-tree.sources.filesystem.commands")

      -- edit_and_close_sidebar edits edits a file and closes the sidebar.
      local edit_and_close_sidebar = function(state)
        cc.open(state)
        neotree.execute({ action = "close" })
      end

      require("neo-tree").setup({
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
        window = {
          mappings = {
            ["e"] = edit_and_close_sidebar,
            ["o"] = edit_and_close_sidebar,
            ["h"] = "close_node", -- override
            ["l"] = "open", -- override
          },
        },
      })
    end,
  },
}
