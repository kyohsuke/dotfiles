vim9script
UsePlugin 'hive.vim'

augroup HiveVim
  autocmd! * <buffer>

  # for (*.hql,*.q} files
  autocmd BufNewFile,BufRead {*.hql,*.q} setlocal filetype=hive
augroup END
