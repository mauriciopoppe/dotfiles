" Interface {{{

" Unite {{{

" Initialization {{{

" Unite prefix
nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
nmap ; [unite]
xmap ; [unite]

" General
let g:unite_enable_auto_select = 1
let g:unite_matcher_fuzzy_max_input_length = 25
let g:unite_kind_jump_list_after_jump_scroll = 50

" unite meta
let g:unite_data_directory='~/.unite'
" syntax highlight
let g:unite_source_line_enable_highlight=1
" start in insert mode
let g:unite_enable_start_insert=1
" tags length (right sidebar)
let g:unite_source_tag_max_name_length = 30
let g:unite_source_tag_max_fname_length = 30
" mru limits
let g:neomru#file_mru_limit = 500
let g:neomru#directory_mru_limit = 15
" recursive search limits
let g:unite_source_rec_unit = 3000
let g:unite_source_rec_min_cache_files = 200
let g:unite_source_rec_max_cache_files = 25000

" NOTE: for specific project ignores use .agignore
let s:my_ag_ignores = [
  \ '.git', '.svn', '.idea', 'node_modules', 'bower_modules', '.tmp',
  \ '.sass-cache']
let g:my_ag_opts = get(g:, 'my_ag_opts', []) + [
  \ '--vimgrep', '--smart-case', '--skip-vcs-ignores', '--hidden' ]
for item in s:my_ag_ignores
  let g:my_ag_opts += ['--ignore', item]
endfor

if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts= join(g:my_ag_opts)
  let g:unite_source_grep_recursive_opts=''
  let g:unite_source_rec_async_command = ['ag', '--follow', '-g', ''] + g:my_ag_opts
elseif executable('ack')
  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts = '-i --noheading --nocolor -k -H'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_rec_async_command = [ 'ack', '-f', '--nofilter' ]
endif

" }}}

" Unite profiles {{{

" global default context
call unite#custom#profile('default', 'context', {
      \   'safe': 0,
      \   'start_insert': 1,
      \   'short_source_names': 1,
      \   'update_time': 500,
      \   'direction': 'topleft',
      \   'winwidth': 40,
      \   'winheight': 15,
      \   'max_candidates': 100,
      \   'no_auto_resize': 1,
      \   'vertical_preview': 1,
      \   'cursor_line_time': '0.10',
      \   'hide_icon': 0,
      \   'candidate-icon': ' ',
      \   'marked_icon': '✓',
      \   'prompt' : '> '
      \ })

call unite#custom#profile('register', 'context', {
      \ 'start_insert': 0,
      \ 'default_action': 'append'
      \ })

call unite#custom#profile('source/source', 'context', {
      \   'vertical': 1,
      \   'winwidth': 80,
      \   'prompt_direction': 'top',
      \   'direction': 'botright',
      \ })

call unite#custom#profile('completion', 'context', {
      \   'winheight': 25,
      \   'prompt_direction': 'top',
      \   'direction': 'botright',
      \   'no_here': 1
      \ })

call unite#custom#profile('mpc', 'context', {
      \   'start_insert': 0,
      \   'quit': 1,
      \   'keep_focus': 1,
      \   'winheight': 20,
      \ })

call unite#custom#profile('source/outline', 'context', {
      \   'vertical': 1,
      \   'direction': 'botright',
      \   'prompt_direction': 'top',
      \   'start_insert': 0,
      \   'no_uit': 1,
      \   'toggle': 1,
      \   'auto_highlight': 0,
      \ })

call unite#custom#profile('navigate,source/grep', 'context', {
      \   'silent': 1,
      \   'start_insert': 0,
      \   'winheight': 20,
      \   'no_quit': 1,
      \   'no_empty': 1,
      \   'keep_focus': 1,
      \   'direction': 'botright',
      \   'prompt_direction': 'top',
      \ })

" matchers, converters and filters
call unite#custom#source(
  \ 'file_rec,file_rec/async,file_rec/git,file_rec/neovim',
  \ 'matchers',
  \ ['converter_relative_word', 'matcher_fuzzy', 'matcher_hide_hidden_files'])

call unite#custom#source(
  \ 'file_rec,file_rec/async,file_rec/neovim',
  \ 'converters',
  \ ['coverter_uniq_word'])
" \ ['converter_file_directory'])

call unite#filters#sorter_default#use(['sorter_rank'])
" }}}

