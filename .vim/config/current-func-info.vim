vim9script
UsePlugin 'current-func-info.vim'

&statusline = &statusline .. ' [%{cfi#format("%s", "")}]'
