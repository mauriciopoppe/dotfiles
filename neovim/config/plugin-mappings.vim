" Interface  {{{

if utils#hasPlugin('denite.nvim') " {{{
  source $VIMPATH/config/plugins/denite.vim
endif
" }}}

if utils#hasPlugin('vimfiler.vim') " {{{
  source $VIMPATH/config/plugins/vimfiler.vim
endif
" }}}

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

if utils#hasPlugin('gitsigns.nvim') "{{{
lua <<EOF
  require('gitsigns').setup()
EOF
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

if utils#hasPlugin('vim-delve') "{{{
  let g:delve_use_vimux = 1
  let g:delve_project_root = ''

  nnoremap <leader>w :<C-u>call VimuxRunCommand('step')<CR>
  nnoremap <leader>e :<C-u>call VimuxRunCommand('next')<CR>
  nnoremap <leader>W :<C-u>call VimuxRunCommand('stepout')<CR>
  nnoremap <leader>bl :<C-u>call VimuxRunCommand('break ' . LocalDelveBreakpoint())<CR>
  vnoremap <leader>bp :<C-u>call VimuxRunCommand('p ' . LocalGetVisualSelection())<CR>
  vnoremap <leader>bc :<C-u>call VimuxRunCommand('c')<CR>

  nnoremap <leader>bb :DlvToggleBreakpoint<CR>
  " let g:terraform_fmt_on_save=1
endif
"}}}

if utils#hasPlugin('vim-terraform') "{{{
  " let g:terraform_fmt_on_save=1
endif
"}}}

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
    omni = true;
  };
}
EOF
endif
"}}}

if utils#hasPlugin('glepnir/lspsaga.nvim') "{{{
  lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga()
EOF
endif
"}}}

if utils#hasPlugin('neovim/nvim-lspconfig') " {{{
  " https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
  " https://github.com/neovim/nvim-lspconfig
  lua <<EOF
local nvim_lsp = require('lspconfig')
local util = require('lspconfig/util')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  -- if client.resolved_capabilities.document_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- elseif client.resolved_capabilities.document_range_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  -- end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

nvim_lsp.gopls.setup{
  root_dir = function(fname)
    return util.root_pattern("go.mod", ".git")(fname) or
      util.path.dirname(fname)
  end
}

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "gopls", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc

endif
"}}}

if utils#hasPlugin('nvim/treesitter') "{{{
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
  noremap <Leader>sp :VimuxPromptCommand<CR>
  " Execute last command
  noremap <Leader>sl :VimuxRunLastCommand<CR>
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
