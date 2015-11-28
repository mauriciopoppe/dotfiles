" Date created: 21/11/2015
" Last updated: 27/11/2015
"
" - Before upgrading check https://github.com/neovim/neovim/wiki/Following-HEAD
"   and :h nvim-from-vim
" - Last update from HEAD done on 2015/11/11
"
" Awesome .vimrc files from
"
"     yadr - https://github.com/skwp/dotfiles/blob/master/vimrc
"     amix/vimrc - https://github.com/amix/vimrc
"     Terry Ma - https://github.com/terryma/dotfiles/blob/master/.vimrc
"     Martin Toma - https://github.com/martin-svk/dot-files/blob/master/neovim/init.vim

" ==============================================================================
" 1 Plugin manager
" ==============================================================================
"{{{

call plug#begin('~/.config/nvim/plugged')

" ------------------------------------------------------------------------------
" Language agnostic
" ------------------------------------------------------------------------------

" code completion
" TODO: add deoplete when stable
" asynchronous maker and linter
Plug 'benekastah/neomake', { 'on': ['Neomake']  }
" snippets
Plug 'SirVer/ultisnips'
" commenting stuff
Plug 'tpope/vim-commentary'
" auto close (, [, {, ', ", `
Plug 'jiangmiao/auto-pairs'

" ------------------------------------------------------------------------------
" Languages
" ------------------------------------------------------------------------------

" JS syntax
Plug 'pangloss/vim-javascript'
" JSON syntax
Plug 'sheerun/vim-json'
" HTML syntax
Plug 'othree/html5.vim'
" SCSS syntax
Plug 'cakebaker/scss-syntax.vim'
" Jade syntax
Plug 'digitaltoad/vim-jade'
" CSS color highlighter
Plug 'gorodinskiy/vim-coloresque', { 'for': ['css', 'sass', 'scss', 'less'] }
" markdown
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }
" tmux syntax
Plug 'tejr/vim-tmux'
" python syntax
Plug 'mitsuhiko/vim-python-combined'

" ------------------------------------------------------------------------------
" JavaScript
" ------------------------------------------------------------------------------

" superb development with nodejs
Plug 'moll/vim-node'

" ------------------------------------------------------------------------------
" Unite
" ------------------------------------------------------------------------------

" unite async depends on vimproc
Plug 'Shougo/unite.vim' | Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" show method definitions (like ctags but with unite)
Plug 'Shougo/unite-outline'
" history yank
Plug 'Shougo/neoyank.vim'
" most recently used files
Plug 'Shougo/neomru.vim'

" ------------------------------------------------------------------------------
" Navigation
" ------------------------------------------------------------------------------

" nerd tree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" `gof` opens finder and `got` terminal
Plug 'justinmk/vim-gtfo'
" navigate to any visible part with 2-keystrokes
Plug 'easymotion/vim-easymotion'

" ------------------------------------------------------------------------------
" Interface
" ------------------------------------------------------------------------------

" lightline (simple status line)
Plug 'itchyny/lightline.vim'
" buffers tabline
Plug 'ap/vim-buftabline'
" tmux status line
" - install it once, run :TmuxlineSnapshot [file]
Plug 'edkolev/tmuxline.vim'
" hybrid extended
Plug 'kristijanhusak/vim-hybrid-material'
" svn diff sidebar
Plug 'mhinz/vim-signify'

" ------------------------------------------------------------------------------
" External tools integration
" ------------------------------------------------------------------------------

" git wrapper
Plug 'tpope/vim-fugitive'
" tmux integration
Plug 'benmills/vimux'
" completion on insert mode from a visible tmux pane
Plug 'wellle/tmux-complete.vim'
" Tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" ------------------------------------------------------------------------------
" Text manipulation
" ------------------------------------------------------------------------------

" multiple cursors
Plug 'terryma/vim-multiple-cursors'
" additional text objects (like [n]ext and [l]ast)
Plug 'wellle/targets.vim'
" surround
Plug 'tpope/vim-surround'
" alignment
Plug 'junegunn/vim-easy-align'

" ------------------------------------------------------------------------------
" Other
" ------------------------------------------------------------------------------

" expand visual region
Plug 'terryma/vim-expand-region'
" deletes the current buffer in a smart way
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
" correct mispellings
Plug 'chip/vim-fat-finger'
" . improved
Plug 'tpope/vim-repeat'
" session management
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

call plug#end()

"}}}

" ==============================================================================
" 2. Basic settings
" ==============================================================================
"{{{

" ------------------------------------------------------------------------------
" Defaults
" - additional to https://neovim.io/doc/user/vim_diff.html#nvim-option-defaults
" ------------------------------------------------------------------------------

" default shell is zsh
set shell=/bin/zsh
" line numbering on
set number
" hide last line message (e.g. hide --INSERT--)
set noshowmode
" wrap text at 80 characters
set textwidth=80
" column width indicator
set colorcolumn=+1
" hiden instead of unload a buffer when abandoned
set hidden
" yank operation don't need to use the *" register (system clipboard)
set clipboard+=unnamed
" don't show matching brackets (performance improvement)
set noshowmatch
" when switching buffers don't move to the start of the line
set nostartofline
" minimum number of lines shown above the cursor when scrolling
set scrolloff=5
" allow positioning the cursor in places where there is no characters
set virtualedit=block
" time to send the CursorHold autocommand event
set updatetime=300
" use 256 colors
set t_Co=256
" show incomplete commands
set showcmd
" time to wait for a mapped sequence to complete
" e.g. wait 500ms when typing `j` and after `k` to exit from insert mode
set timeoutlen=500
" word completion :D
set complete+=kspell

" ------------------------------------------------------------------------------
" Indentation settings
" ------------------------------------------------------------------------------

" replace tab with spaces (insert a tab with <c-v><tab>)
set expandtab
" number of spaces inserted when <tab> is pressed (on insert mode)
set softtabstop=2
" how many columns are indented with the indent operations (<< and >>)
set shiftwidth=2

" ------------------------------------------------------------------------------
" Display settings
" ------------------------------------------------------------------------------

" wrap long lines (doesn't change what's on the buffer)
set linebreak
" show invisible chars
set list
" strings to use in list mode
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
" string to use at the start of lines that have been wrapped
set showbreak=↪

" ------------------------------------------------------------------------------
" Split settings
" ------------------------------------------------------------------------------

" :hsplit will put a window below the current window
set splitbelow
" :vsplit will put a window right the current window
set splitright

" ------------------------------------------------------------------------------
" Backup settings
" ------------------------------------------------------------------------------

" disable swap files
set noswapfile
" disable making a backup before owerwriting a file
set nobackup

" ------------------------------------------------------------------------------
" Spelling settings
" ------------------------------------------------------------------------------

" spellfile location
set spellfile=~/.config/nvim/spell/dictionary.utf-8.add
" language is US english
set spelllang=en_us

" ------------------------------------------------------------------------------
" Search settings
" ------------------------------------------------------------------------------

" ignore case by default
set ignorecase
" make search case sensitive only if it contains uppercase letters
set smartcase
" search again from top when it reaches the bottom
set wrapscan
" don't highlight after search
set nohlsearch

" ------------------------------------------------------------------------------
" Persistent undo settings
" ------------------------------------------------------------------------------

" enable persistent undo with a filename=full path
set undofile
" undo files are stored inside the following path
set undodir=~/.config/nvim/undo

" ------------------------------------------------------------------------------
" Filetype settings
" ------------------------------------------------------------------------------

" enable the loading of plugin files for specific file types
filetype plugin on
" enable the loading of indent files for specific file types
filetype indent on

" ------------------------------------------------------------------------------
" Folding settings
" ------------------------------------------------------------------------------

" markers are used to specify folds
set foldmethod=marker
" 2nd level folding
set foldlevelstart=2
" characters to fill in the fold
set fillchars="fold: "

" ------------------------------------------------------------------------------
" Omni completion settings
" ------------------------------------------------------------------------------

set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ------------------------------------------------------------------------------
" Neovim specific settings
" ------------------------------------------------------------------------------

"}}}

" ==============================================================================
" 3. Mapping settings
" ==============================================================================
"{{{

let mapleader = "\<space>"

" ------------------------------------------------------------------------------
" Override vim defaults
" ------------------------------------------------------------------------------

" treat long lines as break lines
noremap j gj
noremap k gk

" when jumping to the next match on search center the screen
noremap n nzz
noremap N Nzz

" when jumping forward/backward center the screen
noremap <C-f> <C-f>zz
noremap <C-b> <C-b>zz

" move to the end of the pasted text on copy/paste
vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p

" avoid `c` from yanking to the default register
nnoremap c "xc
xnoremap c "xc

" fix cw and dw to behave the same way
nnoremap cw ce
nnoremap dw de

" ------------------------------------------------------------------------------
" Custom mappings
" ------------------------------------------------------------------------------

" make Y behavior like D, and C
nnoremap Y y$

" quickly close a window
nnoremap Q :q<CR>

" since `u` undos `U` redos
nnoremap U :redo<CR>

" paste from the system clipboard
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" ------------------------------------------------------------------------------
" Panes and buffers
" ------------------------------------------------------------------------------

" remapping control + movement to move between split panes
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>

" space + \ = create a new vertical pane (the | key is over \)
" space + - = create a new horizontal pane
nnoremap <leader>\ <c-w>v<c-w>l
nnoremap <leader>- <c-w>s

" ˙ = alt + h (switch to the previous buffer)
nnoremap ˙ :bprevious<CR>
" ¬ = alt + l (switch to the next buffer)
nnoremap ¬ :bnext<CR>

" TODO: pane resizing

" ------------------------------------------------------------------------------
" Working on visual mode
" ------------------------------------------------------------------------------

" move a block while fixing the indentation
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" keep the selection after an indent operation
vnoremap > >gv
vnoremap <LT> <LT>gv

" ------------------------------------------------------------------------------
" Working on insert mode
" ------------------------------------------------------------------------------

" exit from insert mode (note to self: do it with <C-c> instead)
inoremap jk <ESC>
inoremap kj <ESC>

inoremap <C-c> <ESC>
vnoremap <C-c> <ESC>
nnoremap <C-c> <ESC>
"}}}

" ==============================================================================
" 4. Plugin settings
" ==============================================================================
"{{{

" ------------------------------------------------------------------------------
" Unite
" ------------------------------------------------------------------------------

" matcher settings
call unite#filters#matcher_default#use(['matcher_fuzzy', 'matcher_hide_current_file'])
call unite#filters#sorter_default#use(['sorter_rank'])

" use ag if available
if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S -C0'
  let g:unite_source_grep_recursive_opts=''
  let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
endif

" custom profile
call unite#custom#profile('default', 'context', {
      \   'prompt': '» ',
      \   'winheight': 15,
      \ })

" syntax highlight
let g:unite_source_line_enable_highlight=1
" start in insert mode
let g:unite_enable_start_insert=1
" unite meta
let g:unite_data_directory='~/.unite'

" custom menu
let g:unite_source_menu_menus={}

" Git menu
let g:unite_source_menu_menus.git = {
      \     'description' : 'Git commands',
      \ }
let g:unite_source_menu_menus.git.command_candidates = [
      \       ['Stage hunk', 'GitGutterStageHunk'],
      \       ['Unstage hunk', 'GitGutterRevertHunk'],
      \       ['Stage', 'Gwrite'],
      \       ['Status', 'Gstatus'],
      \       ['Diff', 'Gvdiff'],
      \       ['Commit', 'Gcommit --verbose'],
      \       ['Revert', 'Gread'],
      \       ['Log', 'Glog'],
      \       ['Visual Log', 'Gitv'],
      \     ]

let g:unite_source_menu_menus.unite = {
      \     'description' : 'Unite actions',
      \ }
let g:unite_source_menu_menus.unite.command_candidates = [
      \       ['Unite MRUs', 'call utils#uniteMRUs()'],
      \       ['Unite buffers', 'call utils#uniteBuffers()'],
      \       ['Unite file browse', 'call utils#uniteFileBrowse()'],
      \       ['Unite file search', 'call utils#uniteFileRec()'],
      \       ['Unite grep', 'call utils#uniteGrep()'],
      \       ['Unite history', 'call utils#uniteHistory()'],
      \       ['Unite line search', 'call utils#uniteLineSearch()'],
      \       ['Unite menu', 'call utils#uniteCustomMenu()'],
      \       ['Unite registers', 'call utils#uniteRegisters()'],
      \       ['Unite snippets', 'call utils#uniteSnippets()'],
      \       ['Unite sources', 'call utils#uniteSources()'],
      \       ['Unite file tags (symbols)', 'call utils#uniteOutline()'],
      \       ['Unite tags', 'call utils#uniteTags()'],
      \       ['Unite windows', 'call utils#uniteWindows()'],
      \       ['Unite yank history', 'call utils#uniteYankHistory()'],
      \       ['Unite jump history', 'call utils#uniteJumps()'],
      \     ]

let g:unite_source_menu_menus.mine = {
      \     'description' : 'utility stuff'
      \}
let g:unite_source_menu_menus.mine.command_candidates = [
      \       ['Markdown keyboard', 'call utils#kbd()']
      \     ]

" ------------------------------------------------------------------------------
" Lightline
" ------------------------------------------------------------------------------

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'tab': {
      \   'active': [ 'tabnum', 'filename', 'modified' ],
      \   'inactive': [ 'tabnum', 'filename', 'modified' ]
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" ------------------------------------------------------------------------------
" Neomake settings
" ------------------------------------------------------------------------------

let g:neomake_verbose=0
let g:neomake_warning_sign={
      \ 'text': '>',
      \ 'texthl': 'WarningMsg',
      \ }
let g:neomake_error_sign={
      \ 'text': '>',
      \ 'texthl': 'ErrorMsg',
      \ }
let g:neomake_javascript_enabled_makers = ['standard']

" ------------------------------------------------------------------------------
" Vim markdown
" ------------------------------------------------------------------------------

let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_folding_disabled=1

" ------------------------------------------------------------------------------
" Session management
" ------------------------------------------------------------------------------

let g:session_autosave='yes'
let g:session_directory='~/.config/nvim/sessions'
let g:session_persist_font=0
let g:session_persist_colors=0

" ------------------------------------------------------------------------------
" Tmuxline
" ------------------------------------------------------------------------------
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#I #W',
      \'x'    : [
      \'#(osascript ${DOTFILES_DIRECTORY}/applescripts/spotify.scpt)',
      \'#(bash ${DOTFILES_DIRECTORY}/bin/battery_left.sh)'
      \],
      \'y'    : ['%a %b %d', '%R'],
      \'z'    : '#H'}

"}}}

" ==============================================================================
" 5. Plugin mappings
" ==============================================================================
"{{{

" ------------------------------------------------------------------------------
" Unite
" ------------------------------------------------------------------------------

function! s:unite_settings()
  " navigation with <c-j> and <c-k> on insert mode
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)

  imap <buffer> <C-l> <Plug>(unite_redraw)

  " exit with escape
  nmap <buffer> Q <Plug>(unite_exit)
  nmap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> <ESC> <Plug>(unite_exit)

  " preview
  nmap <buffer> <C-p> <Plug>(unite_toggle_auto_preview)

  " mark candidates
  vmap <buffer> m <Plug>(unite_toggle_mark_selected_candidates)
  nmap <buffer> m <Plug>(unite_toggle_mark_current_candidates)
endfunction
autocmd FileType unite call s:unite_settings()

" sources (all menus available)
nnoremap <silent> <leader>u :call utils#uniteSources()<CR>

" search files recursively ([o]pen files)
nnoremap <silent> <leader>o :call utils#uniteFileRecursive()<CR>
" search between open [b]uffers
nnoremap <silent> <leader>b :call utils#uniteBuffers()<CR>
" search in current outline ([t]ags)
nnoremap <silent> <leader>t :call utils#uniteOutline()<CR>
" search for term (grep)
nnoremap <silent> <leader>/ :call utils#uniteGrep()<CR>
" search in [l]ines on current buffer
nnoremap <silent> <leader>l :call utils#uniteLineSearch()<CR>
" search in [y]ank history
nnoremap <silent> <leader>y :call utils#uniteYankHistory()<CR>
" search in opened [w]indow splits
nnoremap <silent> <leader>w :call utils#uniteWindows()<CR>
" unite menu for fugitive
nnoremap <silent> <leader>g :call utils#uniteFugitive()<CR>
" unite menu for my stuff
nnoremap <silent> <leader>m :Unite -no-split -buffer-name=menu -start-insert menu:mine<CR>

" not that useful in my workflow
"
" search in [r]egisters
" nnoremap <silent> <leader>r :call utils#uniteRegisters()<CR>
" search in edit [h]istory
" nnoremap <silent> <leader>h :call utils#uniteHistory()<CR>
" search [f]iles in cwd (doesn't search inside folders)
" nnoremap <silent> <leader>f :call utils#uniteFileBrowse()<CR>
" Search in ultisnips [s]nippets
" nnoremap <silent> <leader>s :call utils#uniteSnippets()<CR>
" search in latest [j]ump positions
" nnoremap <silent> <leader>j :call utils#uniteJumps()<CR>

" ------------------------------------------------------------------------------
" Easymotion
" ------------------------------------------------------------------------------

let g:EasyMotion_do_mapping=0 " Disable default mappings
nmap <Leader>s <Plug>(easymotion-s2)

" ------------------------------------------------------------------------------
" Expand region
" ------------------------------------------------------------------------------

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" ------------------------------------------------------------------------------
" Vimux
" ------------------------------------------------------------------------------

let g:VimuxUseNearestPane=1
" Executes a command in a tmux split, if there's one available run it there
noremap <Leader>vp :VimuxPromptCommand<CR>
" Execute last command
noremap <Leader>vl :VimuxRunLastCommand<CR>
" Moves to the pane created by tmux and enters copy mode
noremap <Leader>vi :VimuxInspectRunner<CR>

" vimux - npm test
noremap <Leader>n :VimuxRunCommand("clear; npm test")<CR>

" ------------------------------------------------------------------------------
" Tmux-complete
" ------------------------------------------------------------------------------

" On insert mode press <C-x><C-u>
" TODO: when deoplete is complete replace with empty
let g:tmuxcomplete#trigger = 'completefunc'

" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------

" similar to sublime text
nnoremap <Leader>kb :NERDTreeToggle<CR>
nnoremap <Leader>kr :NERDTreeFind<CR>

" ------------------------------------------------------------------------------
" Ultisnips
" ------------------------------------------------------------------------------

let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" Make UltiSnips works nicely with YCM
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

autocmd BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

"}}}

" ==============================================================================
" 6. Color and highlight settings
" ==============================================================================
"{{{

" syntax highlightling
syntax on

let g:enable_bold_font=1
set background=dark
try
  colorscheme hybrid_reverse
catch
endtry

" Link highlight groups to improve buftabline colors
hi! link BufTabLineCurrent Statement
hi! link BufTabLineActive Comment
hi! link BufTabLineHidden Comment
hi! link BufTabLineFill Comment

highlight SignifySignAdd    cterm=NONE ctermbg=NONE  ctermfg=119
highlight SignifySignDelete cterm=NONE ctermbg=NONE  ctermfg=167
highlight SignifySignChange cterm=NONE ctermbg=NONE  ctermfg=227

"}}}
" ==============================================================================
" 7. File agnostic settings
" ==============================================================================
"{{{

augroup mine
  autocmd InsertLeave,TextChanged * silent! :update
  autocmd BufWritePre * call utils#stripTrailingWhitespaces()
  "jump to last cursor position when opening a file
  autocmd BufReadPost * call utils#cursorJumpToLastPosition()
augroup END

"}}}

" ==============================================================================
" 8. File specific settings
" ==============================================================================

augroup mine
  " spell check is on for markdown
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd FileType markdown setlocal spell
  "spell check when writing commit logs
  autocmd filetype svn,*commit* setlocal spell
augroup END

augroup mine
  " the black screen happens because of the plugins
  autocmd BufWritePost init.vim source %
augroup END

