augroup mine
  " autosave
  " > mine
  " autocmd TextChangedI,TextChanged * nested silent! :update
  " > from vim-auto-save
  " " the following makes autosave also work on Insert mode"
  set updatetime=700
  " nested = :h autocmd-nested
  " silent = :h silent!
  autocmd CursorHold,BufLeave * nested silent! :update

  " autoread (updates the buffers when a file is modified outside vim)
  autocmd CursorHold * checktime

  " hide menu on special cases
  autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif
  " autocmd FileWritePre,FileWritePost,BufWritePre,BufWritePost <buffer> silent! :call utils#whitespace()<CR>

  " filetype specific
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd FileType markdown setlocal spell
  autocmd FileType markdown set textwidth=0

  " autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  " autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  " autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " function! SaveSesssion()
  "   exec 'Obsession!'
  "   exec 'Obsession'
  " endfunction
  " autocmd VimLeavePre * call SaveSesssion()
  " function! DiscardSession()
  "   exec 'Obsession'
  " endfunction
  " autocmd VimEnter * call DiscardSession()

  autocmd Filetype Makefile setlocal noexpandtab

  "spell check when writing commit logs
  autocmd FileType svn,*commit* setlocal spell

  " neomake
  autocmd! BufWritePost * Neomake

augroup END

