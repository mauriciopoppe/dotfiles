" Interface  {{{

if utils#hasPlugin('denite.nvim') "{{{
  source $VIMPATH/config/plugins/denite.vim

  nnoremap <silent><LocalLeader>r :<C-u>Denite -resume<CR>
  nnoremap <silent><LocalLeader>f :<C-u>Files .<CR>
  nnoremap <silent><LocalLeader>b :<C-u>Denite buffer file_old -default-action=switch<CR>
  nnoremap <silent><LocalLeader>d :<C-u>Denite directory_rec -default-action=cd<CR>
  nnoremap <silent><LocalLeader>l :<C-u>Denite location_list -buffer-name=list<CR>
  nnoremap <silent><LocalLeader>q :<C-u>Denite quickfix -buffer-name=list<CR>
  nnoremap <silent><LocalLeader>n :<C-u>Denite dein -no-quit<CR>
  nnoremap <silent><LocalLeader>g :<C-u>Denite grep -buffer-name=grep<CR>
  nnoremap <silent><LocalLeader>j :<C-u>Denite jump change file_point<CR>
  nnoremap <silent><LocalLeader>o :<C-u>Denite outline<CR>
  nnoremap <silent><LocalLeader>s :<C-u>Denite session<CR>
  nnoremap <silent><LocalLeader>h :<C-u>Denite help<CR>
  nnoremap <silent><LocalLeader>m :<C-u>Denite mpc -buffer-name=mpc<CR>
  nnoremap <silent><LocalLeader>/ :<C-u>Denite line<CR>
  nnoremap <silent><LocalLeader>* :<C-u>DeniteCursorWord line<CR>

  " Open Denite with word under cursor or selection
  nnoremap <silent> <Leader>gf :DeniteCursorWord file_rec<CR>
  nnoremap <silent> <Leader>gg :DeniteCursorWord grep -buffer-name=grep<CR>
  vnoremap <silent> <Leader>gg
    \ :<C-u>call <SID>get_selection('/')<CR>
    \ :execute 'Denite -buffer-name=grep grep:::'.@/<CR><CR>

  function! s:get_selection(cmdtype) "{{{
    let temp = @s
    normal! gv"sy
    let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
    let @s = temp
  endfunction "}}}
endif
" }}}

if utils#hasPlugin('vimfiler.vim') " {{{
  source $VIMPATH/config/plugins/vimfiler.vim
endif
" }}}

if utils#hasPlugin('deoplete.nvim') " {{{
  " let g:deoplete#enable_at_startup=1
  " let g:deoplete#enable_smart_case=1
  " let g:deoplete#max_list=30

  " " Redraw candidates
  " inoremap <expr><C-l> deoplete#mappings#refresh()

  " " Disable deoplete on vim-multiple-cursors
  " function g:Multiple_cursors_before()
  "   let g:deoplete#disable_auto_complete = 1
  " endfunction
  " function g:Multiple_cursors_after()
  "   let g:deoplete#disable_auto_complete = 0
  " endfunction

  " " quiet messages in auto completion
  " if has("patch-7.4.314")
  "   set shortmess+=c
  " endif

  " if !exists('g:deoplete#omni#input_patterns')
  "   let g:deoplete#omni#input_patterns = {}
  " endif

  " " let g:deoplete#omni#functions = {}
  " " let g:deoplete#omni#functions['javascript'] = [
  " "     \ 'tern#Complete'
  " "     \]

  " if !exists('g:deoplete#ignore_sources')
  "   let g:deoplete#ignore_sources = {}
  " endif
  " let g:deoplete#ignore_sources['html'] = ['omni']

  " if !exists('g:deoplete#sources')
  "   let g:deoplete#sources = {}
  " endif
  " let g:deoplete#sources['javascript.jsx'] = ['file', 'ternjs', 'ultisnips']
  " source $VIMPATH/config/plugins/deoplete.vim
endif
" }}}

if utils#hasPlugin('fzf.vim')
  " let g:fzf_files_options = '--reverse'
  let g:fzf_files_options =
    \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
  let g:fzf_buffers_jump = 1
endif


if utils#hasPlugin('lightline.vim')
  source $VIMPATH/config/plugins/lightline.vim
endif

" }}}

" }}}

if utils#hasPlugin('emmet-vim') "{{{
  autocmd MyAutoCmd FileType html,css,jsx,javascript,javascript.jsx
    \ EmmetInstall
    \ | imap <buffer> <C-Return> <Plug>(emmet-expand-abbr)
  let g:user_emmet_settings = {
  \    'html': {
  \        'empty_element_suffix': ' />',
  \        'indent_blockelement': 1,
  \    },
  \}
  imap <silent> <C-e>, <plug>(emmet-expand-abbr)
  imap <silent> <C-e>. <plug>(emmet-expand-abbr)<plug>(emmet-split-join-tag)f/i
endif

"}}}
if utils#hasPlugin('vim-niceblock') "{{{
  xmap I  <Plug>(niceblock-I)
  xmap A  <Plug>(niceblock-A)
endif

