-- my/utils is first loaded in mappings.vim
local utils = require('my/utils')

local function doNothing() end

if utils.PluginLoaded('vim-oscyank') then
  vim.g.oscyank_term = 'default'
  vim.cmd([[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif]])
end

if utils.PluginLoaded('neo-tree.nvim') then
  vim.cmd([[ source $VIMPATH/config/plugins/nvim-neotree.lua ]])
end

if utils.PluginLoaded('nvim-dap') then
  vim.cmd([[ source $VIMPATH/config/plugins/nvim-dap.lua ]])
end

if utils.PluginLoaded('nvim-dap-ui') then
  vim.cmd([[ source $VIMPATH/config/plugins/nvim-dap-ui.lua ]])
end

if utils.PluginLoaded('lualine.nvim') then
  vim.cmd([[ source $VIMPATH/config/plugins/nvim-lualine.lua ]])
end

if utils.PluginLoaded('telescope.nvim') then
  vim.cmd([[ source $VIMPATH/config/plugins/nvim-telescope.lua ]])
end

if utils.PluginLoaded('nvim-cmp') then
  vim.cmd([[ source $VIMPATH/config/plugins/nvim-cmp.lua ]])
end

if utils.PluginLoaded('nvim-lspconfig') then
  vim.cmd([[ source $VIMPATH/config/plugins/nvim-lspconfig.lua ]])
end

if utils.PluginLoaded('nvim-treesitter') then
  vim.cmd([[ source $VIMPATH/config/plugins/nvim-treesitter.lua ]])
end

if utils.PluginLoaded('nvim-spectre') then
  local spectre = require('spectre')
  spectre.setup()
  vim.keymap.set('n', '[ui]s', spectre.open)
end

if utils.PluginLoaded('leap.nvim') then
  local leap = require('leap')
  leap.add_default_mappings()
end

if utils.PluginLoaded('flit.nvim') then
  require('flit').setup {
    keys = { f = 'f', F = 'F', t = 't', T = 'T' },
    -- A string like "nv", "nvo", "o", etc.
    labeled_modes = "v",
    multiline = true,
    -- Like `leap`s similar argument (call-specific overrides).
    -- E.g.: opts = { equivalence_classes = {} }
    opts = {}
  }
end

if utils.PluginLoaded('spellsitter.nvim') then
  require('spellsitter').setup()
end

if utils.PluginLoaded('nvim-surround') then
  require('nvim-surround').setup()
end

if utils.PluginLoaded('vim-indent-guides') then
  vim.keymap.set('n', '<Leader>ti', ':<C-u>IndentGuidesToggle<CR>', { silent = true })
end

if utils.PluginLoaded('vim-bookmarks') then
  -- let g:bookmark_no_default_key_mappings = 1 should be set before the plugin
  doNothing()
end

if utils.PluginLoaded('gitsigns.nvim') then
  require('gitsigns').setup()
end

if utils.PluginLoaded('vim-signify') then
  vim.g.signify_vcs_cmds_diffmode = {
    hg = 'hg cat %f -r p4base',
  }
end

if utils.PluginLoaded('vim-mergetool') then
  vim.cmd([[
  nmap <expr> <C-Left> &diff? '<Plug>(MergetoolDiffExchangeLeft)' : '<C-Left>'
  nmap <expr> <C-Right> &diff? '<Plug>(MergetoolDiffExchangeRight)' : '<C-Right>'
  nmap <expr> <C-Down> &diff? '<Plug>(MergetoolDiffExchangeDown)' : '<C-Down>'
  nmap <expr> <C-Up> &diff? '<Plug>(MergetoolDiffExchangeUp)' : '<C-Up>'
  ]])
end

if utils.PluginLoaded('go.nvim') then
  vim.cmd([[
autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
autocmd FileType go nnoremap <silent> <Leader>k :<C-u>GoDoc<CR>
  ]])
  require('go').setup()
end

if utils.PluginLoaded('vim-prettier') then
  vim.g["prettier#autoformat"] = 1
  vim.g["prettier#autoformat_require_pragma"] = 0
end

if utils.PluginLoaded('codeium.vim') then
  vim.keymap.set('i', '<C-j>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
  vim.g.copilot_filetypes = {
    ['dap-repl'] = false,
  }
end

if utils.PluginLoaded('vim-fugitive') then
  vim.cmd([[
  nnoremap <silent> <leader>gs :Git status<CR>
  nnoremap <silent> <leader>gd :Git diff<CR>
  nnoremap <silent> <leader>gD :Git diffoff<CR>
  nnoremap <silent> <leader>gc :Git commit<CR>
  nnoremap <silent> <leader>gb :Git blame<CR>
  nnoremap <silent> <leader>gB :Git browse<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  ]])
end

if utils.PluginLoaded('vimux') then
  vim.cmd([[
  " Executes a command in a tmux split, if there's one available run it there
  noremap <Leader>tp :VimuxPromptCommand<CR>
  " Execute last command
  noremap <Leader>tl :VimuxRunLastCommand<CR>
  ]])
end

if utils.PluginLoaded('splitjoin.vim') then
  vim.g.splitjoin_split_mapping = ''
  vim.g.splitjoin_join_mapping = ''
end

if utils.PluginLoaded('vim-easy-align') then
  vim.cmd([[
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
  ]])
end


if utils.PluginLoaded('CamelCaseMotion') then
  vim.cmd([[
  nmap <silent> e <Plug>CamelCaseMotion_e
  xmap <silent> e <Plug>CamelCaseMotion_e
  omap <silent> e <Plug>CamelCaseMotion_e
  nmap <silent> w <Plug>CamelCaseMotion_w
  xmap <silent> w <Plug>CamelCaseMotion_w
  omap <silent> w <Plug>CamelCaseMotion_w
  nmap <silent> b <Plug>CamelCaseMotion_b
  xmap <silent> b <Plug>CamelCaseMotion_b
  omap <silent> b <Plug>CamelCaseMotion_b
  ]])
end

if utils.PluginLoaded('vim-commentary') then
  vim.cmd([[
  xmap gc  <Plug>Commentary
  nmap gc  <Plug>Commentary
  omap gc  <Plug>Commentary
  nmap gcc <Plug>CommentaryLine
  ]])
end

if utils.PluginLoaded('vim-gfm-syntax') then
  vim.g.gfm_syntax_enable_always = 0
  vim.g.gfm_syntax_highlight_emoji = 0
  vim.g.gfm_syntax_enable_filetypes = {'markdown'}
end

