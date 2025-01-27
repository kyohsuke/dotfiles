UsePlugin 'vim-go-syntax'

augroup VimGoSyntax
  " GoHtmlTmpl
  function! s:DetectGoHtmlTmpl()
    if search("{{") != 0
      setf gohtmltmpl
    endif
  endfunction

  autocmd!
  autocmd FileType go setlocal foldmethod=syntax regexpengine=1
  autocmd BufRead,BufNewFile *.html call <SID>DetectGoHtmlTmpl()
augroup END
