" Unite {{{

" Taken from https://github.com/rafi/vim-config/blob/master/config/plugins/unite.vim

" Initialization {{{

" matcher settings
call unite#filters#matcher_default#use(['matcher_fuzzy', 'matcher_hide_current_file'])
call unite#filters#sorter_default#use(['sorter_rank'])

let g:ag_opts = get(g:, 'g:ag_opts', []) + [
    \ '--vimgrep', '--skip-vcs-ignores', '--hidden',
    \ '--ignore', '.git',
    \ '--ignore', '.idea',
    \ '--ignore', '.stversions',
    \ '--ignore', '.sass-cache',
    \ '--ignore', 'bower_modules',
    \ '--ignore', 'node_modules',
    \ ]

if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts=join(g:ag_opts)
  let g:unite_source_grep_recursive_opts=''
  let g:unite_source_rec_async_command = ['ag', '--follow', '-g', ''] + g:ag_opts
elseif executable('ack')
  let g:unite_source_rec_async_command = [ 'ack', '-f', '--nofilter' ]
endif

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
      \   'no_quit': 1,
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
" }}}

" Custom menus {{{
let g:unite_source_menu_menus={}

" Git menu
let g:unite_source_menu_menus.git = {
      \     'description' : 'Git commands',
      \ }
let g:unite_source_menu_menus.git.command_candidates = [
      \       ['Stage hunk', 'GitGutterStageHunk'],
      \       ['Unstage hunk', 'GitGutterRevertHunk'],
      \       ['Stage', 'Gwrite'],
      \       ['Status', 'Gstatus'],
      \       ['Diff', 'Gvdiff'],
      \       ['Commit', 'Gcommit --verbose'],
      \       ['Revert', 'Gread'],
      \       ['Log', 'Glog'],
      \       ['Visual Log', 'Gitv'],
      \     ]

let g:unite_source_menu_menus.mine = {
      \     'description' : 'utility stuff'
      \}
let g:unite_source_menu_menus.mine.command_candidates = [
      \       ['Markdown keyboard', 'call utils#kbd()'],
      \       ['Strip trailing whitespace', 'call utils#preserve("%s/\\s\\+$//e")']
      \     ]

" }}}

" Navigation key bindings {{{

function! s:unite_settings()
  silent! nunmap <buffer> <Space>
  silent! nunmap <buffer> <C-h>
  silent! nunmap <buffer> <C-k>
  silent! nunmap <buffer> <C-l>
  silent! nunmap <buffer> <C-r>

  nmap <silent><buffer> <C-r> <Plug>(unite_redraw)
  imap <silent><buffer> <C-j> <Plug>(unite_select_next_line)
  imap <silent><buffer> <C-k> <Plug>(unite_select_previous_line)
  nmap <silent><buffer> '     <Plug>(unite_toggle_mark_current_candidate)
  nmap <silent><buffer> e     <Plug>(unite_do_default_action)
  nnoremap <silent><buffer> <Tab>  <C-w>w

  nmap <buffer> <Esc> <Plug>(unite_exit)
  imap <buffer> <Esc> <Plug>(unite_exit)
  nmap <buffer> <C-c> <Plug>(unite_exit)

  imap <buffer> <Tab> <Plug>(unite_complete)
endfunction
autocmd FileType unite call s:unite_settings()

" }}}

" Sources {{{

" sources (all menus available)
nnoremap <silent> <leader>u :Unite source<CR>

" search files recursively ([o]pen files)
nnoremap <silent> <leader>o :Unite file_rec/async:!<CR>
" search between open [b]uffers
nnoremap <silent> <leader>b :Unite buffer file_mru bookmark<CR>
" search in current outline ([t]ags)
nnoremap <silent> <leader>t :Unite outline<CR>
" search in [l]ines on current buffer
nnoremap <silent> <leader>l :Unite line<CR>
" search in [y]ank history
nnoremap <silent> <leader>y :Unite history/yank<CR>
" search in opened [w]indow splits
nnoremap <silent> <leader>w :Unite window<CR>
" unite menu for my stuff
nnoremap <silent> <leader>m :Unite menu:mine<CR>
" search in [r]egisters
nnoremap <silent> <leader>r :Unite register<CR>

" open Unite with word under the cursor
" search for term (grep)
nnoremap <silent> <leader>/ :Unite -silent grep:.<CR>
nnoremap <silent> <Leader>/o :UniteWithCursorWord file_rec/async -profile-name=navigate<CR>
nnoremap <silent> <Leader>/w :UniteWithCursorWord grep:. -profile-name=navigate<CR>

function! UltiSnipsCallUnite()
  Unite -immediately -no-empty ultisnips
  return ''
endfunction

inoremap <silent> <C-e> <C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>
" }}}

" }}}

" VimFiler {{{

" Initialization {{{
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern =
    \ '^\%(\.git\|\.idea\|\.DS_Store\|\.vagrant\|.stversions'
    \ .'\|node_modules\|.*\.pyc\|.*\.egg-info\|__pycache__\)$'

