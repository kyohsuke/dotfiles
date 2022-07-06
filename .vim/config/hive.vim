UsePlugin 'hive.vim'

augroup HiveVim
  autocmd! * <buffer>

  " for .hql files
  autocmd BufNewFile,BufRead *.hql set filetype=hive expandtab

  " for .q files
  autocmd BufNewFile,BufRead *.q set filetype=hive expandtab
augroup END