" Custom menus {{{
let g:unite_source_menu_menus={}

let g:unite_source_menu_menus.mine = {
      \     'description' : 'utility stuff'
      \}
let g:unite_source_menu_menus.mine.command_candidates = [
      \       ['Markdown keyboard', 'call utils#kbd()'],
      \       ['Strip trailing whitespace', 'call utils#preserve("%s/\\s\\+$//e")'],
      \       ['Standard fix', 'call utils#standardFormat()'],
      \       ['UnMinify JS code', 'call utils#UnMinify()'],
      \     ]

" }}}

" Unite buffer key bindings {{{

function! s:unite_settings()
  silent! nunmap <buffer> <Space>
  silent! nunmap <buffer> <C-h>
  silent! nunmap <buffer> <C-k>
  silent! nunmap <buffer> <C-l>
  silent! nunmap <buffer> <C-r>

  nmap <silent><buffer> <C-r> <Plug>(unite_redraw)
  nmap <silent><buffer> '     <Plug>(unite_toggle_mark_current_candidate)
  nmap <silent><buffer> e     <Plug>(unite_do_default_action)
  nnoremap <silent><buffer> <Tab>  <C-w>w

  " never exit with :quit or :close as it breaks the layout
  nmap <buffer> <Esc> <Plug>(unite_exit)
  imap <buffer> <Esc> <Plug>(unite_exit)
  nmap <buffer> <C-c> <Plug>(unite_exit)

  imap <buffer> <Tab> <Plug>(unite_complete)
endfunction
autocmd mine FileType unite call s:unite_settings()

" }}}

" list (all sources available)
nnoremap <silent> [unite]u :Unite source<CR>

" list files recursively ([o]pen files)
" nnoremap <silent> [unite]f :Unite file_rec/async:!<CR>
" list open [b]uffers (and also [m]ost[r]ecent[u]sed files and
" bookmarks)
nnoremap <silent> [unite]b :Unite buffer file_mru bookmark<CR>
" show outline (symbols)
nnoremap <silent> [unite]o :Unite outline<CR>
" list [t]ags
nnoremap <silent> [unite]t :Unite tag<CR>
nnoremap <silent> [unite]T :Unite tag/include<CR>
" list [l]ocation list
nnoremap <silent> [unite]l :Unite location_list<CR>
" list [L]ines on current buffer
nnoremap <silent> [unite]L :Unite line<CR>
" list [q]uickfix
nnoremap <silent> [unite]q :Unite quickfix<CR>
" list [y]ank history
nnoremap <silent> [unite]y :Unite history/yank<CR>
" list opened [w]indow splits
nnoremap <silent> [unite]w :Unite window<CR>
" list register/yank
nnoremap <silent> [unite]h :Unite -buffer-name=register register history/yank<CR>
" list normal mappings (useful when editing my .vimrc)
nnoremap <silent> [unite]ma :Unite mapping<CR>
" list inside my commands
nnoremap <silent> [unite]me :Unite menu:mine<CR>
" list in [r]egisters
nnoremap <silent> [unite]r :Unite register<CR>

" open Unite with word under the cursor
" search for term (grep)
nnoremap <silent> [unite]gg :Unite grep:.<CR>
nnoremap <silent> [unite]gw :UniteWithCursorWord grep:. -profile-name=navigate<CR>
nnoremap <silent> [unite]gf :UniteWithCursorWord file_rec/async -profile-name=navigate<CR>
nnoremap <silent> [unite]gt :UniteWithCursorWord tag<CR>

function! UltiSnipsCallUnite()
  Unite -immediately -no-empty ultisnips
  return ''
endfunction

" inoremap <silent> <C-s> <C-R>=(pumvisible()? "\<LT>C-s>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>

" Shougo/denite {{{

