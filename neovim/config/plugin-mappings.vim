" Interface  {{{

if utils#hasPlugin('denite.nvim') " {{{
  source $VIMPATH/config/plugins/denite.vim
endif
" }}}

if utils#hasPlugin('vimfiler.vim') " {{{
  source $VIMPATH/config/plugins/vimfiler.vim
endif
" }}}

if utils#hasPlugin('nvim-tree.lua') " {{{
  source $VIMPATH/config/plugins/nvim-tree.vim
endif
" }}}

if utils#hasPlugin('neo-tree.nvim') " {{{
  source $VIMPATH/config/plugins/nvim-neotree.vim
endif
" }}}

if utils#hasPlugin('nvim-dap') " {{{
  source $VIMPATH/config/plugins/nvim-dap.vim
endif
" }}}

if utils#hasPlugin('nvim-dap-ui') " {{{
  source $VIMPATH/config/plugins/nvim-dap-ui.vim
endif
" }}}

if utils#hasPlugin('lualine.nvim') " {{{
  source $VIMPATH/config/plugins/nvim-lualine.vim
endif
" }}}

if utils#hasPlugin('telescope.nvim') " {{{
  source $VIMPATH/config/plugins/nvim-telescope.vim
endif
" }}}

if utils#hasPlugin('coc.nvim') " {{{
  source $VIMPATH/config/plugins/coc.vim
endif
" }}}

if utils#hasPlugin('nvim-cmp') " {{{
  source $VIMPATH/config/plugins/nvim-cmp.vim
endif
" }}}

if utils#hasPlugin('nvim-spectre') " {{{
lua << EOF
require('spectre').setup()
EOF
nnoremap [ui]s <cmd>lua require('spectre').open()<CR>
endif
" }}}

if utils#hasPlugin('leap.nvim') " {{{
lua require('leap').add_default_mappings()
endif
" }}}

if utils#hasPlugin('flit.nvim') " {{{
lua << EOF
require('flit').setup {
  keys = { f = 'f', F = 'F', t = 't', T = 'T' },
  -- A string like "nv", "nvo", "o", etc.
  labeled_modes = "v",
  multiline = true,
  -- Like `leap`s similar argument (call-specific overrides).
  -- E.g.: opts = { equivalence_classes = {} }
  opts = {}
}
EOF
endif
" }}}

if utils#hasPlugin('vim-latex-live-preview') " {{{
  let g:livepreview_previewer = 'skim'
endif
" }}}

if utils#hasPlugin('spellsitter.nvim') " {{{
lua << EOF
require('spellsitter').setup()
EOF
endif
" }}}

if utils#hasPlugin('nvim-surround') " {{{
lua << EOF
require('nvim-surround').setup()
EOF
endif
" }}}

if utils#hasPlugin('ale') " {{{
  source $VIMPATH/config/plugins/ale.vim
endif
" }}}


