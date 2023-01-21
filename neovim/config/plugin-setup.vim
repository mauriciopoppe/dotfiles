" Interface {{{

Plug 'nvim-lua/plenary.nvim'  " lua utility functions
Plug 'MunifTanjim/nui.nvim'   " lua UI library
Plug 'neovim/nvim-lspconfig'  " common confs for nvim-lsp

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
" Only enable copilot in my personal computer and not at work.
let s:uname = match(system('uname -n'), "Mauricios-MBP")
if trim(s:uname) != -1
    Plug 'github/copilot.vim'
endif
Plug 'hrsh7th/nvim-cmp'     " completion engine
Plug 'onsails/lspkind-nvim' " completion icons

Plug 'dcampos/nvim-snippy' " snippet engine
Plug 'dcampos/cmp-snippy'  " snippet engine adapter for nvim-cmp
Plug 'honza/vim-snippets'  " snippet collection

Plug 'nvim-treesitter/nvim-treesitter', {
       \ 'do': ':TSUpdate',
       \ }  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-textobjects' " treesitter objects
Plug 'nvim-treesitter/nvim-treesitter-context'     " header line that gives context
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'lewis6991/spellsitter.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'tag': 'v2.34' }
Plug 'mrbjarksen/neo-tree-diagnostics.nvim'
Plug 'mhinz/vim-signify'               " signs for navigation (also supports hg)
Plug 'nvim-lualine/lualine.nvim' " statusline
Plug 'ap/vim-buftabline'         " buffers tabline
Plug 'preservim/tagbar'          " right sidebaf for navigation
Plug 'windwp/nvim-spectre'       " search and replace

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }   " overlay for navigation
Plug 'LinArcX/telescope-command-palette.nvim'    " custom command palette

Plug 'nathanaelkane/vim-indent-guides' " indent guides
Plug 'junegunn/goyo.vim'               " distraction free writing
Plug 'junegunn/limelight.vim'          " dim unfocussed paragraphs

Plug 'mfussenegger/nvim-dap'      " debugger
Plug 'rcarriga/nvim-dap-ui'       " debugger ui
Plug 'theHamsta/nvim-dap-virtual-text' " debugger virtual text

Plug 'kristijanhusak/vim-hybrid-material'
Plug 'w0ng/vim-hybrid'
Plug 'lifepillar/vim-solarized8'

" }}}

" Navigation {{{

Plug 'ggandor/leap.nvim'              " navigate to any visible part
Plug 'ggandor/flit.nvim'              " f/F/t/T navigation
Plug 'tpope/vim-unimpaired'           " additional mappings
Plug 'christoomey/vim-tmux-navigator' " tmux navigation
Plug 'bkad/CamelCaseMotion'           " better motion
Plug 'mbbill/undotree'                " undo tree
Plug 'samoshkin/vim-mergetool'        " better vim mergetool, needs setup in git config too

" }}}

" Integration with external commands/apps {{{

Plug 'ojroques/vim-oscyank', {'branch': 'main'}  " clipboard over ssh through tmux
Plug 'tpope/vim-fugitive'    " git wrapper
Plug 'benmills/vimux'        " run commands in a tmux split
Plug 'tyru/open-browser.vim' " open browser

"}}}

" Code manipulation {{{

" Plug 'Konfekt/FastFold'             " FastFold
Plug 'dhruvasagar/vim-table-mode'   " table mode
Plug 'itchyny/vim-cursorword'       " highlight ocurrences of the current word
Plug 'jiangmiao/auto-pairs'         " auto close (, [, {, ', \", `
Plug 'junegunn/vim-easy-align'      " alignment
Plug 'terryma/vim-expand-region'    " expand visual region
Plug 'terryma/vim-multiple-cursors' " multiple cursors (<C-n><C-p><C-x>)
Plug 'tpope/vim-commentary'         " commenting stuff
Plug 'tpope/vim-repeat'             " . improved
Plug 'tpope/vim-sleuth'             " indentation heuristics
Plug 'kylechui/nvim-surround'       " change/delete surrounding characters
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

" }}}

" Language specific {{{

" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'chemzqm/vim-jsx-improve'
" Plug 'alvan/vim-closetag'
Plug 'Valloric/MatchTagAlways'
" Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
" Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
" Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'pangloss/vim-javascript'

Plug 'godlygeek/tabular'
Plug 'rhysd/vim-gfm-syntax'

Plug 'pprovost/vim-ps1'      " ft for powershell scripts :(

" OpenGL + GLSL
" Plug 'beyondmarc/opengl.vim'
" Plug 'beyondmarc/glsl.vim'

" CSS color highlighter
" Plug 'gorodinskiy/vim-coloresque', { 'for': ['css', 'sass', 'scss', 'less'] }
" Plug 'yoppi/fluentd.vim'

" Go
" Plug 'fatih/vim-go', { 'tag': 'v1.19', 'do': ':GoInstallBinaries' }
Plug 'ray-x/go.nvim'
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'sebdah/vim-delve'
" Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

" Terraform
" Plug 'hashivim/vim-terraform'

"}}}

" Other {{{

Plug 'tpope/vim-obsession'           " session management
" Plug 'embear/vim-localvimrc'         " local vimrc
Plug 'editorconfig/editorconfig-vim' " editorconfig

" }}}

