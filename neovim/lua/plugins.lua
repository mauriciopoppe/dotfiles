return {
  -- lua utility functions
  "nvim-lua/plenary.nvim",

  --
  {
    "jcdickinson/codeium.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    cond = function()
      -- enable only if running in my personal laptop
      local is_local_env = string.match(vim.fn.system("uname -a"), "Darwin.*Mauricio.*arm")
      return is_local_env ~= nil
    end
  },

  -- signs for navigation (also supports hg)
  {
    "mhinz/vim-signify",
    config = function()
      vim.g.signify_vcs_cmds_diffmode = {
        hg = 'hg cat %f -r p4base',
      }
    end
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    },
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
  },

  -- buffers tabline
  "ap/vim-buftabline",

  -- search and replace
  {
    "windwp/nvim-spectre",
    keys = {
      { "[ui]s", function() require("spectre").open() end, desc = "Search & replace" }
    },
    config = function()
      local spectre = require('spectre')
      spectre.setup()
    end
  },

  -- " indent guides
  {
    "nathanaelkane/vim-indent-guides",
    keys = {
      { "<Leader>ti", ":<C-u>IndentGuidesToggle<CR>", desc = "Toggle indent guides" }
    },
    config = function ()
    end
  },

  -- improve core UI elements
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- themes
  "kristijanhusak/vim-hybrid-material",
  "w0ng/vim-hybrid",
  "lifepillar/vim-solarized8",

  -- navigate to any visible part
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
    end
  },

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } } },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
    end,
  },

  -- tmux navigation
  "christoomey/vim-tmux-navigator",
  -- better motion
  {
    "bkad/CamelCaseMotion",
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
    end
  },
  -- undo tree
  "mbbill/undotree",
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
    end
  },

  -- toggle bookmarks per line, use telescope to find them
  "MattesGroeger/vim-bookmarks",

  {
    "ojroques/vim-oscyank",
    config = function()
      vim.g.oscyank_term = 'default'
      vim.cmd([[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif]])
    end
  },

  -- run commands in a tmux split
  {
    "benmills/vimux",
    keys = {
      { "<leader>tp", "<cmd>VimuxPromptCommand<cr>", desc = "Vimux prompt command" },
      { "<leader>tl", "<cmd>VimuxRunLastCommand<cr>", desc = "Vimux last command" },
    },
  },

  -- highlight ocurrences of the current word
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
    config = function()
      require("illuminate").configure({ delay = 200 })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          pcall(vim.keymap.del, "n", "]]", { buffer = buffer })
          pcall(vim.keymap.del, "n", "[[", { buffer = buffer })
        end,
      })
    end,
  },

  -- auto close (, [, {, ', \", `
  "jiangmiao/auto-pairs",

  -- alignment
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.cmd([[
      " Start interactive EasyAlign in visual mode (e.g. vipga)
      xmap ga <Plug>(EasyAlign)
      " Start interactive EasyAlign for a motion/text object (e.g. gaip)
      nmap ga <Plug>(EasyAlign)
      ]])
    end
  },

  -- multiple cursors (<C-n><C-p><C-x>)
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy"
  },

  -- commenting stuff
  {
    "tpope/vim-commentary",
    config = function()
      vim.cmd([[
      xmap gc  <Plug>Commentary
      nmap gc  <Plug>Commentary
      omap gc  <Plug>Commentary
      nmap gcc <Plug>CommentaryLine
      ]])
    end
  },
  -- . improved
  "tpope/vim-repeat",
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",
  -- change/delete surrounding characters
  {
    "kylechui/nvim-surround",
    config = function ()
      require("nvim-surround").setup()
    end,
  },

  -- autoformat for some types
  {
    "prettier/vim-prettier",
    ft = {
      'javascript', 'typescript', 'css', 'less', 'scss', 'json',
      'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'
    },
    config = function ()
      vim.g["prettier#autoformat"] = 1
      vim.g["prettier#autoformat_require_pragma"] = 0
    end
  },
  {
    "pangloss/vim-javascript",
    ft = { "javascript", "typescript" }
  },

  {
    "rhysd/vim-gfm-syntax",
    config = function()
      vim.g.gfm_syntax_enable_always = 0
      vim.g.gfm_syntax_highlight_emoji = 0
      vim.g.gfm_syntax_enable_filetypes = {'markdown'}
    end
  },

  -- go setup
  {
    "ray-x/go.nvim",
    ft = { "go" },
    config = function ()
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function () require("go.format").goimport() end,
      })
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "go",
        callback = function ()
          vim.keymap.set("n", "<leader>k", ":<C-u>GoDoc<CR>", { silent = true })
        end,
      })
      require('go').setup()
    end
  },
  --
  {

    "AndrewRadev/splitjoin.vim",
    config = function ()
      vim.g.splitjoin_split_mapping = ''
      vim.g.splitjoin_join_mapping = ''
    end
  },

  -- editorconfig
  "gpanders/editorconfig.nvim",

  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  }
}

