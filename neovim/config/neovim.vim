" https://neovim.io/doc/user/starting.html#shada-file
" shared data
augroup MyAutoCmd
	autocmd CursorHold * if exists(':rshada') | rshada | wshada | endif
augroup END

" Search and use environments specifically made for Neovim.
if isdirectory($VARPATH.'/venv/neovim')
	let g:python_host_prog = $VARPATH.'/venv/neovim/bin/python'
endif

" let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
