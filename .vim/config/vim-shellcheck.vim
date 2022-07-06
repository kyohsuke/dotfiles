UsePlugin 'vim-shellcheck'

augroup vim_shellcheck_autocmd
  autocmd! * <buffer>
  autocmd FileType sh autocmd BufWritePre <buffer> ShellCheck!
augroup END
