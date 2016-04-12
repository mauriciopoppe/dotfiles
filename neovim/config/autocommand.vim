augroup fs
  au!
  autocmd InsertLeave,TextChanged * nested silent! :update
augroup END

augroup ft
  au!
  " spell check is on for markdown
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd FileType markdown setlocal spell
  autocmd FileType markdown set textwidth=0
augroup END

augroup versioncontrol
  "spell check when writing commit logs
  autocmd FileType svn,*commit* setlocal spell
augroup END

" vim whitespace per filetype
augroup indentation
  au!
  " autocmd Filetype cpp,c,h,glsl* setlocal ts=4 sts=4 sw=4
augroup end

" Enable omni completion.
augroup omnicompletion
  au!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

" close hidden buffers
command! -nargs=* Only call CloseHiddenBuffers()
function! CloseHiddenBuffers()
  let i = 0
  let n = bufnr('$')
  echo n
  while i < n
    let i = i + 1
    if bufloaded(i) == 0
      exe 'bd ' . i
    endif
  endwhile
endfun
