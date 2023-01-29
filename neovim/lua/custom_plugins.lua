return {
  -- lua utility functions
  "nvim-lua/plenary.nvim",
  -- lua UI library
  "MunifTanjim/nui.nvim",
  -- common confs for nvim-lsp
  "neovim/nvim-lspconfig",

  --
  "hrsh7th/cmp-nvim-lsp",
  --
  "hrsh7th/cmp-buffer",
  --
  "hrsh7th/cmp-path",
  --
  "hrsh7th/cmp-cmdline",
  --
  {
    "Exafunction/codeium.vim",
    config = function()
      vim.keymap.set('i', '<C-j>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
      vim.g.copilot_filetypes = {
        ['dap-repl'] = false,
      }
    end,
    enabled = function()
      -- don't enable at work
      local is_local_env = string.match(vim.fn.system("uname -a"), "Darwin.*Mauricio.*arm")
      return is_local_env ~= nil
    end
  },
  -- completion engine
  "hrsh7th/nvim-cmp",
  -- " completion icons
  "onsails/lspkind-nvim",

  -- " snippet engine
  "dcampos/nvim-snippy",
  -- snippet engine adapter for nvim-cmp
  "dcampos/cmp-snippy",
  -- snippet collection
  "honza/vim-snippets",

  --
  "nvim-treesitter/nvim-treesitter",
  -- " treesitter objects
  "nvim-treesitter/nvim-treesitter-textobjects",
  -- header line that gives context
  "nvim-treesitter/nvim-treesitter-context",
  --
  "JoosepAlviste/nvim-ts-context-commentstring",
  --
  {
    "lewis6991/spellsitter.nvim",
    config = function ()
      require("spellsitter").setup()
    end
  },

  --
  "kyazdani42/nvim-web-devicons",
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
  },
  --
  "mrbjarksen/neo-tree-diagnostics.nvim",
  -- signs for navigation (also supports hg)
  {
    "mhinz/vim-signify",
    config = function()
      vim.g.signify_vcs_cmds_diffmode = {
        hg = 'hg cat %f -r p4base',
      }
    end
  },

  -- " statusline
  "nvim-lualine/lualine.nvim",
  -- buffers tabline
  "ap/vim-buftabline",
  -- right sidebaf for navigation
  "preservim/tagbar",
  -- search and replace
  {
    "windwp/nvim-spectre",
    config = function()
      local spectre = require('spectre')
      spectre.setup()
      vim.keymap.set('n', '[ui]s', spectre.open)
    end
  },

  -- overlay for navigation
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
  },
  -- custom command palette
  "LinArcX/telescope-command-palette.nvim",
  -- vim bookmarks loader
  "tom-anders/telescope-vim-bookmarks.nvim",

  -- debugger
  "mfussenegger/nvim-dap",
  -- debugger ui
  "rcarriga/nvim-dap-ui",
  -- " debugger virtual text
  "theHamsta/nvim-dap-virtual-text",

  -- " indent guides
  {
    "nathanaelkane/vim-indent-guides",
    config = function ()
      vim.keymap.set('n', '<Leader>ti', ':<C-u>IndentGuidesToggle<CR>', { silent = true })
    end
  },
  --
  "kristijanhusak/vim-hybrid-material",
  --
  "w0ng/vim-hybrid",
  --
  "lifepillar/vim-solarized8",

  -- navigate to any visible part
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
    end
  },
  -- f/F/t/T navigation
  {
    "ggandor/flit.nvim",
    config = function()
      require('flit').setup {
        keys = { f = 'f', F = 'F', t = 't', T = 'T' },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "v",
        multiline = true,
        -- Like `leap`s similar argument (call-specific overrides).
        -- E.g.: opts = { equivalence_classes = {} }
        opts = {}
      }
    end
  },
  -- additional mappings
  "tpope/vim-unimpaired",
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
  --, { 'branch': 'main' }  " clipboard over ssh through tmux
  {
    "ojroques/vim-oscyank",
    config = function()
      vim.g.oscyank_term = 'default'
      vim.cmd([[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif]])
    end
  },
  -- git wrapper
  {
    "tpope/vim-fugitive",
    config = function()
      vim.cmd([[
      nnoremap <silent> <leader>gs :Git status<CR>
      nnoremap <silent> <leader>gd :Git diff<CR>
      nnoremap <silent> <leader>gD :Git diffoff<CR>
      nnoremap <silent> <leader>gc :Git commit<CR>
      nnoremap <silent> <leader>gb :Git blame<CR>
      nnoremap <silent> <leader>gB :Git browse<CR>
      nnoremap <silent> <leader>gp :Git push<CR>
      ]])
    end
  },
  -- run commands in a tmux split
  {
    "benmills/vimux",
    config = function()
      vim.cmd([[
      " Executes a command in a tmux split, if there's one available run it there
      noremap <Leader>tp :VimuxPromptCommand<CR>
      " Execute last command
      noremap <Leader>tl :VimuxRunLastCommand<CR>
      ]])
    end
  },

  -- highlight ocurrences of the current word
  "RRethy/vim-illuminate",
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
  -- expand visual region
  "terryma/vim-expand-region",
  -- multiple cursors (<C-n><C-p><C-x>)
  "mg979/vim-visual-multi",
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
  --
  {
    "prettier/vim-prettier",
    config = function ()
      vim.g["prettier#autoformat"] = 1
      vim.g["prettier#autoformat_require_pragma"] = 0
    end
  },

  --
  -- "Valloric/MatchTagAlways",
  --
  "pangloss/vim-javascript",

  --
  "godlygeek/tabular",
  --
  {
    "rhysd/vim-gfm-syntax",
    config = function()
      vim.g.gfm_syntax_enable_always = 0
      vim.g.gfm_syntax_highlight_emoji = 0
      vim.g.gfm_syntax_enable_filetypes = {'markdown'}
    end
  },
  --
  {
    "ray-x/go.nvim",
    config = function ()
      vim.cmd([[
        autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
        autocmd FileType go nnoremap <silent> <Leader>k :<C-u>GoDoc<CR>
      ]])
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

  -- session management
  "tpope/vim-obsession",
  -- editorconfig
  "gpanders/editorconfig.nvim",

}

