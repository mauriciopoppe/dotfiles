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
    branch = "v3.x",
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
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show_by_pattern = {
              -- kernel ignores
              "*.a",
              "*.a.cmd",
              "*.o",
              "*.o.*",
              "*modules.order*",
            },
          },
          use_libuv_file_watcher = true,
        },
        window = {
          mappings = {
            ["e"] = edit_and_close_sidebar,
            ["o"] = edit_and_close_sidebar,
            ["h"] = "close_node", -- override
            ["l"] = "open", -- override
            -- ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
            -- ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
          },
        },
      })
    end,
  },
}
