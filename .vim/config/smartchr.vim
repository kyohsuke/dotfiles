UsePlugin 'vim-smartchr'

inoremap <expr> / smartchr#loop('/', '//', '\/')

augroup SmartChr
  autocmd! * <buffer>

  " Ruby
  autocmd FileType ruby,rails inoremap <buffer> <expr> <bar> smartchr#one_of('<bar>', '<bar><bar>', '<bar><bar>=')
  autocmd FileType ruby,rails inoremap <buffer> <expr> = smartchr#one_of('=', '==', '=>')
  autocmd FileType ruby,rails inoremap <buffer> <expr> { smartchr#loop('{', '#{', '{{')

  " Python
  autocmd FileType python inoremap <buffer> <expr> ? smartchr#loop('?', '\?')
augroup END
