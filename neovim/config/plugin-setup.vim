
" Interface {{{

" language highlighter pack
Plug 'sheerun/vim-polyglot'
" lightline (simple status line)
Plug 'itchyny/lightline.vim'
" buffers tabline
Plug 'ap/vim-buftabline'

" themes
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'Lokaltog/vim-distinguished'
Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'
Plug 'reedes/vim-colors-pencil'

" diff sidebar
Plug 'mhinz/vim-signify'
" indent guides
Plug 'nathanaelkane/vim-indent-guides'
" make yanked region apparent
Plug 'machakann/vim-highlightedyank'
" distraction free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" denite {{{

" search/display lists
Plug 'Shougo/denite.nvim'

"
" Note: unite-source-file_rec/async depends on vimproc
" Plug 'Shougo/unite.vim' | Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" " history yank
" Plug 'Shougo/neoyank.vim'
" " most recently used files
" Plug 'Shougo/neomru.vim'

" " Unite sources {{{
" " show method definitions (like ctags but with unite)
" Plug 'Shougo/unite-outline'
" " most recently used files
" Plug 'tsukkee/unite-tag'
" " quickfix and location_list
" Plug 'chemzqm/unite-location'
" " filesystem exploration (depends on unite)
" Plug 'Shougo/vimfiler.vim'
" }}}

" FZF {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" }}}

" }}}

" deoplete (autocomplete) {{{

" creates aliases depending on the context (cpp also gets c completion)
Plug 'Shougo/context_filetype.vim'
" header name completion
Plug 'Shougo/neoinclude.vim'

" keyword completion engine
Plug 'Shougo/deoplete.nvim' ", {'do': ':UpdateRemotePlugins' }
" c++
Plug 'zchee/deoplete-clang', { 'for': ['cpp', 'c', 'hpp', 'h'] }
" js
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs'
Plug 'mhartington/deoplete-typescript'
" Plug 'mhartington/vim-angular2-snippets'
" Plug 'othree/jspc.vim'

" python

Plug 'zchee/deoplete-jedi', { 'for': ['python'] }

"}}}

" neomake {{{

Plug 'neomake/neomake'

" }}}

" }}}

" Navigation {{{

" additional mappings
Plug 'tpope/vim-unimpaired'
" navigate to any visible part with 2-keystrokes
Plug 'easymotion/vim-easymotion'
" Tmux navigation
Plug 'christoomey/vim-tmux-navigator'
" better f
Plug 'rhysd/clever-f.vim'
" better motion
Plug 'bkad/CamelCaseMotion'
" better /
" Plug 'haya14busa/incsearch.vim'

" }}}

" Integration with external commands/apps {{{

" git wrapper
Plug 'tpope/vim-fugitive'
" run commands in a tmux split
Plug 'benmills/vimux'
" execute a command in the background
" Plug 'tpope/vim-dispatch'
" run commands in the background asynchronously filling the quickfix
" list (alternative to vim-dispatch for compilation)
Plug 'skywind3000/asyncrun.vim'
" open browser
Plug 'tyru/open-browser.vim'
" open documentation (dash)
Plug 'rizzatti/dash.vim'

"}}}

" Code manipulation {{{

" html expansion
Plug 'mattn/emmet-vim'
" expand visual region
Plug 'terryma/vim-expand-region'
" multiple cursors
Plug 'terryma/vim-multiple-cursors'
" surround
Plug 'tpope/vim-surround'
" alignment
Plug 'junegunn/vim-easy-align'
" highlight ocurrences of the current word
Plug 'itchyny/vim-cursorword'
" commenting stuff
Plug 'tpope/vim-commentary'
" auto close (, [, {, ', ", `
Plug 'jiangmiao/auto-pairs'
" . improved
Plug 'tpope/vim-repeat'
" table mode
Plug 'dhruvasagar/vim-table-mode'
" FastFold
Plug 'Konfekt/FastFold'
" vimwiki
" Plug 'vimwiki/vimwiki'
" Plug 'vitalk/vim-simple-todo'

" Text objects {{{

" additional text objects (like [n]ext and [l]ast)
Plug 'wellle/targets.vim'
" allows the definition of custom text objects
Plug 'kana/vim-textobj-user'
" ae, ie (everything)
Plug 'kana/vim-textobj-entire'
" az, iz (block of folds)
Plug 'kana/vim-textobj-fold'
" al, il (inside the current line e.g. similar to ^vg_)
Plug 'kana/vim-textobj-line'
" ax, ix (xml attributes)
Plug 'whatyouhide/vim-textobj-xmlattr'
" ac, ic (comments)
Plug 'glts/vim-textobj-comment'

" }}}

" }}}

" Language specific {{{

Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'othree/csscomplete.vim', { 'for': 'css' }

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/yajs.vim', { 'for': 'javascript' }
" Plug 'gavocanov/vim-js-indent', { 'for' : 'javascript' }
" Plug 'othree/javascript-libraries-syntax.vim', { 'for' : 'javascript' }
" Plug 'othree/jspc.vim', { 'for' : 'javascript' }
Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
Plug 'jason0x43/vim-js-indent'
" jumping between node modules
Plug 'moll/vim-node'
Plug 'isRuslan/vim-es6', { 'for': 'javascript' }

Plug 'elzr/vim-json', { 'for': 'json' }

Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

Plug 'beyondmarc/opengl.vim'
Plug 'beyondmarc/glsl.vim'

" CSS color highlighter
Plug 'gorodinskiy/vim-coloresque', { 'for': ['css', 'sass', 'scss', 'less'] }
Plug 'yoppi/fluentd.vim'

"}}}

" Other {{{

" correct mispellings
Plug 'chip/vim-fat-finger'
" session management
Plug 'tpope/vim-obsession'
" local vimrc
Plug 'embear/vim-localvimrc'
" editorconfig
Plug 'editorconfig/editorconfig-vim'

" Snippets {{{
" engine
Plug 'SirVer/ultisnips'
" collection of snippets
Plug 'honza/vim-snippets'

" }}}

" }}}


