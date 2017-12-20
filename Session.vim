let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/.dotfiles
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +55 neovim/install.zsh
badd +98 tmux/.tmux.conf
badd +18 tmux/theme.dark.conf
badd +57 bin/tmux-switch-client
badd +46 neovim/config/general.vim
badd +13 zsh/plugins/bookmark/bin/bookmark
badd +12 zsh/plugins/bookmark/bin/deletemark
badd +1 zsh/plugins/bookmark/bin/showmarks
badd +1 .tmuxinator.yml
badd +8 .travis.yml
badd +23 install.sh
badd +151 git/.gitconfig
badd +7 zsh/install.zsh
badd +1 zsh/init.source.zsh
badd +68 zsh/.zshrc
badd +8 zsh/exports.path.zsh
badd +1 zsh/aliases.source.zsh
badd +1 python/auto.source.zsh
badd +6 python/install.zsh
badd +1 homebrew/Brewfile
badd +17 homebrew/install.zsh
badd +49 nodejs/install.zsh
badd +16 ruby/install.zsh
badd +1 ruby/auto.source.zsh
badd +6 neovim/config/plugin-setup.vim
badd +2 zsh/README.md
badd +100 neovim/config/plugin-mappings.vim
badd +8 bin/git-loglive
badd +8 git/install.zsh
badd +113 neovim/config/mappings.vim
badd +44 README.md
badd +1 bin/tmux-kill-session
badd +10 secure/install.zsh
badd +24 sshrc/.sshrc
badd +17 bin/dotfiles
badd +11 go/install.zsh
badd +3 go/auto.source.zsh
badd +1 stow/.stowrc
badd +7 stow/.stow-global-ignore
badd +33 git/.gitignore
badd +1 alfred/install.zsh
badd +27 @macos/alfred/install.zsh
badd +35 _lib
badd +18 tmux/install.zsh
badd +1 macos/install.zsh
badd +2 git/.stow-local-ignore
badd +15 @macos/defaults/install.zsh
badd +1 macos/set-defaults.sh
badd +12 @macos/homebrew/Brewfile
badd +2 homebrew/.stow-local-ignore
badd +1 ctags/.ctags
badd +11 ctags/install.zsh
badd +9 zsh/.stow-local-ignore
badd +37 zsh/bin/dotfiles
badd +1 nodejs/.tern-project
badd +71 zsh/lib/utils
badd +29 sshrc/install.zsh
argglobal
silent! argdel *
edit .travis.yml
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd t
set winminheight=1 winminwidth=1 winheight=1 winwidth=1
exe '1resize ' . ((&lines * 23 + 25) / 50)
exe '2resize ' . ((&lines * 23 + 25) / 50)
argglobal
setlocal fdm=marker
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 8 - ((7 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 021|
lcd ~/.dotfiles
wincmd w
argglobal
edit ~/.dotfiles/README.md
setlocal fdm=marker
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 7 - ((6 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
7
normal! 0
lcd ~/.dotfiles
wincmd w
exe '1resize ' . ((&lines * 23 + 25) / 50)
exe '2resize ' . ((&lines * 23 + 25) / 50)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOc
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
let g:this_session = v:this_session
let g:this_obsession = v:this_session
let g:this_obsession_status = 2
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