" " Change file_rec command.
" call denite#custom#var('file_rec', 'command',
" \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
" " For ripgrep
" " Note: It is slower than ag
" call denite#custom#var('file_rec', 'command',
" \ ['rg', '--files'])
" " Change mappings.
" call denite#custom#map('_', "\<C-j>", 'move_to_next_line')
" call denite#custom#map('_', "\<C-k>", 'move_to_prev_line')
" " Change matchers.
" call denite#custom#source(
" \ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
" call denite#custom#source(
" \ 'file_rec', 'matchers', ['matcher_cpsm'])
" " Add custom menus
" let s:menus = {}
" let s:menus.zsh = {
"         \ 'description': 'Edit your import zsh configuration'
"         \ }
" let s:menus.zsh.file_candidates = [
"         \ ['zshrc', '~/.config/zsh/.zshrc'],
"         \ ['zshenv', '~/.zshenv'],
"         \ ]
" let s:menus.my_commands = {
"         \ 'description': 'Example commands'
"         \ }
" let s:menus.my_commands.command_candidates = [
"         \ ['Split the window', 'vnew'],
"         \ ['Open zsh menu', 'Denite menu:zsh'],
"         \ ]
" call denite#custom#var('menu', 'menus', s:menus)
" " Ack command on grep source
" call denite#custom#var('grep', 'command', ['ack'])
" call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('grep', 'final_opts', [])
" call denite#custom#var('grep', 'separator', [])
" call denite#custom#var('grep', 'default_opts',
"                 \ ['--ackrc', $HOME.'/.ackrc', '-H',
"                 \ '--nopager', '--nocolor', '--nogroup', '--column'])
" " Ripgrep command on grep source
" call denite#custom#var('grep', 'command', ['rg'])
" call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('grep', 'final_opts', [])
" call denite#custom#var('grep', 'separator', ['--'])
" call denite#custom#var('grep', 'default_opts',
"   \ ['--vimgrep', '--no-heading']

" }}}


" }}}

" FZF {{{

nnoremap <silent> [unite]f :Files .<CR>

" fzf-vim {{{

" let g:fzf_files_options = '--reverse'
let g:fzf_files_options =
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_buffers_jump = 1

" }}}

" }}}

" VimFiler {{{

