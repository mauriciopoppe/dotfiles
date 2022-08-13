" syntax highlightling
syntax on

let g:enable_bold_font = 1

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.

let g:pencil_higher_contrast_ui = 1
let g:pencil_neutral_code_bg = 1
let g:pencil_spell_undercurl = 1

if has('nvim') || has('termguicolors')
  set termguicolors
endif

" ChangeBackground changes the background mode based on macOS's `Appearance`
" setting. We also refresh the statusline colors to reflect the new mode.
function! ChangeBackground()
  set background=dark
  if filereadable(expand("~/.tmux.theme"))
    let g:tmux_theme_lines = readfile(expand("~/.tmux.theme"))
    if g:tmux_theme_lines[0] == "dark"
      try
        set background=dark
        colorscheme hybrid
        call v:lua.lualine_refresh_theme('dark')
      catch
        echo 'could not set theme'
      endtry
    elseif g:tmux_theme_lines[0] == "light"
      try
        set background=light
        colorscheme tokyonight
        call v:lua.lualine_refresh_theme('light')
      catch
        echo 'could not set theme'
      endtry
    else
      echo 'theme not supported'
    endif
  endif

endfunction

function ResetHighlight()
  " Link highlight groups to improve buftabline colors
  hi! link BufTabLineCurrent PreProc
  hi! link BufTabLineActive Comment
  hi! link BufTabLineHidden Comment
  hi! link BufTabLineFill Comment

  " clear background for SignColumn (any column that doesn't have a sign)
  highlight clear SignColumn
  " clear sign background
  highlight SignifySignAdd    cterm=none ctermbg=none ctermfg=lightgreen
  highlight SignifySignDelete cterm=none ctermbg=none ctermfg=red
  highlight SignifySignChange cterm=none ctermbg=none ctermfg=yellow

  " italic html attributes
  highlight htmlArg cterm=italic
  highlight Comment cterm=italic

  " neomake errors
  highlight link NeomakeError DiffDelete
  highlight link NeomakeWarning Question
  highlight NeomakeErrorSign cterm=none ctermbg=none ctermfg=red

  " ale errors
  highlight link ALEErrorSign DiffDelete
  highlight link ALEWarningSign Question
  highlight ALEErrorSign cterm=none ctermbg=none ctermfg=red

  highlight Search cterm=none ctermfg=none ctermbg=8

  " coc (autocomplete)
  highlight CocHighlightText ctermbg=6
  highlight link CocHighlightTextWrite CocHighlightText
  highlight link CocHighlightTextRead CocHighlightText
endfunction

function ChangeTheme()
  " initialize the colorscheme for the first run
  call ChangeBackground()
  call ResetHighlight()
endfunction

call ChangeTheme()

