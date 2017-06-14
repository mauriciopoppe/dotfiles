" Defaults remap {{{

" treat long lines as break lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" when jumping to the next match on search center the screen
nnoremap n nzz
nnoremap N Nzz

" when jumping forward/backward center the screen
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

" when deleting, don't use the same registy as yank
" nnoremap d "xd
" vnoremap d "xd

" move to the end of the pasted text on copy/paste
vnoremap y y`]
vnoremap p "_dP`]

" avoid `c` from yanking to the default register
nnoremap c "xc
xnoremap c "xc

" fix cw and dw to behave the same way
nnoremap cw ce
nnoremap dw de

" <C-c> to exit from any mode to normal mode
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

" start an external command with a single bang
nnoremap ! :!

" keep the selection after an indent operation
vnoremap > >gv|
vnoremap < <gv

" quick way to reload vim
nnoremap <leader>sv :so $MYVIMRC<CR>

" run last command (no need for an initial call to Vimux)
noremap <silent> <Leader><CR> :call utils#runLastCommand()<CR>

" open page in chrome (OSX only)
nnoremap <leader>oc :exec ':silent !open % -a Google\ Chrome'

" }}}

" Panes and buffers {{{

" remapping control + movement to move between split panes
" set by vim-tmux-navigation so there's not need to set them here
" nnoremap <c-j> <c-w><c-j>
" nnoremap <c-k> <c-w><c-k>
" nnoremap <c-l> <c-w><c-l>
" nnoremap <c-h> <c-w><c-h>

" space + \ = create a new vertical pane (the | key is over \)
" space + - = create a new horizontal pane
nnoremap <leader>\ <c-w>v<c-w>l
nnoremap <leader>- <c-w>s

" }}}

" https://github.com/christoomey/vim-tmux-navigator/issues/71
if has('nvim')
    nmap <silent> <BS> :<C-u>TmuxNavigateLeft<CR>
else
    nmap <C-h> <C-w>h
endif

" Moving lines of text {{{

" move a line in normal mode while fixing the indentation
nnoremap <silent> ∆ :m .+1<CR>==
nnoremap <silent> ˚ :m .-2<CR>==

" move lines in visual mode while fixing the indentation
vnoremap <silent> ∆ :m '>+1<CR>gv=gv
vnoremap <silent> ˚ :m '<-2<CR>gv=gv

" movement inside a line
" ˙ = alt + h (move to the beginning of the line)
nnoremap ˙ ^
" ¬ = alt + l (move to the end of the line)
nnoremap ¬ $

function! DeleteInactiveBufs()
  "From tabpagebuflist() help, get a list of all buffers in all tabs
  let tablist = []
  for i in range(tabpagenr('$'))
    call extend(tablist, tabpagebuflist(i + 1))
  endfor

  "Below originally inspired by Hara Krishna Dara and Keith Roberts
  "http://tech.groups.yahoo.com/group/vim/message/56425
  let nWipeouts = 0
  for i in range(1, bufnr('$'))
    if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
      "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
      silent exec 'bwipeout' i
      let nWipeouts = nWipeouts + 1
    endif
  endfor
  echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bdi :call DeleteInactiveBufs()
command! Only :call DeleteInactiveBufs()

" }}}

" quickfix {{{
" alt + <
map ≤ :cprevious<CR>
" alt + ,s,s,s,su
map ≥ :cnext<CR>
nnoremap <leader>q :cclose<CR>
" }}}