"}}}
if utils#hasPlugin('vim-indent-guides') "{{{
  nmap <silent><Leader>ti :<C-u>IndentGuidesToggle<CR>
endif

"}}}
if utils#hasPlugin('vim-bookmarks') "{{{
  nmap ma :<C-u>cgetexpr bm#location_list()<CR>
    \ :<C-u>Denite quickfix -buffer-name=list<CR>
  nmap mn <Plug>BookmarkNext
  nmap mp <Plug>BookmarkPrev
  nmap mm <Plug>BookmarkToggle
  nmap mi <Plug>BookmarkAnnotate
endif

"}}}
if utils#hasPlugin('committia.vim') "{{{
  let g:committia_hooks = {}
  function! g:committia_hooks.edit_open(info)
    imap <buffer><C-d> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-u> <Plug>(committia-scroll-diff-up-half)

    setlocal winminheight=1 winheight=1
    resize 10
    startinsert
  endfunction
endif

"}}}
if utils#hasPlugin('python_match.vim') "{{{
  nmap <buffer> {{ [%
  nmap <buffer> }} ]%
endif

"}}}
if utils#hasPlugin('tabman.vim') "{{{
  nmap <silent> <Leader>tt <Plug>Tabman
endif

"}}}
if utils#hasPlugin('goyo.vim') "{{{

  " trigger
  nnoremap <Leader>G :Goyo<CR>

  " s:goyo_enter() "{{{
  " Disable visual candy in Goyo mode
  function! s:goyo_enter()
    if has('gui_running')
      " Gui fullscreen
      set fullscreen
      set background=light
      set linespace=7
    elseif exists('$TMUX')
      " Hide tmux status
      silent !tmux set status off
    endif

    " Activate Limelight
    Limelight
  endfunction

  " }}}
  " s:goyo_leave() "{{{
  " Enable visuals when leaving Goyo mode
  function! s:goyo_leave()
    if has('gui_running')
      " Gui exit fullscreen
      set nofullscreen
      set background=dark
      set linespace=0
    elseif exists('$TMUX')
      " Show tmux status
      silent !tmux set status on
    endif

    " De-activate Limelight
    Limelight!
  endfunction
  " }}}

  " Goyo Commands {{{
  autocmd! User GoyoEnter
  autocmd! User GoyoLeave
  autocmd  User GoyoEnter nested call <SID>goyo_enter()
  autocmd  User GoyoLeave nested call <SID>goyo_leave()
" }}}

endif

if utils#hasPlugin('limelight.vim') " {{{
  let g:limelight_default_coefficient = 0.7
  let g:limelight_conceal_ctermfg = 240
endif

"}}}
if utils#hasPlugin('vim-choosewin') "{{{
  nmap -         <Plug>(choosewin)
  nmap <Leader>- :<C-u>ChooseWinSwapStay<CR>
endif

"}}}
if utils#hasPlugin('jedi-vim') "{{{
  let g:jedi#completions_command = ''
  let g:jedi#documentation_command = 'K'
  let g:jedi#goto_command = '<C-]>'
  let g:jedi#goto_assignments_command = '<leader>g'
  let g:jedi#rename_command = '<Leader>r'
  let g:jedi#usages_command = '<Leader>n'
endif

"}}}
if utils#hasPlugin('vim-go') "{{{
  autocmd MyAutoCmd FileType go
    \   nmap <C-]> <Plug>(go-def)
    \ | nmap <Leader>god  <Plug>(go-describe)
    \ | nmap <Leader>goc  <Plug>(go-callees)
    \ | nmap <Leader>goC  <Plug>(go-callers)
    \ | nmap <Leader>goi  <Plug>(go-info)
    \ | nmap <Leader>gom  <Plug>(go-implements)
    \ | nmap <Leader>gos  <Plug>(go-callstack)
    \ | nmap <Leader>goe  <Plug>(go-referrers)
    \ | nmap <Leader>gor  <Plug>(go-run)
    \ | nmap <Leader>gov  <Plug>(go-vet)
endif

" }}}
if utils#hasPlugin('vim-fugitive') "{{{
  nnoremap <silent> <leader>ga :Git add %:p<CR>
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gD :Gdiffoff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>gB :Gbrowse<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
endif

"}}}
if utils#hasPlugin('gitv') "{{{
  nmap <Leader>gl :Gitv --all<cr>
  nmap <Leader>gL :Gitv! --all<cr>
  vmap <Leader>gL :Gitv! --all<cr>
endif

"}}}
if utils#hasPlugin('undotree') "{{{
  nnoremap <Leader>gu :UndotreeToggle<CR>
endif

"}}}
if utils#hasPlugin('open-browser.vim') "{{{
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)
endif

"}}}
if utils#hasPlugin('vimux') "{{{
  " Executes a command in a tmux split, if there's one available run it there
  noremap <Leader>sp :VimuxPromptCommand<CR>
  " Execute last command
  noremap <Leader>sl :VimuxRunLastCommand<CR>
  noremap <leader>e :ExecScript<CR>
endif

"}}}
if utils#hasPlugin('dash.vim') "{{{
  " searches in dash for the word under the cursor (considering the context)
  nmap <silent> <leader>dd <Plug>DashSearch
  " [d]ocs [s]earch prompt to search for a word
  nmap <leader>ds :<C-u>Dash<space>
endif

"}}}
if utils#hasPlugin('vim-leader-guide') "{{{
  nmap  <Leader>ll  <Plug>leaderguide-global
  nmap  <Leader>lb  <Plug>leaderguide-buffer
  let g:leaderGuide_submode_mappings =
    \ { '<C-C>': 'win_close', '<C-F>': 'page_down', '<C-B>': 'page_up' }
endif

"}}}
if utils#hasPlugin('vim-online-thesaurus') "{{{
  nnoremap <silent> <Leader>K :<C-u>OnlineThesaurusCurrentWord<CR>
endif

"}}}
if utils#hasPlugin('vim-expand-region') "{{{
  xmap v <Plug>(expand_region_expand)
  xmap V <Plug>(expand_region_shrink)
endif

"}}}
if utils#hasPlugin('sideways.vim') "{{{
  nnoremap <silent> m" :SidewaysJumpLeft<CR>
  nnoremap <silent> m' :SidewaysJumpRight<CR>
  omap <silent> a, <Plug>SidewaysArgumentTextobjA
  xmap <silent> a, <Plug>SidewaysArgumentTextobjA
  omap <silent> i, <Plug>SidewaysArgumentTextobjI
  xmap <silent> i, <Plug>SidewaysArgumentTextobjI
endif

"}}}
if utils#hasPlugin('splitjoin.vim') "{{{
  let g:splitjoin_split_mapping = ''
  let g:splitjoin_join_mapping = ''
  nmap sj :SplitjoinSplit<CR>
  nmap sk :SplitjoinJoin<CR>
endif

"}}}
if utils#hasPlugin('vim-easy-align') "{{{
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif

"}}}
if utils#hasPlugin('linediff.vim') "{{{
  vnoremap df :Linediff<CR>
  vnoremap da :LinediffAdd<CR>
  vnoremap dr :LinediffReset<CR>
endif

"}}}
if utils#hasPlugin('dsf.vim') "{{{
  nmap dsf <Plug>DsfDelete
  nmap csf <Plug>DsfChange
endif

"}}}
if utils#hasPlugin('typescript-vim') "{{{
  let g:typescript_indent_disable = 1
endif

"}}}
if utils#hasPlugin('CamelCaseMotion') "{{{
  nmap <silent> e <Plug>CamelCaseMotion_e
  xmap <silent> e <Plug>CamelCaseMotion_e
  omap <silent> e <Plug>CamelCaseMotion_e
  nmap <silent> w <Plug>CamelCaseMotion_w
  xmap <silent> w <Plug>CamelCaseMotion_w
  omap <silent> w <Plug>CamelCaseMotion_w
  nmap <silent> b <Plug>CamelCaseMotion_b
  xmap <silent> b <Plug>CamelCaseMotion_b
  omap <silent> b <Plug>CamelCaseMotion_b
endif

"}}}
if utils#hasPlugin('vim-commentary') "{{{
  " xmap <Leader>v  <Plug>Commentary
  " nmap <Leader>v  <Plug>CommentaryLine
  xmap gc  <Plug>Commentary
  nmap gc  <Plug>Commentary
  omap gc  <Plug>Commentary
  nmap gcc <Plug>CommentaryLine
  nmap cgc <Plug>ChangeCommentary
  nmap gcu <Plug>Commentary<Plug>Commentary
endif

"}}}
if utils#hasPlugin('vim-easymotion') "{{{
  nmap ss <Plug>(easymotion-s2)
  " nmap sd <Plug>(easymotion-s)
  " nmap sf <Plug>(easymotion-overwin-f)
  " map  sh <Plug>(easymotion-linebackward)
  " map  sl <Plug>(easymotion-lineforward)
  " map  sj <Plug>(easymotion-j)
  " map  sk <Plug>(easymotion-k)
  " map  s/ <Plug>(easymotion-sn)
  " omap s/ <Plug>(easymotion-tn)
  " map  sn <Plug>(easymotion-next)
  " map  sp <Plug>(easymotion-prev)
endif

"}}}
if utils#hasPlugin('vim-textobj-multiblock') "{{{
  omap <silent> ab <Plug>(textobj-multiblock-a)
  omap <silent> ib <Plug>(textobj-multiblock-i)
  xmap <silent> ab <Plug>(textobj-multiblock-a)
  xmap <silent> ib <Plug>(textobj-multiblock-i)
endif

"}}}
if utils#hasPlugin('vim-textobj-function') "{{{
  omap <silent> af <Plug>(textobj-function-a)
  omap <silent> if <Plug>(textobj-function-i)
  xmap <silent> af <Plug>(textobj-function-a)
  xmap <silent> if <Plug>(textobj-function-i)
endif
"}}}

" vim: set ts=2 sw=2 tw=80 et :