let g:vimfiler_quick_look_command = 'qlmanage -p'
let g:vimfiler_tree_leaf_icon = ' '
" }}}

" Profiles {{{
call vimfiler#custom#profile('default', 'context', {
    \  'safe': 0,
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

" Navigation keybindings {{{
function! s:vimfiler_settings()
  setlocal nonumber norelativenumber

  nunmap <buffer> <Space>
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
nnoremap <silent> <leader>e :<C-u>execute 'VimFiler -buffer-name=explorer'<CR>
" [f]ile [r]eveal in explorer
nnoremap <silent> <leader>fr :<C-u>execute 'VimFiler -buffer-name=explorer -find'<CR>

" }}}

" Lightline {{{

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'tab': {
      \   'active': [ 'tabnum', 'filename', 'modified' ],
      \   'inactive': [ 'tabnum', 'filename', 'modified' ]
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }
" }}}

" Neomake {{{

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

" Vim markdown {{{

let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_folding_disabled=1

" }}}

" Tmuxline {{{

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#I #W',
      \'x'    : [
      \'#(osascript ${DOTFILES_DIRECTORY}/applescripts/spotify.scpt)',
      \'#(bash ${DOTFILES_DIRECTORY}/bin/battery_left.sh)'
      \],
      \'y'    : ['%a %b %d', '%R'],
      \'z'    : '#H'}

" }}}

" Easymotion {{{

let g:EasyMotion_do_mapping=0 " Disable default mappings
nmap <Leader>s <Plug>(easymotion-s2)

" }}}

" Expand region {{{

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" }}}

" Vimux {{{

" Executes a command in a tmux split, if there's one available run it there
noremap <Leader>vp :VimuxPromptCommand<CR>
" Execute last command
noremap <Leader>vl :VimuxRunLastCommand<CR>
" Moves to the pane created by tmux and enters copy mode
noremap <Leader>vi :VimuxInspectRunner<CR>
" npm test
noremap <Leader>vnt :VimuxRunCommand("npm test")<CR>
" make & run for learnopengl.com
noremap <Leader>vm :VimuxRunCommand("make")<CR>

" }}}

" NERDTree {{{

" similar to sublime text
" nnoremap <Leader>kb :NERDTreeToggle<CR>
" nnoremap <Leader>kr :NERDTreeFind<CR>
" let g:NERDTreeShowHidden=1
" let g:NERDTreeMinimalUI=1
" let g:NERDTreeAutoDeleteBuffer=1

" }}}

" Deoplete {{{

let g:deoplete#enable_at_startup=1
let g:deoplete#enable_smart_case=1
let g:deoplete#max_list=50

" Movement within 'ins-completion-menu'
" imap <expr><C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
" imap <expr><C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"

" Redraw candidates
inoremap <expr><C-l> deoplete#mappings#refresh()

" quiet messages in auto completion
if has("patch-7.4.314")
  set shortmess+=c
endif

" let g:ulti_jump_forwards_res=0
" function! Can_jump_forward()
"   call UltiSnips#JumpForwards()
"   return g:ulti_jump_forwards_res
" endfunction

" let g:ulti_jump_backwards_res=0
" function! Can_jump_backward()
"   call UltiSnips#JumpBackwards()
"   return g:ulti_jump_backwards_res
" endfunction

" inoremap <silent><C-j> <C-R>=pumvisible() ? "\<lt>C-n>"
"       \ : (Can_jump_forward() ? "" : "")<CR>
" inoremap <silent><C-k> <C-R>=pumvisible() ? "\<lt>C-p>"
"       \ : (Can_jump_backward() ? "" : "")<CR>
" }}}

" Fugitive {{{

nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gl :exe ':!cd ' . expand('%:p:h') . '; git lg'<CR>
nnoremap <Leader>gh :Silent Glog<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>g- :Silent Git stash<CR>:e<CR>
nnoremap <Leader>g+ :Silent Git stash pop<CR>:e<CR>

" }}}

" Ultisnips {{{
let g:UltiSnipsUsePythonVersion=3

" Disable built-in cx-ck to be able to go backward
inoremap <C-x><C-k> <NOP>
" snippet expansion, default triggers
" - expand <tab>
" - jump forward <c-j>
" - jump backward <c-k>
let g:UltiSnipsExpandTrigger="<C-q>"
" let g:UltiSnipsJumpForwardTrigger="<NOP>"
" let g:UltiSnipsJumpBackwardTrigger="<NOP>"

" }}}

" Open browser gx {{{

nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" }}}

" clever-f {{{

let g:clever_f_ignore_case=1

" }}}

" incsearch.vim {{{

" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)

" }}}

" dash {{{

nmap <silent> <leader>d <Plug>DashSearch

" }}}

" glsl {{{

" NOTE: var set on ./base.vim
" let g:glsl_file_extensions = '*.glsl,*.vert,*.frag'

"}}}

" vim-clang {{{

let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
let g:clang_format_style = 'Google'

"}}}

" syntastic {{{

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cursor_column = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_mode_map = { 
  \ 'mode': 'passive',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': [] }
nnoremap <leader>c :SyntasticCheck<CR>

" }}}
