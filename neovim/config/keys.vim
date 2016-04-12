" Remap of defaults {{{
" treat long lines as break lines
noremap j gj
noremap k gk

" movement inside a line 
noremap H ^
noremap L $

" newline above/below the current doesn't put into insert mode
noremap <Enter> o<ESC>

" when jumping to the next match on search center the screen
noremap n nzz
noremap N Nzz

" when jumping forward/backward center the screen
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

" move to the end of the pasted text on copy/paste
vnoremap y y`]
vnoremap p "_dP`]

" avoid `c` from yanking to the default register
nnoremap c "xc
xnoremap c "xc

" fix cw and dw to behave the same way
nnoremap cw ce
nnoremap dw de

imap <C-c> <ESC>
vmap <C-c> <ESC>
nmap <C-c> <ESC>
cmap <C-c> <ESC>

" }}}

" Custom mappings {{{

" make Y behavior like D, and C
nnoremap Y y$

" quickly close a window
nnoremap Q :q<CR>

" since `u` undos `U` redos
nnoremap U :redo<CR>

" paste from the system clipboard
map <Leader>p :set paste<CR>"*]p:set nopaste<cr>
nmap <Leader>vr :source $MYVIMRC<cr>

" }}}

" Panes and buffers {{{

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

" }}}

" Moving lines of text {{{

" move a line in normal mode while fixing the indentation
nnoremap <silent> ∆ :m .+1<CR>==
nnoremap <silent> ˚ :m .-2<CR>==

" move lines in visual mode while fixing the indentation
vnoremap <silent> ∆ :m '>+1<CR>gv=gv
vnoremap <silent> ˚ :m '<-2<CR>gv=gv

" keep the selection after an indent operation
vnoremap > >gv
vnoremap <LT> <LT>gv

" }}}


