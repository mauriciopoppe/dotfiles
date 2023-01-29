" }}}
" Disable default plugins "{{{

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

" " https://neovim.io/doc/user/starting.html#shada-file
" " shared data
" augroup MyAutoCmd
" 	autocmd CursorHold * if exists(':rshada') | rshada | wshada | endif
" augroup END

" vim: set ts=2 sw=2 tw=80 noet :
