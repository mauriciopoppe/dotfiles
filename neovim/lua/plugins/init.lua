return {
  -- Load LazyVim without any bundled plugin.
  --
  -- The steps I did are:
  -- * Don't add { "LazyVim/LazyVim", import = "lazyvim.plugins" } to neovim/init.lua
  -- * Load LazyVim with priority on this file.
  -- * Where needed, set the `var LazyVim = require("lazyvim.util")`
  { "LazyVim/LazyVim", priority = 10000, lazy = false, opts = {}, cond = true, version = "*" },
  {
    "LazyVim/LazyVim",
    dependencies = {
      { "w0ng/vim-hybrid" },
      { "mauriciopoppe/inspired-github.vim" },
      { "maxmx03/solarized.nvim" },
      { "projekt0n/github-nvim-theme" },
    },
    opts = {
      defaults = {
        keymaps = false,
        autocmds = false,
      },
      news = {
        lazyvim = false,
      },
      colorscheme = function()
        require("my.config.theme").setup()
      end,
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
    config = function(_, opts)
      local notify = vim.notify
      local LazyVim = require("lazyvim.util")
      require("snacks").setup(opts)

      -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
      -- this is needed to have early notifications show up in noice history
      if LazyVim.has("noice.nvim") then
        vim.notify = notify
      end
    end,
  },

  -- lua utility functions
  { "nvim-lua/plenary.nvim", lazy = true },

  -- " indent guides
  {
    "nathanaelkane/vim-indent-guides",
    keys = {
      { "<Leader>ti", ":<C-u>IndentGuidesToggle<CR>", desc = "Toggle indent guides" },
    },
    config = function() end,
  },

  -- tmux navigation
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- {
  --   "fresh2dev/zellij.vim",
  --   lazy = false,
  --   init = function()
  --     -- Options:
  --     -- vim.g.zelli_navigator_move_focus_or_tab = 1
  --     -- vim.g.zellij_navigator_no_default_mappings = 1
  --   end,
  -- },

  -- better motion
  {
    "bkad/CamelCaseMotion",
    event = "VeryLazy",
    config = function()
      vim.cmd([[
      nmap <silent> e <Plug>CamelCaseMotion_e
      xmap <silent> e <Plug>CamelCaseMotion_e
      omap <silent> e <Plug>CamelCaseMotion_e
      nmap <silent> w <Plug>CamelCaseMotion_w
      xmap <silent> w <Plug>CamelCaseMotion_w
      omap <silent> w <Plug>CamelCaseMotion_w
      nmap <silent> b <Plug>CamelCaseMotion_b
      xmap <silent> b <Plug>CamelCaseMotion_b
      omap <silent> b <Plug>CamelCaseMotion_b
      ]])
    end,
  },

  -- better vim mergetool, needs setup in git config too
  {
    "samoshkin/vim-mergetool",
    config = function()
      vim.cmd([[
      nmap <expr> <C-Left> &diff? '<Plug>(MergetoolDiffExchangeLeft)' : '<C-Left>'
      nmap <expr> <C-Right> &diff? '<Plug>(MergetoolDiffExchangeRight)' : '<C-Right>'
      nmap <expr> <C-Down> &diff? '<Plug>(MergetoolDiffExchangeDown)' : '<C-Down>'
      nmap <expr> <C-Up> &diff? '<Plug>(MergetoolDiffExchangeUp)' : '<C-Up>'
      ]])
    end,
  },

  -- run commands in a tmux split
  {
    "benmills/vimux",
    keys = {
      { "<leader>tp", "<cmd>VimuxPromptCommand<cr>", desc = "Vimux prompt command" },
      { "<leader>tl", "<cmd>VimuxRunLastCommand<cr>", desc = "Vimux last command" },
    },
  },

  -- highlight occurrences of the current word
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    -- stylua: ignore
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
  },

  -- alignment
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", ":<Plug>(EasyAlign) <CR>", desc = "Next Reference", mode = { "x", "n" } },
    },
    opts = {},
  },

  -- multiple cursors (<C-n><C-p><C-x>)
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },

  -- . improved
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- toggle bookmarks per line, use telescope to find them
  {
    "MattesGroeger/vim-bookmarks",
    keys = {
      { "mm", "<cmd>BookmarkToggle<cr>", desc = "Bookmark toggle" },
    },
    init = function()
      vim.g.bookmark_no_default_key_mappings = 1
    end,
  },

  -- change/delete surrounding characters
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- github flavored markdown syntax
  {
    "rhysd/vim-gfm-syntax",
    config = function()
      vim.g.gfm_syntax_enable_always = 0
      vim.g.gfm_syntax_highlight_emoji = 0
      vim.g.gfm_syntax_enable_filetypes = { "markdown" }
    end,
  },

  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {},
  },

  -- go setup
  {
    "ray-x/go.nvim",
    ft = { "go" },
    config = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
      })
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "go",
        callback = function()
          vim.keymap.set("n", "<leader>k", ":<C-u>GoDoc<CR>", { silent = true })
        end,
      })
      require("go").setup()
    end,
  },

  -- Split Join with J
  {
    "AndrewRadev/splitjoin.vim",
    config = function()
      vim.g.splitjoin_split_mapping = ""
      vim.g.splitjoin_join_mapping = ""
    end,
  },

  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session", },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session", },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session", },
    },
  },

  -- syntax highlight
  { "imsnif/kdl.vim" },
  { "mmarchini/bpftrace.vim" },
}
