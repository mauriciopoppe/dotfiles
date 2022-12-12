" strip trailing whitespaces
" source:
"   http://vimcasts.org/episodes/tidying-whitespace/
function! utils#preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute 'keeppatterns ' . a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! utils#whitespace()
  call utils#preserve("%s/\\s\\+$//e")
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

function! utils#runLastCommand()
  if !exists("g:VimuxRunnerIndex") || _VimuxHasRunner(g:VimuxRunnerIndex) == -1
    call VimuxOpenRunner()
  endif
  let resetSequence = _VimuxOption("g:VimuxResetSequence", "q C-u")
  call VimuxSendKeys(resetSequence)
  call VimuxSendText('!!')
  call VimuxSendKeys("Enter Enter")
endfunction

function! utils#execScript()
  if !exists("g:VimuxRunnerIndex") || _VimuxHasRunner(g:VimuxRunnerIndex) == -1
    call VimuxOpenRunner()
  endif
  let resetSequence = _VimuxOption("g:VimuxResetSequence", "q C-u")
  call VimuxSendKeys(resetSequence)
  update
  if (&ft=~'javascript')
    VimuxRunCommand('clear; node ' . expand('%:p'))
  endif
  if (&ft=~'python')
    VimuxRunCommand('clear; python3 ' . expand('%:p'))
  endif
endfunction
command! ExecScript call utils#execScript()

function! utils#hasPlugin(repo) abort
  let name = fnamemodify(a:repo, ':t:s?\.git$??')
  return has_key(g:plugs, name)
endfunction
