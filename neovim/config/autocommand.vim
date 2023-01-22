augroup mine
  " hide preview
  autocmd CompleteDone * pclose

  " highlight yank
  au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=1000, on_visual=true}
augroup END

augroup FTCheck
  autocmd!
  autocmd BufRead,BufNewFile *.md           set ft=markdown
  autocmd BufRead,BufNewFile *.pom          set ft=xml
  autocmd BufRead,BufNewFile .babelrc       set ft=json
  autocmd BufRead,BufNewFile *named.conf*   set ft=named
  autocmd BufRead,BufNewFile fluent.conf    set ft=fluentd
  autocmd BufRead,BufNewFile Brewfile       set ft=ruby
  autocmd BufRead,BufNewFile Dockerfile.*   set ft=dockerfile

  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx

  autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
  autocmd FileType python,xml,html,jsp setlocal ts=4 sts=4 sw=4
  autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
  autocmd FileType go setlocal ts=4 sts=4 sw=4
  autocmd FileType markdown setlocal ts=2 sts=2 sw=2

  " hide preview window
  " autocmd FileType go setlocal completeopt-=preview

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
  autocmd FileType svn,gitcommit setlocal spell

  autocmd FileType help setlocal ai fo+=2n | silent! setlocal nospell
  autocmd FileType help nnoremap <silent><buffer> q :q<CR>

  autocmd FileType markdown,terraform,python,zsh,sh setlocal wrap textwidth=0 wrapmargin=0

  autocmd FileType proto setlocal wrap textwidth=120 wrapmargin=0 ts=4 sw=4

augroup END

