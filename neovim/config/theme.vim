" syntax highlightling
syntax on

let g:enable_bold_font=1
set background=dark
try
  colorscheme hybrid_reverse
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

