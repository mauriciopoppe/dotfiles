" Basic settings {{{
" default shell is zsh
set shell=/bin/zsh
" line numbering on
set number
" hide last line message (e.g. hide --INSERT--)
set noshowmode
" wrap text at 80 characters
set textwidth=80
" column width indicator
set colorcolumn=+1
" hiden instead of unload a buffer when abandoned
set hidden
" yank operation don't need to use the *" register (system clipboard)
set clipboard+=unnamed
" don't show matching brackets (performance improvement)
set noshowmatch
" when switching buffers don't move to the start of the line
set nostartofline
" minimum number of lines shown above the cursor when scrolling
set scrolloff=5
" allow positioning the cursor in places where there is no characters
set virtualedit=block
" time to send the CursorHold autocommand event
set updatetime=700
" read file changes on update
set autoread
" write the contents of a the file if it was modified because of some vim commands
set autowriteall
" show incomplete commands
set showcmd
" time to wait for a mapped sequence to complete
" e.g. wait 500ms when typing `j` and after `k` to exit from insert mode
set timeoutlen=500
" }}}
" Indentation settings {{{

" replace tab with spaces (insert a tab with <c-v><tab>)
set expandtab
" number of spaces inserted when <tab> is pressed (on insert mode)
set softtabstop=2
" how many columns are indented with the indent operations (<< and >>)
set shiftwidth=2
" how many places should a tab be seen as
set tabstop=4
" }}}
" Display settings {{{

set mouse=a
" wrap long lines (doesn't change what's on the buffer)
set linebreak
" show invisible chars
set list
" strings to use in list mode
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
" string to use at the start of lines that have been wrapped
set showbreak=↪
" disable parenthesis matching (improve scroll performance a little bit)
let loaded_matchparen = 1

" }}}
" Split settings {{{

" :hsplit will put a window below the current window
set splitbelow
" :vsplit will put a window right the current window
set splitright
" }}}
" Backup settings {{{

" disable swap files
set noswapfile
" disable making a backup before owerwriting a file
set nobackup
" enable persistent undo with a filename=full path
set undofile
" undo files are stored inside the following path
set undodir=~/.config/nvim/undo
" }}}
" Spelling settings {{{

" spellfile location
set spellfile=~/.config/nvim/spell/dictionary.utf-8.add
" language is US english
set spelllang=en_us
" }}}
" Search settings {{{

" -- default on
" set incsearch

" ignore case by default
set ignorecase
" make search case sensitive only if it contains uppercase letters
set smartcase
" search again from top when it reaches the bottom
set wrapscan
" don't highlight after search
set nohlsearch
" }}}
" Filetype settings {{{

" enable the loading of plugin files for specific file types
filetype plugin on
" enable the loading of indent files for specific file types
filetype indent on
" }}}
" Folding settings {{{

" markers are used to specify folds
set foldmethod=marker
" 2nd level folding
set foldlevelstart=2
" characters to fill in the fold
set fillchars="fold: "

" }}}
" Omni completion settings {{{

" complete also from dictionary
set complete+=kspell
" insert the longest common text of the matches
set completeopt+=longest
set completeopt+=noinsert
set completeopt+=noselect

" quiet messages in auto completion
set shortmess+=c

" note set wildmenu is set by default
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=.git\*,.hg\*,.svn\*

" }}}
