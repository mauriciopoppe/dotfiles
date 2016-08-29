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
"     <kbd>C-y</kbd> <kbd>,</kbd>
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

function! utils#standardFormat()
  execute "!standard-format --write %" 
endfunction

function! utils#runLastCommand()
  if !exists("g:VimuxRunnerIndex") || _VimuxHasRunner(g:VimuxRunnerIndex) == -1
    call VimuxOpenRunner()
  endif

  let resetSequence = _VimuxOption("g:VimuxResetSequence", "q C-u")
  call VimuxSendKeys(resetSequence)
  call VimuxSendText('!!')
  call VimuxSendKeys("Enter Enter")
endfunction

