UsePlugin 'vim-goimports'

augroup Golang
  autocmd!

  " Golang
  autocmd FileType go setlocal noexpandtab ts=4 sts=4 sw=4

  " GoHtmlTmpl
  function! s:DetectGoHtmlTmpl()
    if expand('%:e') == "html" && search("{{") != 0
      setf gohtmltmpl 
    endif
  endfunction

  autocmd BufRead,BufNewFile * call s:DetectGoHtmlTmpl()
augroup END
