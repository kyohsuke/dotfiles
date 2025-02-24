UsePlugin 'vim-fugitive'

nnoremap <expr><Leader>gg ":<C-u>Ggrep " .. expand('<cword>') .. "<Return>"

augroup VimFugitive
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END
