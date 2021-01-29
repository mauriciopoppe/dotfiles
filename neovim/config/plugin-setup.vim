" Interface {{{

Plug 'sheerun/vim-polyglot'  " language highlighter pack
Plug 'itchyny/lightline.vim' " lightline (simple status line)
Plug 'ap/vim-buftabline'     " buffers tabline
Plug 'majutsushi/tagbar'     " right sidebaf for navigation

Plug 'mhinz/vim-signify'               " diff sidebar
Plug 'nathanaelkane/vim-indent-guides' " indent guides
Plug 'machakann/vim-highlightedyank'   " make yanked region apparent
Plug 'junegunn/goyo.vim'               " distraction free writing
Plug 'junegunn/limelight.vim'          " dim unfocussed paragraphs

" themes
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'Lokaltog/vim-distinguished'
Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'
Plug 'reedes/vim-colors-pencil'
Plug 'NLKNguyen/papercolor-theme'

" denite {{{

" search/display lists
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/unite.vim'

" unite/denite sources {{{

Plug 'Shougo/neoyank.vim'     " history yank
Plug 'Shougo/neomru.vim'      " most recently used files
Plug 'Shougo/unite-outline'   " show method definitions (like ctags but with unite)
Plug 'tsukkee/unite-tag'      " most recently used files
Plug 'chemzqm/unite-location' " quickfix and location_listcu
Plug 'Shougo/vimfiler.vim'    " filesystem exploration (depends on unite)

" }}}
" FZF {{{

Plug 'junegunn/fzf', {
  \ 'dir': '~/.fzf',
  \ 'do': './install --all'
  \ }                   " fuzzy finder engine
Plug 'junegunn/fzf.vim' " fuzzy finder bindings for vim

" }}}
" }}}

" autocomplete {{{

" completion engine
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'Shougo/deoplete.nvim'

" " languages
" Plug 'zchee/deoplete-clang', { 'for': ['cpp', 'c', 'hpp', 'h'] }
" Plug 'carlitux/deoplete-ternjs'
" Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
" Plug 'wokalski/autocomplete-flow'
" Plug 'zchee/deoplete-jedi', { 'for': ['python'] }


" language support
Plug 'Shougo/context_filetype.vim'  " aliases depending on the context
Plug 'Shougo/neoinclude.vim'        " header name completion
" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" }}}

" }}}

" Navigation {{{

Plug 'tpope/vim-unimpaired'           " additional mappings
Plug 'easymotion/vim-easymotion'      " navigate to any visible part with 2-keystrokes
Plug 'christoomey/vim-tmux-navigator' " tmux navigation
Plug 'rhysd/clever-f.vim'             " better f
Plug 'bkad/CamelCaseMotion'           " better motion
Plug 'mileszs/ack.vim'                " search
Plug 'mbbill/undotree'                " undo tree

" }}}

" Integration with external commands/apps {{{

Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'    " git wrapper
Plug 'benmills/vimux'        " run commands in a tmux split
Plug 'tyru/open-browser.vim' " open browser
Plug 'rizzatti/dash.vim'     " open documentation (dash)
" execute a command in the background
" Plug 'tpope/vim-dispatch'
" run commands in the background asynchronously filling the quickfix
" list (alternative to vim-dispatch for compilation)
Plug 'skywind3000/asyncrun.vim'

"}}}

" Code manipulation {{{

Plug 'Konfekt/FastFold'             " FastFold
Plug 'dhruvasagar/vim-table-mode'   " table mode
Plug 'itchyny/vim-cursorword'       " highlight ocurrences of the current word
" Plug 'itchyny/vim-parenmatch'       " highlight ocurrences of the current word
Plug 'jiangmiao/auto-pairs'         " auto close (, [, {, ', \", `
Plug 'junegunn/vim-easy-align'      " alignment
Plug 'mattn/emmet-vim'              " html expansion
Plug 'terryma/vim-expand-region'    " expand visual region
Plug 'terryma/vim-multiple-cursors' " multiple cursors (<C-n><C-p><C-x>)
Plug 'tpope/vim-commentary'         " commenting stuff
Plug 'tpope/vim-repeat'             " . improved
Plug 'tpope/vim-sleuth'             " indentation heuristics
Plug 'tpope/vim-surround'           " change/delete surrounding characters
Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " code formatter

" Text objects {{{

Plug 'wellle/targets.vim'              " additional text objects (like [n]ext and [l]ast)
Plug 'kana/vim-textobj-user'           " allows the definition of custom text objects
Plug 'kana/vim-textobj-entire'         " ae, ie (everything)
Plug 'kana/vim-textobj-function'         " ae, ie (everything)
Plug 'whatyouhide/vim-textobj-xmlattr' " ax, ix (xml attributes)
" }}}

" }}}

" Language specific {{{

Plug 'HerringtonDarkholme/yats.vim'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
Plug 'chemzqm/vim-jsx-improve'
Plug 'mxw/vim-jsx'
Plug 'alvan/vim-closetag'
Plug 'Valloric/MatchTagAlways'
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
Plug 'moll/vim-node', { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
Plug 'isRuslan/vim-es6', { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
Plug 'pangloss/vim-javascript'

Plug 'elzr/vim-json', { 'for': 'json' }

Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'rhysd/vim-gfm-syntax'

" OpenGL + GLSL
Plug 'beyondmarc/opengl.vim'
Plug 'beyondmarc/glsl.vim'

" CSS color highlighter
Plug 'gorodinskiy/vim-coloresque', { 'for': ['css', 'sass', 'scss', 'less'] }
Plug 'yoppi/fluentd.vim'

" Go
Plug 'fatih/vim-go', { 'tag': 'v1.19', 'do': ':GoInstallBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

" Terraform
Plug 'hashivim/vim-terraform'

"}}}

" Other {{{

Plug 'tpope/vim-obsession'           " session management
Plug 'embear/vim-localvimrc'         " local vimrc
Plug 'editorconfig/editorconfig-vim' " editorconfig

" }}}

" Snippets {{{

Plug 'SirVer/ultisnips'   " engine
Plug 'honza/vim-snippets' " collection of snippets


" }}}