" Initialization {{{
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = [
      \ '^\.DS_Store$',
      \ '^\.git$',
      \ '^\.sass-cache$',
      \ '^\.idea$',
      \ '^\.vagrant$',
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
autocmd mine FileType vimfiler call s:vimfiler_settings()

" }}}

" [e]xplorer
nnoremap <silent> [unite]e :<C-u>execute 'VimFiler -buffer-name=explorer'<CR>
" [f]ile [r]eveal in explorer
nnoremap <silent> [unite]a :<C-u>execute 'VimFiler -buffer-name=explorer -find'<CR>

" }}}

" Deoplete {{{

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

"}}}

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


" }}}

" neomake {{{

" let g:neomake_open_list = 2
" let g:neomake_typescript_enabled_makers = ['tsc', 'tslint']
" let g:neomake_verbose=3
" let g:neomake_logfile='/tmp/error.log'
" let g:neomake_typescript_tsc_maker = {
"       \ 'args': ['--noEmit'],
"       \ 'append_file': 0,
"       \ 'cwd': '%:p:h',
"       \ 'errorformat':
"           \ '%E%f %#(%l\,%c): error %m,' .
"           \ '%E%f %#(%l\,%c): %m,' .
"           \ '%Eerror %m,' .
"           \ '%C%\s%\+%m'
"       \ }
" let g:neomake_warning_sign = {
"   \ 'text': 'W',
"   \ 'texthl': 'WarningMsg',
"   \ }
" let g:neomake_error_sign = {
"   \ 'text': 'E',
"   \ 'texthl': 'ErrorMsg',
"   \ }
" let g:neomake_typescript_enabled_makers = ['tsc']
" let g:neomake_typescript_tslint_maker = {
"       \ 'args': ['-c', 'tslint.conf', '--verbose', 'x'],
"       \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
"       \ }

" }}}

" Lightline {{{

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
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
" }}}

" vim-indent-guides {{{

let g:indent_guides_auto_colors = 0
nmap <silent> <Leader>ig <Plug>IndentGuidesToggle
augroup mine
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=NONE ctermbg=235
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=NONE ctermbg=236
augroup END

"}}}

" vim-signify {{{

" priority list, means that what's first is also loaded before the actual vcs
let g:signify_vcs_list = [ 'svn', 'git' ]

"}}}

" Navigation {{{

" easymotion/vim-easymotion {{{

let g:EasyMotion_do_mapping=0 " Disable default mappings
nmap <Leader>ss <Plug>(easymotion-s2)

" }}}

" rhysd/clever-f {{{

let g:clever_f_ignore_case=1

" }}}

" tyru/open-browser {{{

nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" }}}

" bkad/CamelCaseMotion {{{

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge

noremap <silent> <leader>w w
noremap <silent> <leader>b b
noremap <silent> <leader>e e
noremap <silent> <leader>ge ge

sunmap w
sunmap b
sunmap e
sunmap ge

" }}}

"}}}

" Integration with external commands {{{

" tpope/vim-fugitive {{{

nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gl :exe ':!cd ' . expand('%:p:h') . '; git lg'<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push --tags<CR>

" }}}

" bemills/vimux {{{

" Executes a command in a tmux split, if there's one available run it there
noremap <Leader>vp :VimuxPromptCommand<CR>
" Execute last command
noremap <Leader>vl :VimuxRunLastCommand<CR>
" Moves to the pane created by tmux and enters copy mode
noremap <Leader>vi :VimuxInspectRunner<CR>
" run last command (no need for an initial call to Vimux)
noremap <silent> <Leader><CR> :call utils#runLastCommand()<CR>

" " npm test
" noremap <Leader>vnt :VimuxRunCommand("npm test")<CR>
" " make & run for learnopengl.com
" noremap <Leader>vm :VimuxRunCommand("make")<CR>

" }}}

" rizzati/dash.vim {{{

" searches in dash for the word under the cursor (considering the context)
" [d]ocs
nmap <silent> <leader>dd <Plug>DashSearch
" prompt to search for a word
" [d]ocs [s]earch
nmap <leader>ds :<C-u>Dash<space>

" }}}

" ? Neomake {{{

let g:neomake_verbose=0
let g:neomake_warning_sign={
      \ 'text': '>',
      \ 'texthl': 'WarningMsg',
      \ }
let g:neomake_error_sign={
      \ 'text': '>',
      \ 'texthl': 'ErrorMsg',
      \ }
let g:neomake_javascript_enabled_makers = ['standard']

" }}}
"
"}}}

" Code manipulation {{{

" mattn/emmet-vim {{{

" let g:user_emmet_leader_key = '<C-e>'
let g:user_emmet_settings = {
\    'html': {
\        'empty_element_suffix': ' />',
\        'indent_blockelement': 1,
\    },
\}
imap <silent> <C-e>, <plug>(emmet-expand-abbr)
imap <silent> <C-e>. <plug>(emmet-expand-abbr)<plug>(emmet-split-join-tag)f/i
" }}}

" terryma/vim-expand-region {{{

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" }}}

" vimwiki/vimwiki {{{
let g:vimwiki_list = [{'path': '~/Documents/notes/wiki/', 'path_html': '~/public_html/'}]

autocmd FileType vimwiki map <buffer> <Leader>c <Plug>VimwikiToggleListItem
" }}}

" vim-simple-todo {{{

let g:simple_todo_map_keys = 0
nmap <c-g>t <Plug>(simple-todo-new)
imap <c-g>t <Plug>(simple-todo-new)
" nmap <leader>to <Plug>(simple-todo-below)
nmap <c-g>x <Plug>(simple-todo-mark-switch)
imap <c-g>x <Plug>(simple-todo-mark-switch)

"}}}

" }}}

" Language highlighting {{{

" plasticboy/vim-markdown {{{

let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1

" }}}

" elzr/vim-json {{{

" disable the suppression of quotes in .json files
let g:vim_json_syntax_conceal = 0

" }}}

" mxw/vim-jsx {{{

" also enable on files that don't have the .jsx extension
let g:jsx_ext_required = 0

" }}}

" typescript-vim {{{

let g:typescript_indent_disable = 1
" autocmd QuickFixCmdPost [^l]* nested cwindow
" autocmd QuickFixCmdPost    l* nested lwindow

"}}}

"}}}

" Other {{{

" vim-localvimrc {{{

let g:localvimrc_ask = 0

" }}}

" SirVer/ultisnips {{{
let g:UltiSnipsUsePythonVersion = 3

" Disable built-in cx-ck to be able to go backward
inoremap <C-x><C-k> <NOP>
" snippet expansion, default triggers
" - expand <tab>
" - jump forward <c-j>
" - jump backward <c-k>
" let g:UltiSnipsExpandTrigger="<C-q>"
" let g:UltiSnipsJumpForwardTrigger="<NOP>"
" let g:UltiSnipsJumpBackwardTrigger="<NOP>"

" }}}

" }}}

