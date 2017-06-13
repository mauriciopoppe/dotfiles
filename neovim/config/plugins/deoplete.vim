" plugin configuration {{{

let g:deoplete#enable_at_startup=1
let g:deoplete#enable_smart_case=1
let g:deoplete#max_list=30

" Disable deoplete on vim-multiple-cursors
function g:Multiple_cursors_before()
  let g:deoplete#disable_auto_complete = 1
endfunction
function g:Multiple_cursors_after()
  let g:deoplete#disable_auto_complete = 0
endfunction

" if !exists('g:deoplete#omni#input_patterns')
"   let g:deoplete#omni#input_patterns = {}
" endif

" if !exists('g:deoplete#ignore_sources')
"   let g:deoplete#ignore_sources = {}
" endif
" let g:deoplete#ignore_sources['html'] = ['omni']

" }}}

if utils#hasPlugin('context_filetype') "{{{
  if !exists('g:context_filetype#same_filetypes')
    let g:context_filetype#same_filetypes = {}
  endif
  " In cpp buffers, completes from c buffers.
  let g:context_filetype#same_filetypes.cpp = 'c'
endif
" }}}

if utils#hasPlugin('deoplete-clang') "{{{
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
endif
"}}}

if utils#hasPlugin('deoplete-go') "{{{
  let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
  let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
  let g:deoplete#sources#go#use_cache = 1
endif
"}}}

if utils#hasPlugin('deoplete-ternjs') "{{{
  function! StrTrim(txt)
    return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
  endfunction

  " javascript
  let g:deoplete#sources#javascript = ['file', 'ternjs', 'ultisnips']
  let g:deoplete#sources#jsx = ['file', 'ternjs', 'ultisnips']

  let g:tern_path = StrTrim(system('PATH=$(npm bin):$PATH && which tern'))

  if g:tern_path != 'tern not found'
    " echo "using tern:" . g:tern_path
    let g:deoplete#sources#ternjs#tern_bin = g:tern_path
  endif
  let g:tern_request_timeout = 1
  let g:tern_show_signature_in_pum = '0'
  let g:tern#command = ["tern"]
  let g:tern#arguments = ["--persistent"]
endif
"}}}