if utils#hasPlugin('AutoSave.nvim') " {{{
lua << EOF
local autosave = require("autosave")
autosave.setup(
    {
        enabled = true,
        execution_message = "",
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
EOF
endif
" }}}

if utils#hasPlugin('vim-localvimrc')
  let g:localvimrc_ask = 0
endif

if utils#hasPlugin('fzf.vim')
  let g:fzf_files_options =
    \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
  let g:fzf_buffers_jump = 1

  function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction

  " command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
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
  let g:user_emmet_install_global = 0
  autocmd MyAutoCmd FileType html,css,jsx,javascript,javascript.jsx
    \ EmmetInstall
    \ | imap <buffer> <C-Return> <Plug>(emmet-expand-abbr)
    \ | imap <silent> <C-e>, <plug>(emmet-expand-abbr)
    \ | imap <silent> <C-e>. <plug>(emmet-expand-abbr)<plug>(emmet-split-join-tag)f/i
  let g:user_emmet_settings = {
  \    'html': {
  \        'empty_element_suffix': ' />',
  \        'indent_blockelement': 1,
  \    },
  \}
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

  autocmd! User GoyoEnter
  autocmd! User GoyoLeave
  autocmd  User GoyoEnter nested call OnGoyoEnter()
  autocmd  User GoyoLeave nested call OnGoyoLeave()
  autocmd  VimLeave * :call OnGoyoLeave()

endif
" }}}

if utils#hasPlugin('limelight.vim') " {{{
  let g:limelight_default_coefficient = 0.7
  let g:limelight_conceal_ctermfg = 240
endif
"}}}

if utils#hasPlugin('gitsigns.nvim') "{{{
lua <<EOF
  require('gitsigns').setup()
EOF
endif
"}}}

if utils#hasPlugin('vim-signify') "{{{
  let g:signify_vcs_cmds_diffmode = {
  \ 'hg': 'hg cat %f -r p4base',
  \}
endif
"}}}

if utils#hasPlugin('vim-mergetool') "{{{
  nmap <expr> <C-Left> &diff? '<Plug>(MergetoolDiffExchangeLeft)' : '<C-Left>'
  nmap <expr> <C-Right> &diff? '<Plug>(MergetoolDiffExchangeRight)' : '<C-Right>'
  nmap <expr> <C-Down> &diff? '<Plug>(MergetoolDiffExchangeDown)' : '<C-Down>'
  nmap <expr> <C-Up> &diff? '<Plug>(MergetoolDiffExchangeUp)' : '<C-Up>'
endif
"}}}

if utils#hasPlugin('vim-go') "{{{
  " run :GoBuild or :GoTestCompile based on the go file
  " function! s:build_go_files()
  "   let l:file = expand('%')
  "   if l:file =~# '^\f\+_test\.go$'
  "     call go#test#Test(0, 1)
  "   elseif l:file =~# '^\f\+\.go$'
  "     call go#cmd#Build(0)
  "   endif
  " endfunction

  " autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  " autocmd FileType go nmap <leader>t <Plug>(go-test)
  " autocmd FileType go nmap <leader>r <Plug>(go-run)
  " autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)

  " let g:go_auto_type_info = 1
  let g:go_highlight_types = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_auto_sameids = 1
  let g:go_list_type = "quickfix"
  let g:go_fmt_command = "goimports"

endif
" }}}

if utils#hasPlugin('go.nvim') "{{{
autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
autocmd FileType go nnoremap <silent> [ui]d :<C-u>GoDoc<CR>
lua << EOF
  require('go').setup()
EOF
endif
" }}}

function! LocalGetVisualSelection()
  " Why is this not a built-in Vim script function?!
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
      return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction

function! LocalDelveBreakpoint()
  return expand('%') . ':' . line(".")
endfunction

function! DebuggerStepInto()
  call VimuxRunCommand('step')
endfunction

function! DebuggerStepOut()
  call VimuxRunCommand('stepout')
endfunction

function! DebuggerStepOver()
  call VimuxRunCommand('next')
endfunction

function! DebuggerBreakLine()
  call VimuxRunCommand('break ' . LocalDelveBreakpoint())
endfunction

function! DebuggerPrintValue()
  call VimuxRunCommand('print ' . LocalGetVisualSelection())
endfunction

function! DebuggerContinue()
  call VimuxRunCommand('continue')
endfunction

if utils#hasPlugin('vim-delve') "{{{
  let g:delve_use_vimux = 1
  let g:delve_project_root = ''

  nnoremap <leader>w :<C-u>call DebuggerStepInto()<CR>
  nnoremap <leader>W :<C-u>call DebuggerStepOut()<CR>
  nnoremap <leader>e :<C-u>call DebuggerStepOver()<CR>
  nnoremap <leader>bl :<C-u>call DebuggerBreakLine()<CR>
  vnoremap <leader>bp :<C-u>call DebuggerPrintValue()<CR>
  vnoremap <leader>bc :<C-u>call DebuggerContinue()<CR>

  " to have similar mappings like in Chrome, we have to configure iterm to send keys to vim
  " see https://stackoverflow.com/questions/40990454/how-to-map-mac-command-key-in-vim

  nnoremap <leader>bb :DlvToggleBreakpoint<CR>
endif
"}}}

if utils#hasPlugin('vim-terraform') "{{{
  " let g:terraform_fmt_on_save=1
endif
"}}}

if utils#hasPlugin('lspsaga.nvim') "{{{
  lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga()
EOF
endif
"}}}

if utils#hasPlugin('nvim-lspconfig') " {{{
  source $VIMPATH/config/plugins/nvim-lspconfig.vim
endif
"}}}

if utils#hasPlugin('nvim-treesitter') "{{{
  source $VIMPATH/config/plugins/nvim-treesitter.vim
endif
" }}}

if utils#hasPlugin('nvim-treesitter-context') "{{{
  lua << EOF
EOF
endif
" }}}

if utils#hasPlugin('vim-prettier') "{{{
  let g:prettier#autoformat = 1
  let g:prettier#autoformat_require_pragma = 0
endif
" }}}

if utils#hasPlugin('lspsaga.nvim') "{{{
  source $VIMPATH/config/plugins/nvim-lspsaga.vim
endif
" }}}

if utils#hasPlugin('copilot.vim') "{{{
  imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
  " Instructions to disable copilot on certain filetypes.
  " https://github.com/github/copilot.vim/blob/release/doc/copilot.txt
  let g:copilot_no_tab_map = v:true
  let g:copilot_filetypes = {
        \ 'dap-repl': v:false,
        \ }
endif
" }}}

if utils#hasPlugin('vim-fugitive') "{{{
  nnoremap <silent> <leader>gs :Git status<CR>
  nnoremap <silent> <leader>gd :Git diff<CR>
  nnoremap <silent> <leader>gD :Git diffoff<CR>
  nnoremap <silent> <leader>gc :Git commit<CR>
  nnoremap <silent> <leader>gb :Git blame<CR>
  nnoremap <silent> <leader>gB :Git browse<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
endif
" }}}

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
  noremap <Leader>tp :VimuxPromptCommand<CR>
  " Execute last command
  noremap <Leader>tl :VimuxRunLastCommand<CR>
endif
"}}}

if utils#hasPlugin('splitjoin.vim') "{{{
  let g:splitjoin_split_mapping = ''
  let g:splitjoin_join_mapping = ''
  " nmap sj :SplitjoinSplit<CR>
  " nmap sk :SplitjoinJoin<CR>
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
  nmap <leader>/ <Plug>(easymotion-s2)
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

if utils#hasPlugin('vim-oscyank') "{{{
  let g:oscyank_term = 'default'
  autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
endif
"}}}

if executable('gotags')
  let g:tagbar_type_go = {
  \ 'ctagstype' : 'go',
  \ 'kinds'     : [
    \ 'p:package',
    \ 'i:imports:1',
    \ 'c:constants',
    \ 'v:variables',
    \ 't:types',
    \ 'n:interfaces',
    \ 'w:fields',
    \ 'e:embedded',
    \ 'm:methods',
    \ 'r:constructor',
    \ 'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
    \ 't' : 'ctype',
    \ 'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
    \ 'ctype' : 't',
    \ 'ntype' : 'n'
  \ },
  \ 'ctagsbin'  : 'gotags',
  \ 'ctagsargs' : '-sort -silent'
\ }
endif

" }}}

" vim: set ts=2 sw=2 tw=80 et :
