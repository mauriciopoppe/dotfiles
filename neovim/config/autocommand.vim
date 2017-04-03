augroup mine
  " autosave
  " > mine
  " autocmd TextChangedI,TextChanged * nested silent! :update
  " > from vim-auto-save
  " nested = :h autocmd-nested
  " silent = :h silent!
  autocmd CursorHold,BufLeave * nested silent! :update

  " autoread (updates the buffers when a file is modified outside vim)
  autocmd CursorHold * checktime

  " hide menu on special cases
  autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

  autocmd BufWritePost * Neomake
  autocmd BufWritePre * :call utils#whitespace()
augroup END

augroup FTCheck
  autocmd!
  autocmd BufRead,BufNewFile *.md           set ft=markdown
  autocmd BufRead,BufNewFile *.pom          set ft=xml
  autocmd BufRead,BufNewFile .babelrc       set ft=json
  autocmd BufNewFile,BufRead *named.conf*   set ft=named
  autocmd BufRead,BufNewFile fluent.conf    set ft=fluentd
  autocmd BufRead,BufNewFile Brewfile       set ft=ruby
augroup END

augroup FTOptions
  autocmd!
  autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
  autocmd FileType liquid,markdown,text,txt setlocal tw=78 linebreak nolist
  autocmd FileType python,xml,html,jsp setlocal ts=4 sts=4 sw=4
  autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>

  " in makefiles, don't expand tabs to spaces, since actual tab characters are
  " needed, and have indentation at 8 chars to be sure that all indents are tabs
  " (despite the mappings later):
  autocmd FileType make         setlocal noexpandtab ts=4 sw=4 sts=4

  " alternative: set no limit on the text width
  " autocmd FileType markdown set textwidth=0
  autocmd FileType apache       setlocal commentstring=#\ %s

  " <C-x>! sets the shebang
  autocmd FileType sh,zsh,csh,tcsh inoremap <silent> <buffer> <C-X>! #!/bin/<C-R>=&ft<CR>

  "spell check when writing commits
  autocmd FileType git,gitcommit setlocal foldmethod=syntax foldlevel=1
  autocmd FileType svn,gitcommit  setlocal spell

  autocmd FileType help setlocal ai fo+=2n | silent! setlocal nospell
  autocmd FileType help nnoremap <silent><buffer> q :q<CR>
augroup END

