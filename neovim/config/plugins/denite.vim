" denite.nvim
" -----------

" interface
call denite#custom#option('default', 'prompt', '>')
call denite#custom#option('default', 'vertical_preview', 1)
call denite#custom#option('default', 'short_source_names', 1)

call denite#custom#option('grep', 'empty', 0)
call denite#custom#option('grep', 'vertical_preview', 1)
call denite#custom#option('grep', 'auto_highlight', 0)

call denite#custom#option('list', 'mode', 'normal')
call denite#custom#option('list', 'winheight', 12)

" matchers
" Default is 'matcher_fuzzy'
if &runtimepath =~# '\/cpsm'
  call denite#custom#source(
    \ 'buffer,file_mru,file_old,file_rec,grep,mpc,line',
    \ 'matchers', ['matcher_cpsm', 'matcher_fuzzy'])
endif

" sorters
" Default is 'sorter_rank'

" converters
" Default is none
call denite#custom#source(
  \ 'buffer,file_mru,file_old',
  \ 'converters', ['converter_relative_word'])

" custom menus
let s:menus = {}
let s:menus.mine = {
    \ 'description': 'My custom scripts',
    \ }
let s:menus.mine.command_candidates = [
    \ ['Open the current file in finder', '!open `dirname %`']
    \ ]
call denite#custom#var('menu', 'menus', s:menus)

if executable('ag')
  let s:ag_ignores = ['.git', '.svn', '.idea', 'node_modules', '.sass-cache']
  let s:ag_opts = []
  for item in s:ag_ignores
    let s:ag_opts += ['--ignore', item]
  endfor
  call denite#custom#var('file_rec', 'command',
    \ ['ag', '-U', '--hidden', '--follow', '--nocolor', '--nogroup', '-g', ''] +
    \ s:ag_ignores)
  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'default_opts',
    \ [ '--vimgrep', '--smart-case', '--hidden' ])

elseif executable('ack')
  call denite#custom#var('grep', 'command', ['ack'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--match'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'default_opts',
      \ ['--ackrc', $HOME.'/.config/ackrc', '-H',
      \ '--nopager', '--nocolor', '--nogroup', '--column'])
endif

" KEY MAPPINGS
let insert_mode_mappings = [
  \  ['<Esc>', '<denite:quit>', 'noremap'],
  \  ['<C-c>', '<denite:quit>', 'noremap'],
  \  ['<C-n>', '<denite:move_to_next_line>', 'noremap'],
  \  ['<C-p>', '<denite:move_to_previous_line>', 'noremap'],
  \ ]

let normal_mode_mappings = [
  \   ["'", '<denite:toggle_select_down>', 'noremap'],
  \   ['<C-n>', '<denite:move_to_next_line>', 'noremap'],
  \   ['<C-p>', '<denite:move_to_previous_line>', 'noremap'],
  \   ['<C-c>', '<denite:quit>', 'noremap'],
  \ ]

for m in insert_mode_mappings
  call denite#custom#map('insert', m[0], m[1], m[2])
endfor
for m in normal_mode_mappings
  call denite#custom#map('normal', m[0], m[1], m[2])
endfor

" denite prefix
nnoremap [denite] <Nop>
xnoremap [denite] <Nop>
nmap ; [denite]
xmap ; [denite]

nnoremap <silent> [denite]r :<C-u>Denite -resume<CR>
nnoremap <silent> [denite]o :<C-u>Files .<CR>
nnoremap <silent> [denite]b :<C-u>Buffer<CR>
nnoremap <silent> [denite]f :<C-u>Rg<CR>

" nnoremap <silent> [denite]t :<C-u>Tags<CR>
" nnoremap <silent> [denite]b :<C-u>Denite buffer file_old -default-action=switch<CR>
" nnoremap <silent> [denite]l :<C-u>Denite location_list -buffer-name=list<CR>
" nnoremap <silent> [denite]q :<C-u>Denite quickfix -buffer-name=list<CR>
" nnoremap <silent> [denite]j :<C-u>Denite jump change file_point<CR>
" nnoremap <silent> [denite]y :<C-u>Denite neoyank<CR>
nnoremap <silent> [denite]h :<C-u>Denite help<CR>
nnoremap <silent> [denite]/ :<C-u>Denite line<CR>
nnoremap <silent> [denite]* :<C-u>DeniteCursorWord line<CR>
nnoremap <silent> [denite]m :<C-u>Denite menu<CR>

"}}}
