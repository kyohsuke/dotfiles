UsePlugin 'vim-shellcheck'

augroup vim_shellcheck_autocmd
  autocmd!
  autocmd FileType sh autocmd BufWritePre <buffer> ShellCheck!
augroup END
