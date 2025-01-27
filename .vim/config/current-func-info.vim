UsePlugin 'current-func-info.vim'

let &statusline .= ' [%{cfi#format("%s", "")}]'
