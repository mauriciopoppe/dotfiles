" plugin configuration {{{

let g:deoplete#enable_at_startup=1
let g:deoplete#enable_smart_case=1
let g:deoplete#max_list=30

" Redraw candidates
inoremap <expr><C-l> deoplete#mappings#refresh()

" Disable deoplete on vim-multiple-cursors
function g:Multiple_cursors_before()
  let g:deoplete#disable_auto_complete = 1
endfunction
function g:Multiple_cursors_after()
  let g:deoplete#disable_auto_complete = 0
endfunction

" quiet messages in auto completion
if has("patch-7.4.314")
  set shortmess+=c
endif

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" let g:deoplete#omni#functions = {}
" let g:deoplete#omni#functions['javascript'] = [
"     \ 'tern#Complete'
"     \]

if !exists('g:deoplete#ignore_sources')
  let g:deoplete#ignore_sources = {}
endif
let g:deoplete#ignore_sources['html'] = ['omni']

if !exists('g:deoplete#sources')
  let g:deoplete#sources = {}
endif
let g:deoplete#sources['javascript.jsx'] = ['file', 'ternjs', 'ultisnips']

" context_filetype {{{

if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#same_filetypes = {}
endif
" In cpp buffers, completes from c buffers.
let g:context_filetype#same_filetypes.cpp = 'c'

" }}}

" }}}

" zchee/deoplete-clang {{{

" Required configuration:
" - path to libclang.dylib
" - path to clang headers

" bundled llvm_path
let s:llvm_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr'
" prefer homebrew instalation of llvm (latest version)
if !empty(glob('/usr/local/opt/llvm'))
  let s:llvm_path = '/usr/local/opt/llvm'
endif

" - llvm (installed with homebrew)
" let g:deoplete#sources#clang#libclang_path = '/usr/local/opt/llvm/lib/libclang.dylib'
" let g:deoplete#sources#clang#clang_header = '/usr/local/opt/llvm/lib/clang'

" - llvm (command line tools)
let g:deoplete#sources#clang#libclang_path = s:llvm_path . '/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = s:llvm_path . '/lib/clang'
let g:deoplete#sources#clang#sort_algo = 'priority'
let g:deoplete#sources#clang#std#cpp = 'c++11'

" }}}

" deoplete-ternjs {{{

function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

let g:tern_path = StrTrim(system('PATH=$(npm bin):$PATH && which tern'))

if g:tern_path != 'tern not found'
  " echo "using tern:" . g:tern_path
  let g:deoplete#sources#ternjs#tern_bin = g:tern_path
endif
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

"}}}

