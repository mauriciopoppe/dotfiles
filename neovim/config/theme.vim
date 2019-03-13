" syntax highlightling
syntax on

let g:enable_bold_font = 1

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.

let g:pencil_higher_contrast_ui = 1
let g:pencil_neutral_code_bg = 1
let g:pencil_spell_undercurl = 1

set background=dark

try
  " colorscheme pencil
  " colorscheme PaperColor
  colorscheme hybrid
  " colorscheme hybrid_reverse
  " colorscheme distinguished
catch
  echo 'could not set theme'
endtry

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
  highlight CocHighlightText ctermbg=8
  highlight link CocHighlightTextWrite CocHighlightText
  highlight link CocHighlightTextRead CocHighlightText
endfunction
call ResetHighlight()

