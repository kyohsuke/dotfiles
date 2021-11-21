UsePlugin 'vim-ugitive'

nnoremap <expr><Leader>gg ":<C-u>Ggrep " . expand('<cword>') . "<Return>"

augroup VimFugitive
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END
