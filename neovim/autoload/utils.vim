" strip trailing whitespaces
" source:
"   http://vimcasts.org/episodes/tidying-whitespace/
function! utils#preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! utils#forgetUndo(command)
  let old_undolevels = &undolevels
  set undolevels=-1
  execute a:command
  let &undolevels = old_undolevels
  unlet old_undolevels
endfunction

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
function! utils#cursorJumpToLastPosition()
  if &filetype !~ 'svn\|commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
    endif
  end
endfunction

" creates html <kbd> tags out of vim's key combinations
"
" input:
"
"     noremap <C-y>,
"               |
"             cursor
"
" output:
"
"     <kbd>C-y></kbd> <kbd>,</kbd>
"
function! utils#kbd()
  let tokens = split(expand("<cWORD>"), '\zs')
  let keys = []
  let ltopen = 0
  let current = ""
  for letter in tokens
    if letter == "<"
      let ltopen = 1
    elseif letter == ">"
      let ltopen = 0
    else
      let current .= letter
    endif
    if ltopen == 0
      let keys = add(keys, "<kbd>" . current . "</kbd>")
      let current = ""
    endif
  endfor
  let joined = join(keys)
  execute 'normal! ciW'.joined
endfunction

" unite
function! utils#uniteSources()
  execute 'Unite -no-split -buffer-name=sources -start-insert source'
endfunction

function! utils#uniteFileRecursive()
  execute 'Unite -no-split -buffer-name=files -start-insert file_rec/async:!'
endfunction

function! utils#uniteFileBrowse()
  execute 'Unite -no-split -buffer-name=project-files -start-insert file'
endfunction

function! utils#uniteBuffers()
  execute 'Unite -no-split -buffer-name=buffers -start-insert buffer'
endfunction

function! utils#uniteOutline()
  execute 'Unite -no-split -buffer-name=symbols -start-insert outline'
endfunction

function! utils#uniteMRUs()
  execute 'Unite -no-split -buffer-name=most-recently-used -start-insert neomru/file'
endfunction

function! utils#uniteTags()
  execute 'Unite -no-split -buffer-name=tags -start-insert tag'
endfunction

function! utils#uniteGrep()
  execute 'Unite -no-split -buffer-name=ag -silent grep:.'
endfunction

function! utils#uniteHistory()
  execute 'Unite -no-split -buffer-name=edit-history change'
endfunction

function! utils#uniteLineSearch()
  execute 'Unite -no-split -buffer-name=line-search -start-insert line'
endfunction

function! utils#uniteYankHistory()
  execute 'Unite -no-split -buffer-name=yank-history history/yank'
endfunction

function! utils#uniteRegisters()
  execute 'Unite -no-split -buffer-name=registers register'
endfunction

function! utils#uniteWindows()
  execute 'Unite -no-split -buffer-name=splits window'
endfunction

function! utils#uniteSnippets()
  execute 'Unite -no-split -buffer-name=snippets -start-insert ultisnips'
endfunction

function! utils#uniteFugitive()
  execute 'Unite -no-split -buffer-name=menu -start-insert menu:git'
endfunction

function! utils#uniteJumps()
  execute 'Unite -no-split -buffer-name=jumps -start-insert jump'
endfunction

