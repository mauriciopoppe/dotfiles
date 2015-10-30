set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'gmarik/vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'sheerun/vim-polyglot'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'
Plugin 'easymotion/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'terryma/vim-expand-region'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'

" Themes
Plugin 'flazz/vim-colorschemes'

" first time installation see
" https://github.com/Valloric/YouCompleteMe#mac-os-x-installation
Plugin 'Valloric/YouCompleteMe'

" snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()            " required
filetype plugin indent on    " required

" ##### plugins configuration ######
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" kien/ctrlp.vim
" taken from https://github.com/thoughtbot/dotfiles/blob/master/vimrc
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['standard']

" bling/vim-airline
set laststatus=2
let g:airline_powerline_fonts = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" xolox/vim-session
let g:session_autosave = 0

" airblade/vim-gitgutter
let g:gitgutter_map_keys = 0

" Valloric/YouCompleteMe
let g:UltiSnipsExpandTrigger='<c-e>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'

" themes
syntax enable
set background=dark
colorscheme hybrid

"  ##### Editor configurations #####
set relativenumber
set number
" line numbers go from 0 to 99999 "
set numberwidth=5
" tab space set equal to 2 spaces "
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
" mouse support
set mouse=a
" Turn backup off (no .swap files)
set noswapfile
let g:netrw_dirhistmax = 0
" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
" avoid creating a wrap when the code goes +80 chars, just do it for comments
set wrap linebreak nolist
" show matching brackets
set showmatch
" splits are below and right
set splitbelow
set splitright

" removes trailing whitespace on save "
autocmd BufWritePre * :%s/\s\+$//e
" autosave
" http://blog.unixphilosopher.com/2015/02/a-more-betterer-autosave-in-vim.html
autocmd InsertLeave,TextChanged * if expand('%') != '' | update | endif
" set syntax highlighting for specific file types
autocmd BufRead,BufNewFile *.md set filetype=markdown
" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell
" Automatically wrap at 80 characters for Markdown
autocmd BufRead,BufNewFile *.md setlocal textwidth=80

" ##### command-line mappings ##### "
" Ctrl-Space: Show history
cnoremap <c-@> <c-f>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-f> <left>
cnoremap <c-g> <right>

" ##### custom mappings #####
" space is my leader "
let mapleader = "\<Space>"

" Yank text to the OS X clipboard
noremap <leader>y "*y
" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" easymotion 2-word search
nmap s <Plug>(easymotion-s2)

" jump to the end of a pasted text
" vnoremap <silent> y y`
" vnoremap <silent> p p`]
" nnoremap <silent> p p`]

" remapping control + movement to move between split panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" space + v = create a new vertical pane
" space + s = create a new horizontal pane
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s

" terryma/vim-expand-region override
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" remap Esc to jj in insert mode"
inoremap jk <esc>
inoremap kj <esc>

" Y: yank til $"
nnoremap Y y$

" Q: closes the window"
nnoremap Q :q<cr>

" U: Redos since 'u' undos
nnoremap U :redo<cr>

" http://vimrcfu.com/snippet/77
" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" http://vimrcfu.com/snippet/14
" keep the selection after indenting
vnoremap > >gv
vnoremap <LT> <LT>gv

" from: https://joshldavis.com/2015/04/05/vim-tab-madness-buffers-vs-tabs/
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden
" To open a new empty buffer
nmap <leader>T :enew<cr>
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" window resizing
nmap <leader><Up> :resize +5<cr>
nmap <leader><Down> :resize +5<cr>
nmap <leader><Left> :vertical resize -5<cr>
nmap <leader><Right> :vertical resize +5<cr>

