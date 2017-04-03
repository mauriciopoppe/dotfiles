source $SSHHOME/.sshrc.d/base.vim
source $SSHHOME/.sshrc.d/general.vim
source $SSHHOME/.sshrc.d/key-bindings.vim

" use netrw on ssh
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END
