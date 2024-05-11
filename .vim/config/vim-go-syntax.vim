vim9script
UsePlugin 'vim-go-syntax'

augroup VimGoSyntax
  autocmd! * <buffer>

  # Golang
  autocmd FileType go setlocal foldmethod=syntax regexpengine=1 synmaxcol=500

  # GoHtmlTmpl
  def DetectGoHtmlTmpl()
    if expand('%:e') == "html" && search("{{") != 0
      setf gohtmltmpl
    endif
  enddef
  defc

  autocmd BufRead,BufNewFile * DetectGoHtmlTmpl()
augroup END
