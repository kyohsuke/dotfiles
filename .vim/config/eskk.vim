vim9script
UsePlugin 'eskk.vim'

g:eskk#egg_like_newline = 1
g:eskk#show_annotation = 1
g:eskk#fix_extra_okuri = 0
g:eskk#enable_completion = 0

g:eskk#large_dictionary = {
  path: '~/.vim/stash/SKK-JISYO.L',
  sorted: 1,
  encoding: 'euc-jp',
}
g:eskk#dictionary = {
	path: "~/.skk-jisyo",
	sorted: 0,
	encoding: 'utf-8',
}
