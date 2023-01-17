vim9script
UsePlugin 'hive.vim'

augroup HiveVim
  autocmd! * <buffer>

  # for .hql files
  autocmd BufNewFile,BufRead *.hql setlocal filetype=hive expandtab

  # for .q files
  autocmd BufNewFile,BufRead *.q setlocal filetype=hive expandtab
augroup END
