UsePlugin 'eskk.vim'

let g:eskk#egg_like_newline = 1
let g:eskk#show_annotation = 1
let g:eskk#fix_extra_okuri = 0
let g:eskk#enable_completion = 0
let g:eskk#directory = $XDG_CACHE_HOME .. "/eskk"
let g:eskk#large_dictionary = {
      \ 'path': $XDG_CONFIG_HOME .. '/skkdic/SKK-JISYO.L',
      \ 'sorted': 1,
      \ 'encoding': 'euc-jp',
      \ }
let g:eskk#dictionary = {
      \ 'path': $XDG_DATA_HOME .. "/vim/skk-jisyo",
	    \ 'sorted': 0,
	    \ 'encoding': 'utf-8',
      \ }
