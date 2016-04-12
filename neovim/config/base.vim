" Global mappings {{{

" spacebar is my leader
let g:mapleader="\<Space>"

" Release keymappings for plug-in.
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
"}}}

" set augroup "{{{
augroup mine
  au!
  " NOTE: glsl var set here because if set on the plugin-keys file it doesn't work
  let g:glsl_file_extensions = '*.glsl,*.vert,*.frag'
augroup END
"}}}

" Disable pre-bundled plugins {{{
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwSettings = 1
let g:loaded_rrhelper = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_gzip = 1
"}}}

