return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- " treesitter objects
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- header line that gives context
      "nvim-treesitter/nvim-treesitter-context",
      -- nested language aware commenting
      "JoosepAlviste/nvim-ts-context-commentstring",
      -- refactoring plugin
      "ThePrimeagen/refactoring.nvim",
    },
    build = ":TSUpdate",
    event = "VeryLazy",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
      -- Identifies zsh as bash.
      -- https://github.com/nvim-treesitter/nvim-treesitter/issues/655#issuecomment-1021160477
      local ft_to_lang = require("nvim-treesitter.parsers").ft_to_lang
      require("nvim-treesitter.parsers").ft_to_lang = function(ft)
        if ft == "zsh" then
          return "bash"
        end
        return ft_to_lang(ft)
      end

      -- show context when scrolling
      require("treesitter-context").setup({
        -- Avoid the sticky context from growing a lot.
        max_lines = 3,
        -- Match the context lines to the source code.
        multiline_threshold = 1,
        -- Disable it when the window is too small.
        min_window_height = 20,
      })

      require("nvim-treesitter.configs").setup({
        -- stylua: ignore
        ensure_installed = {
          "bash", "c", "cpp", "css", "cmake", "dockerfile", "go", "gomod", "hcl", "html",
          "javascript", "json", "lua", "make", "markdown", "python", "rust", "scss", "typescript", "tsx", "vim", "yaml"
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "gni",
          },
        },
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ae"] = "@function.outer",
              ["ie"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },

          -- swap = {
          --   enable = false,
          --   swap_next = {
          --     ["<leader>sn"] = "@parameter.inner",
          --   },
          --   swap_previous = {
          --     ["<leader>sp"] = "@parameter.inner",
          --   },
          -- },
        },
      })

      vim.cmd([[
        set foldmethod=expr
        setlocal foldlevelstart=99
        set foldexpr=nvim_treesitter#foldexpr()
      ]])
    end,
  },
}
