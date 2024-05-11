vim9script
UsePlugin 'hive.vim'

augroup HiveVim
  autocmd!

  # for (*.hql,*.q} files
  autocmd BufNewFile,BufRead {*.hql,*.q} setf hive
augroup END
