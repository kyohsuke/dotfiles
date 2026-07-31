UsePlugin 'auto-git-diff'

let g:auto_git_diff_command_options = '--no-ext-diff --stat -p -C -C'

augroup AutoGitDiff
  function s:SetupAutoGitDiff()
    nnoremap <buffer> <C-l> <plug>(auto_git_diff_scroll_manual_update)
    nnoremap <buffer> <C-n> <plug>(auto_git_diff_scroll_down_half)
    nnoremap <buffer> <C-p> <plug>(auto_git_diff_scroll_up_half)
  endfunction

  autocmd!
  autocmd FileType gitrebase call <SID>SetupAutoGitDiff()
augroup END
