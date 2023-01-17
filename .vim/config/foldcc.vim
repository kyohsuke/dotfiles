vim9script
UsePlugin 'foldCC.vim'

g:foldCCtext_maxchars = 150
g:foldCCtext_tail = 'printf("   %s[%4d lines  Lv%-2d]%s", v:folddashes, v:foldend-v:foldstart+1, v:foldlevel, v:folddashes)'

set foldtext=FoldCCtext()
set foldcolumn=3
set fillchars=vert:\|
