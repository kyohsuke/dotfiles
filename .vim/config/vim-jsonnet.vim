UsePlugin 'vim-jsonnet'

let g:jsonnet_fmt_on_save = 0

augroup VimJsonnet
  autocmd! * <buffer>
  autocmd FileType jsonnet setlocal smartindent
augroup END
