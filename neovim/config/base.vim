" ------------------
" Vim Initialization
" ------------------

" Global Mappings "{{{
" , is the leader
" ; the secondary leader
let g:mapleader=","

" Release keymappings prefixes (remapped later)
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ,        <Nop>
xnoremap ,        <Nop>
nnoremap ;        <Nop>
xnoremap ;        <Nop>
nnoremap m        <Nop>
xnoremap m        <Nop>

" }}}
" Ensure required directories exist "{{{
if ! isdirectory(expand($VARPATH))
	" Create missing dirs i.e. cache/{undo,backup}
	call mkdir(expand('$VARPATH/undo'), 'p')
	call mkdir(expand('$VARPATH/backup'))
endif

" }}}
" load additional settings (file's not tracked by git) "{{{
if filereadable(expand('$VIMPATH/.vault.vim'))
	execute 'source' expand('$VIMPATH/.vault.vim')
endif

" }}}
" Load less plugins while SSHing to remote machines {{{
if len($SSH_CLIENT)
	let $VIM_MINIMAL = 1
endif

" }}}
" Disable default plugins "{{{

" Disable menu.vim
if has('gui_running')
  set guioptions=Mc
endif

" Disable pre-bundled plugins
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwSettings = 1
let g:loaded_rrhelper = 1
let g:loaded_ruby_provider = 1
let g:loaded_shada_plugin = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
" }}}
" GLSL syntax highlighting fix "{{{
let g:glsl_file_extensions = '*.glsl,*.vert,*.frag'
"}}}

" https://neovim.io/doc/user/starting.html#shada-file
" shared data
augroup MyAutoCmd
	autocmd CursorHold * if exists(':rshada') | rshada | wshada | endif
augroup END

" Search and use environments specifically made for Neovim.
if isdirectory($VARPATH.'/venv/neovim')
  let g:python_host_prog = $VARPATH.'/venv/neovim/bin/python'
endif

" vim: set ts=2 sw=2 tw=80 noet :
