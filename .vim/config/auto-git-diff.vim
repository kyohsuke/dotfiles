UsePlugin 'auto-git-diff'

augroup AutoGitDiff
  function! s:setup_auto_git_diff() abort
    nmap <buffer><C-l> <plug>(auto_git_diff_scroll_manual_update)
    nmap <buffer><C-n> <plug>(auto_git_diff_scroll_down_half)
    nmap <buffer><C-p> <plug>(auto_git_diff_scroll_up_half)
  endfunction
  autocmd!
  autocmd FileType gitrebase call <SID>setup_auto_git_diff()
augroup END
