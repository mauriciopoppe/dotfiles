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
Plugin 'easymotion/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'autoclose'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/Solarized'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'terryma/vim-expand-region'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'

" all of your plugins must be added before the following line
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

" autosave
" http://blog.unixphilosopher.com/2015/02/a-more-betterer-autosave-in-vim.html
autocmd InsertLeave,TextChanged * if expand('%') != '' | update | endif

" bling/vim-airline
let g:airline_powerline_fonts = 1

" vim-scripts/Solarized
syntax on
set background=dark
let g:solarized_termtrans = 1
let g:solarized_visibility = "low"
let g:solarized_contrast = "low"
let g:solarized_termcolors = 16
colorscheme solarized

"  ##### Editor configurations #####
" show line numbers "
set number
" line numbers go from 0 to 99999 "
set numberwidth=5
" tab space set equal to 2 spaces "
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
" change the color of the matching paren "
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
" removes trailing whitespace on save "
autocmd BufWritePre * :%s/\s\+$//e

" Turn backup off (no .swap files)
set nobackup
set nowritebackup
set noswapfile

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

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

" quick save with space + w"
nnoremap <Leader>w :w<CR>
" copy and paste with <Space>y, <Space>p"
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" easymotion 2-word search
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

" jump to the end of a pasted text
vnoremap <silent> y y`
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" remapping control + movement to move between split panes"
noremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s

" terryma/vim-expand-region override
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" remap Esc to jj in insert mode"
inoremap jk <Esc>
inoremap kj  <Esc>

" Y: yank til $"
nnoremap Y y$

" Q: closes the window"
nnoremap Q :q<cr>

" U: Redos since 'u' undos
nnoremap U :redo<cr>
