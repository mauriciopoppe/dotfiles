" Interface {{{

Plug 'nvim-lua/plenary.nvim'  " lua utility functions
Plug 'MunifTanjim/nui.nvim'   " lua UI library
Plug 'neovim/nvim-lspconfig'  " common confs for nvim-lsp

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'github/copilot.vim'   " autopilot
Plug 'hrsh7th/nvim-cmp'     " completion engine
Plug 'onsails/lspkind-nvim' " completion icons

Plug 'dcampos/nvim-snippy' " snippet engine
Plug 'dcampos/cmp-snippy'  " snippet engine adapter for nvim-cmp
Plug 'honza/vim-snippets'  " collection of snippets

Plug 'nvim-treesitter/nvim-treesitter', {
       \ 'do': ':TSUpdate',
       \ }  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-textobjects' " treesitter objects
Plug 'lewis6991/spellsitter.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'tag': 'v2.34' }
Plug 'mrbjarksen/neo-tree-diagnostics.nvim'

Plug 'nvim-telescope/telescope.nvim'   " overlay for navigation
" Plug 'lewis6991/gitsigns.nvim'
Plug 'mhinz/vim-signify'

Plug 'nvim-lualine/lualine.nvim' " statusline
Plug 'ap/vim-buftabline'         " buffers tabline
Plug 'preservim/tagbar'          " right sidebaf for navigation

Plug 'nathanaelkane/vim-indent-guides' " indent guides
Plug 'junegunn/goyo.vim'               " distraction free writing
Plug 'junegunn/limelight.vim'          " dim unfocussed paragraphs

Plug 'mfussenegger/nvim-dap'      " debugger
Plug 'rcarriga/nvim-dap-ui'	  " debugger ui

" themes
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'w0ng/vim-hybrid'

" FZF {{{

" Plug 'junegunn/fzf', {
"   \ 'dir': '~/.fzf',
"   \ 'do': './install --all'
"   \ }                   " fuzzy finder engine
" Plug 'junegunn/fzf.vim' " fuzzy finder bindings for vim

" }}}

" autocomplete {{{
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'fannheyward/telescope-coc.nvim'  " plugin for coc actions in telescope
" }}}

" }}}

" Navigation {{{

Plug 'ggandor/lightspeed.nvim'        " navigate to any visible part
Plug 'tpope/vim-unimpaired'           " additional mappings
Plug 'christoomey/vim-tmux-navigator' " tmux navigation
" Plug 'easymotion/vim-easymotion'      " navigate to any visible part with 2-keystrokes
" Plug 'rhysd/clever-f.vim'             " better f
Plug 'bkad/CamelCaseMotion'           " better motion
" Plug 'mileszs/ack.vim'                " search
Plug 'mbbill/undotree'                " undo tree
Plug 'samoshkin/vim-mergetool'        " better vim mergetool, needs setup in git config too

" }}}

" Integration with external commands/apps {{{

" Plug 'w0rp/ale'
Plug 'ojroques/vim-oscyank'  " clipboard over ssh through tmux
Plug 'tpope/vim-fugitive'    " git wrapper
Plug 'benmills/vimux'        " run commands in a tmux split
Plug 'tyru/open-browser.vim' " open browser

"}}}

" Code manipulation {{{

" Plug 'Konfekt/FastFold'             " FastFold
Plug 'dhruvasagar/vim-table-mode'   " table mode
Plug 'itchyny/vim-cursorword'       " highlight ocurrences of the current word
" Plug 'itchyny/vim-parenmatch'       " highlight ocurrences of the current word
Plug 'jiangmiao/auto-pairs'         " auto close (, [, {, ', \", `
Plug 'junegunn/vim-easy-align'      " alignment
" Plug 'mattn/emmet-vim'              " html expansion
Plug 'terryma/vim-expand-region'    " expand visual region
Plug 'terryma/vim-multiple-cursors' " multiple cursors (<C-n><C-p><C-x>)
Plug 'tpope/vim-commentary'         " commenting stuff
Plug 'tpope/vim-repeat'             " . improved
Plug 'tpope/vim-sleuth'             " indentation heuristics
Plug 'tpope/vim-surround'           " change/delete surrounding characters
Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " code formatter

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
Plug 'fatih/vim-go', { 'tag': 'v1.19', 'do': ':GoInstallBinaries' }
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

