vim9script
UsePlugin 'vim-fugitive'

nnoremap <expr><Leader>gg ":<C-u>Ggrep " .. expand('<cword>') .. "<Return>"

augroup VimFugitive
  autocmd! * <buffer>
  autocmd QuickFixCmdPost *grep* cwindow
augroup END
