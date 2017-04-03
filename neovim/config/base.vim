" Global mappings {{{

" space is my leader
let g:mapleader="\<Space>"

" Release keymappings for plug-in.
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
"}}}

" plugin-pre {{{

" set up my-auto-cmd
augroup mine
  au!
augroup END

" NOTE: glsl extensions must be set before the plugin is initialized
let g:glsl_file_extensions = '*.glsl,*.vert,*.frag'

" specific envs for neovim
" - https://neovim.io/doc/user/provider.html#provider-python
" - https://github.com/zchee/deoplete-jedi#virtual-environments
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " OSX
    let g:python_host_prog = '/usr/local/bin/python'
    let g:python3_host_prog = '/usr/local/bin/python3'
    let g:loaded_ruby_provider = 1
  endif
endif

"}}}

" Disable pre-bundled plugins {{{
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1

" enabled again to test scp (2017-02)
"
" let g:netrw_nogx = 1 " disable netrw's gx mapping.
" let g:loaded_netrw = 1
" let g:loaded_netrwPlugin = 1
" let g:loaded_netrwFileHandlers = 1
" let g:loaded_netrwSettings = 1
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

