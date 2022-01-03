let g:lightline = {
      \ 'colorscheme': 'hybrid',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'fugitive', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'cocstatus': 'coc#status',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }
function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '[RO]' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    " NOTE: patch font to add an awesome branch symbol
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" lua << END
" require'lualine'.setup {
"   options = {
"     icons_enabled = true,
"     theme = 'auto',
"     component_separators = { left = '', right = ''},
"     section_separators = { left = '', right = ''},
"     disabled_filetypes = {},
"     always_divide_middle = true,
"   },
"   sections = {
"     lualine_a = {'mode'},
"     lualine_b = {'branch', 'diff', 'diagnostics'},
"     lualine_c = {'filename'},
"     lualine_x = {'encoding', 'fileformat', 'filetype'},
"     lualine_y = {'progress'},
"     lualine_z = {'location'}
"   },
"   inactive_sections = {
"     lualine_a = {},
"     lualine_b = {},
"     lualine_c = {'filename'},
"     lualine_x = {'location'},
"     lualine_y = {},
"     lualine_z = {}
"   },
"   tabline = {},
"   extensions = {}
" }
" END
