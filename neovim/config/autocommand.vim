augroup fs
  autocmd!
  " autosave
  " > mine
  " autocmd TextChangedI,TextChanged * nested silent! :update
  " > from vim-auto-save
  " " the following makes autosave also work on Insert mode"
  " autocmd CursorHoldI,CompleteDone * nested silent! :update
  " " update the app on CursorHold and BufLeave "
  autocmd CursorHold,BufLeave * nested silent! :update
  " autoread
  autocmd CursorHold * checktime
augroup END

augroup ft
  autocmd!
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd FileType markdown setlocal spell
  autocmd FileType markdown set textwidth=0

  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags

  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  autocmd Filetype Makefile setlocal noexpandtab

  "spell check when writing commit logs
  autocmd FileType svn,*commit* setlocal spell
augroup END

" vim whitespace per filetype
augroup indentation
  au!
  " autocmd Filetype cpp,c,h,glsl* setlocal ts=4 sts=4 sw=4
augroup end

" global functions {{{
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
"}}}
