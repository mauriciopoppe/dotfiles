" Interface  {{{

if utils#hasPlugin('denite.nvim') " {{{
  source $VIMPATH/config/plugins/denite.vim
endif
" }}}

if utils#hasPlugin('vimfiler.vim') " {{{
  source $VIMPATH/config/plugins/vimfiler.vim
endif
" }}}

" if utils#hasPlugin('deoplete.nvim') " {{{
"   source $VIMPATH/config/plugins/deoplete.vim
" endif
" " }}}

if utils#hasPlugin('coc.nvim') " {{{
  source $VIMPATH/config/plugins/coc.vim
endif
" }}}

if utils#hasPlugin('vim-latex-live-preview') " {{{
  let g:livepreview_previewer = 'skim'
endif
" }}}

if utils#hasPlugin('ale') " {{{
  source $VIMPATH/config/plugins/ale.vim
endif
" }}}

if utils#hasPlugin('vim-localvimrc')
  let g:localvimrc_ask = 0
endif

if utils#hasPlugin('fzf.vim')
  let g:fzf_files_options =
    \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
  let g:fzf_buffers_jump = 1
endif

if utils#hasPlugin('lightline.vim')
  source $VIMPATH/config/plugins/lightline.vim
endif

if utils#hasPlugin('vim-jsx')
  let g:jsx_ext_required = 0
endif

if utils#hasPlugin('vim-javascript') "{{{
  let g:javascript_plugin_flow = 1
endif
"}}}


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

if utils#hasPlugin('python_match.vim') "{{{
  nmap <buffer> {{ [%
  nmap <buffer> }} ]%
endif
"}}}

if utils#hasPlugin('vim-jsx') "{{{
  let g:jsx_ext_required = 0
endif
"}}}

if utils#hasPlugin('vim-flow') "{{{
  let g:flow#showquickfix = 0
endif
"}}}

if utils#hasPlugin('goyo.vim') "{{{

  " trigger
  nnoremap <Leader>G :Goyo<CR>

  " s:goyo_enter() "{{{
  " Disable visual candy in Goyo mode
  function OnGoyoEnter()
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    set noshowmode
    set noshowcmd
    set scrolloff=999
    " hide tabline (a new tab is created with the contents of the current buffer)
    set showtabline=0
    " Activate Limelight
    Limelight
  endfunction

  " }}}
  " s:goyo_leave() "{{{
  " Enable visuals when leaving Goyo mode
  function OnGoyoLeave()
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    set showmode
    set showcmd
    set scrolloff=5

    " redraw tabline
    call buftabline#update(1)

    " De-activate Limelight
    Limelight!
  endfunction
  " }}}

  " Goyo Commands {{{
  autocmd! User GoyoEnter
  autocmd! User GoyoLeave
  autocmd  User GoyoEnter nested call OnGoyoEnter()
  autocmd  User GoyoLeave nested call OnGoyoLeave()
" }}}

endif

if utils#hasPlugin('limelight.vim') " {{{
  let g:limelight_default_coefficient = 0.7
  let g:limelight_conceal_ctermfg = 240
endif

"}}}

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
  " run :GoBuild or :GoTestCompile based on the go file
  function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
      call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
      call go#cmd#Build(0)
    endif
  endfunction

  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <leader>t <Plug>(go-test)
  autocmd FileType go nmap <leader>r <Plug>(go-run)
  autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)

  " let g:go_auto_type_info = 1
  let g:go_highlight_types = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_list_type = "quickfix"
  let g:go_fmt_command = "goimports"
endif

" }}}

if utils#hasPlugin('vim-terraform') "{{{
  " let g:terraform_fmt_on_save=1
endif

if utils#hasPlugin('hrsh7th/nvim-compe') "{{{
  lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}
EOF
endif

if utils#hasPlugin('neovim/nvim-lspconfig')
  " https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
  lua require'lspconfig'.tsserver.setup{}
  lua require'lspconfig'.gopls.setup{}

  autocmd Filetype * setlocal omnifunc=v:lua.vim.lsp.omnifunc

  nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> gH    <cmd>lua vim.lsp.buf.code_action()<CR>
  nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
endif

if utils#hasPlugin('nvim/treesitter')
  " colorscheme onedark
  lua <<EOF
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "gni",
      },
    },
    indent = {
      enable = true
    }
  }
EOF
  set foldmethod=expr
  setlocal foldlevelstart=99
  set foldexpr=nvim_treesitter#foldexpr()
endif

if utils#hasPlugin('vim-fugitive')
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
if utils#hasPlugin('ack.vim') "{{{
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif
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

if utils#hasPlugin('vim-markdown') "{{{
  let g:vim_markdown_no_extensions_in_markdown = 1
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_override_foldtext = 0
  let g:vim_markdown_frontmatter = 1
  let g:vim_markdown_conceal = 0
  let g:vim_markdown_math = 1
  let g:tex_conceal = ""
endif

"}}}

if utils#hasPlugin('vim-gfm-syntax') "{{{
  let g:gfm_syntax_enable_always = 0
  let g:gfm_syntax_highlight_emoji = 0
  let g:gfm_syntax_enable_filetypes = ['markdown']
endif
"}}}

"}}}

" vim: set ts=2 sw=2 tw=80 et :
