" syntax highlightling
syntax on

let g:enable_bold_font = 1

" let g:hybrid_custom_term_colors = 1
" let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.

set background=dark
try
  " colorscheme hybrid
  colorscheme hybrid_reverse
  " colorscheme distinguished
catch
  echo 'could not set theme'
endtry

" Link highlight groups to improve buftabline colors
hi! link BufTabLineCurrent Statement
hi! link BufTabLineActive Comment
hi! link BufTabLineHidden Comment
hi! link BufTabLineFill Comment

" delete git signs background
highlight SignifySignAdd    cterm=NONE ctermbg=NONE  ctermfg=119
highlight SignifySignDelete cterm=NONE ctermbg=NONE  ctermfg=167
highlight SignifySignChange cterm=NONE ctermbg=NONE  ctermfg=227

" italic html attributes
highlight htmlArg cterm=italic
" highlight Comment cterm=italic

