" Initialization {{{
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = [
      \ '^\.DS_Store$',
      \ '^\.git$',
      \ '^\.sass-cache$',
      \ '^\.idea$',
      \ '^\.vagrant$',
      \ '^\.cache$',
      \ '^__pycache__$',
      \ '^venv$',
      \ '\.pyc$',
      \ '^node_modules$']

let g:vimfiler_force_overwrite_statusline = 0
let g:vimfiler_quick_look_command = 'qlmanage -p'
let g:vimfiler_tree_leaf_icon = ' '
" }}}

" Profiles {{{
call vimfiler#custom#profile('default', 'context', {
      \  'safe': 0,
      \  'status': 1,
      \  'winwidth': 25,
      \  'explorer': 1,
      \  'auto_expand': 1,
      \  'no_quit': 1,
      \  'force_hide': 1,
      \  'parent': 0,
      \  'split': 1,
      \  'toggle': 1
      \ })
" }}}

" Vimfiler key bindings {{{
function! s:vimfiler_settings()
  setlocal nonumber norelativenumber

  nunmap <buffer> <space>
  nunmap <buffer> <Enter>
  nunmap <buffer> <C-l>
  nunmap <buffer> <C-j>
  nunmap <buffer> gr
  nunmap <buffer> -

  " avoid "choose >" screen
  nnoremap <silent><buffer><expr> e  vimfiler#do_action('open')

  nnoremap <silent><buffer><expr> \  vimfiler#do_action('vsplit')
  nnoremap <silent><buffer><expr> -  vimfiler#do_action('split')

  nmap <buffer> <ESC>  <Plug>(vimfiler_hide)
  nmap <buffer> <C-c>  <Plug>(vimfiler_hide)
  nmap <buffer> ?      <Plug>(vimfiler_help)

  nmap <buffer> '      <Plug>(vimfiler_toggle_mark_current_line)
  nmap <buffer> v      <Plug>(vimfiler_quick_look)
  nmap <buffer> V      <Plug>(vimfiler_clear_mark_all_lines)
  nmap <buffer> i      <Plug>(vimfiler_switch_to_history_directory)
  nmap <buffer> <C-r>  <Plug>(vimfiler_redraw_screen)
endfunction
autocmd FileType vimfiler call s:vimfiler_settings()

" }}}

" [e]xplorer
nnoremap <silent> <LocalLeader>e :<C-u>execute 'VimFiler -buffer-name=explorer'<CR>
" [f]ile [r]eveal in explorer
nnoremap <silent> <LocalLeader>a :<C-u>execute 'VimFiler -buffer-name=explorer -find'<CR>

