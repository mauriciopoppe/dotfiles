call plug#begin('~/.config/nvim/plugged')

" Language {{{

Plug 'othree/html5.vim', { 'for': 'html' }

Plug 'digitaltoad/vim-jade', { 'for': 'jade' }

Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'othree/csscomplete.vim', { 'for': 'css' }

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/yajs.vim', { 'for': 'javascript' }
" Plug 'gavocanov/vim-js-indent', { 'for' : 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for' : 'javascript' }
" Plug 'othree/jspc.vim', { 'for' : 'javascript' }
Plug 'moll/vim-node', { 'for' : 'javascript' }
Plug 'isRuslan/vim-es6', { 'for': 'javascript' }

Plug 'elzr/vim-json', { 'for': 'json' }

Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

Plug 'tejr/vim-tmux', { 'for': 'tmux.conf,tmux' }

Plug 'beyondmarc/opengl.vim'
Plug 'beyondmarc/glsl.vim'

"}}}

" Interface {{{

" CSS color highlighter
Plug 'gorodinskiy/vim-coloresque', { 'for': ['css', 'sass', 'scss', 'less'] }
" lightline (simple status line)
Plug 'itchyny/lightline.vim'
" buffers tabline
Plug 'ap/vim-buftabline'
" tmux status line
" - install it once, run :TmuxlineSnapshot [file], save the file
Plug 'edkolev/tmuxline.vim', { 'on': 'TmuxlineSnapshot' }
" theme: hybrid extended
Plug 'kristijanhusak/vim-hybrid-material'
" diff sidebar
Plug 'mhinz/vim-signify'
" code completion
Plug 'Shougo/deoplete.nvim'
" syntax check
Plug 'scrooloose/syntastic'

"}}}

" Snippets {{{
" engine 
Plug 'SirVer/ultisnips'
" collection of snippets
Plug 'honza/vim-snippets'
" }}}

" Navigation {{{"{{{

" shortcuts
Plug 'tpope/vim-unimpaired'
" filesystem exploration (depends on unite)
Plug 'Shougo/vimfiler.vim'
" navigate to any visible part with 2-keystrokes
Plug 'easymotion/vim-easymotion'
" Tmux navigation
Plug 'christoomey/vim-tmux-navigator'
" better f
Plug 'rhysd/clever-f.vim'
" better /
" Plug 'haya14busa/incsearch.vim'
Plug 'rizzatti/dash.vim'
"}}}"}}}

" Commands {{{

" html expansion
Plug 'mattn/emmet-vim'
" git wrapper
Plug 'tpope/vim-fugitive'
" run commands from vim
Plug 'benmills/vimux'
" open browser
Plug 'tyru/open-browser.vim'

"}}}

" Unite {{{

" unite async depends on vimproc
Plug 'Shougo/unite.vim' | Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" show method definitions (like ctags but with unite)
Plug 'Shougo/unite-outline'
" history yank
Plug 'Shougo/neoyank.vim'
" most recently used files
Plug 'Shougo/neomru.vim'

" }}}

" Code manipulation {{{

" expand visual region
Plug 'terryma/vim-expand-region'
" multiple cursors
Plug 'terryma/vim-multiple-cursors'
" surround
Plug 'tpope/vim-surround'
" alignment
Plug 'junegunn/vim-easy-align'
" highlight ocurrences of the current word
" Plug 'itchyny/vim-cursorword' 
" commenting stuff
Plug 'tpope/vim-commentary'
" auto close (, [, {, ', ", `
Plug 'jiangmiao/auto-pairs'
" . improved
Plug 'tpope/vim-repeat'

" }}}

" Text objects {{{

" additional text objects (like [n]ext and [l]ast)
Plug 'wellle/targets.vim'
" allows the definition of custom text objects
Plug 'kana/vim-textobj-user'
" ae, ie (everything)
Plug 'kana/vim-textobj-entire'
" az, ez (block of folds)
Plug 'kana/vim-textobj-fold'
 
" }}}

" Other {{{

" correct mispellings
Plug 'chip/vim-fat-finger'
" session management
Plug 'tpope/vim-obsession'

" }}}

call plug#end()

