vim9script
UsePlugin 'vim-go-syntax'

augroup VimGoSyntax
  autocmd! * <buffer>

  # Golang
  autocmd FileType go setlocal foldmethod=syntax

  # GoHtmlTmpl
  def DetectGoHtmlTmpl()
    if expand('%:e') == "html" && search("{{") != 0
      setf gohtmltmpl
    endif
  enddef
  defc

  autocmd BufRead,BufNewFile * DetectGoHtmlTmpl()
augroup END
