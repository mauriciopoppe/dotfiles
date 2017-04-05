" Basic settings {{{
" default shell is zsh
set shell=/bin/zsh
" line numbering on
set number
 " disable default status ruler
set noruler
" hide last line message (e.g. hide --INSERT--)
set noshowmode
" modeline
set modeline
" don't report line settings
set report=0
" wrap text at 80 characters
set textwidth=80
" max column width indicator
set colorcolumn=80
" hide instead of unload a buffer when abandoned
set hidden
" regexp magic
set magic
" yank operation don't need to use the *" register (system clipboard)
set clipboard=unnamed
" when switching buffers don't move to the start of the line
set nostartofline
" minimum number of lines shown above the cursor when scrolling
set scrolloff=5
" allow positioning the cursor in places where there is no characters
set virtualedit=block
" read file changes on update
set autoread
" write the contents of a the file if it was modified because of some vim commands
set autowriteall
" show incomplete commands
set noshowcmd
" height of the command line
set cmdwinheight=5
set noequalalways
set laststatus=2
" time to wait for a mapped sequence to complete
" e.g. wait 500ms when typing `j` and after `k` to exit from insert mode
set timeout ttimeout
set timeoutlen=500
set updatetime=700
" Time out on key codes
if has('nvim')
" https://github.com/neovim/neovim/issues/2017
  set ttimeoutlen=-1
else
  set ttimeoutlen=250
endif
" don't break lines after a one-letter word
set formatoptions+=1
" don't auto-wrap text
set formatoptions-=t
" }}}
" Indentation settings {{{

" replace tab with spaces (insert a tab with <c-v><tab>)
set expandtab
" number of spaces inserted when <tab> is pressed (on insert mode)
set tabstop=2
set softtabstop=2
" how many columns are indented with the indent operations (<< and >>)
set shiftwidth=2
set autoindent
set smartindent
set shiftround
" Intuitive backspacing in insert mode
set backspace=indent,eol,start
" }}}
" Display settings {{{

set display=lastline
set nowrap
" wrap long lines (doesn't change what's on the buffer)
set linebreak
" Long lines break chars
set breakat=\ \	;:,!?
" Cursor in same column for few commands
set nostartofline
" Diff mode: show fillers, ignore white
set diffopt=filler,iwhite
" Show tag and tidy search in completion
set showfulltag
" show invisible chars
set list
" Pop-up menu's line height
set pumheight=20
" strings to use in list mode
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
" string to use at the start of lines that have been wrapped
set showbreak=↪
" what to save on the session
set viewoptions-=options
set viewoptions+=slash,unix
set sessionoptions-=blank
set sessionoptions-=options
set sessionoptions-=globals
set sessionoptions-=folds
set sessionoptions-=help
set sessionoptions-=buffers
set sessionoptions+=tabpages

" Do not display completion messages
" Patch: https://groups.google.com/forum/#!topic/vim_dev/WeBBjkXE8H8
if has('patch-7.4.314')
  set shortmess+=c
endif

" Do not display message when editing files
if has('patch-7.4.1570')
  set shortmess+=F
endif

" For snippet_complete marker
if has('conceal') && v:version >= 703
  set conceallevel=2 concealcursor=niv
endif
" }}}
" Split settings {{{

" :hsplit will put a window below the current window
set splitbelow
" :vsplit will put a window right the current window
set splitright
" }}}
" Backup settings {{{

" disable swap files
set undofile noswapfile nobackup
set directory=$VARPATH/swap//,$VARPATH,~/tmp,/var/tmp,/tmp
set undodir=$VARPATH/undo//,$VARPATH,~/tmp,/var/tmp,/tmp
set backupdir=$VARPATH/backup/,$VARPATH,~/tmp,/var/tmp,/tmp
set viewdir=$VARPATH/view/
set nospell spellfile=$VIMPATH/spell/en.utf-8.add
" History saving
set history=2000
if has('nvim')
"  ShaDa/viminfo:
"   ' - Maximum number of previously edited files marks
"   < - Maximum number of lines saved for each register
"   @ - Maximum number of items in the input-line history to be
"   s - Maximum size of an item contents in KiB
"   h - Disable the effect of 'hlsearch' when loading the shada
  set shada='300,<10,@50,s100,h
else
  set viminfo='300,<10,@50,h,n$VARPATH/viminfo
endif
" }}}
" Spelling settings {{{

" spellfile location
set spellfile=~/.config/nvim/spell/dictionary.utf-8.add
" language is US english
set spelllang=en_us
" }}}
" Search settings {{{

" ignore case by default
set ignorecase
" incremental search
set incsearch
" infer the case on insert mode
set infercase
" make search case sensitive only if it contains uppercase letters
set smartcase
set smarttab
" search again from top when it reaches the bottom
set wrapscan
" don't highlight after search
set nohlsearch
" jump to matching bracket with %
set showmatch
set matchpairs+=<:>
set matchtime=1
" showmatch will wait 0.5s or until a char is typed
set cpoptions-=m
" }}}

" Folding settings {{{

set foldenable
set foldmethod=syntax
set foldlevelstart=99
set foldtext=FoldText()

" Improved Vim fold-text
" See: http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
function! FoldText()
  " Get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~? '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = ' ' . foldSize . ' lines '
  let foldLevelStr = repeat('+--', v:foldlevel)
  let lineCount = line('$')
  let foldPercentage = printf('[%.1f', (foldSize*1.0)/lineCount*100) . '%] '
  let expansionString = repeat('.', w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
  return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction

" }}}
" Omni completion settings {{{

" complete also from dictionary
set complete=.
set complete+=kspell
" set the same default (menu,preview)
set completeopt="menu,preview"
" insert the longest common text of the matches
set completeopt+=longest
" avoid creating another buffer with the preview
set completeopt-=preview
if has('patch-7.4.775')
  set completeopt+=noinsert
endif
if exists('+inccommand')
  set inccommand=nosplit
endif

" note set wildmenu is set by default
if has('wildmenu')
  set nowildmenu
  set wildmode=list:longest,full
  set wildoptions=tagfile
  set wildignorecase
  set wildignore+=*vim/backups*
  set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
  set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
  set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
  set wildignore+=__pycache__,*.egg-info
endif

" }}}

" vim: set ts=2 sw=2 tw=80 et :
