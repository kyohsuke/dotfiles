vim9script
UsePlugin 'vim-go-syntax'

augroup VimGoSyntax
  autocmd! * <buffer>

  # Golang
  autocmd FileType go setlocal noexpandtab ts=4 sts=4 sw=4 foldmethod=syntax

  # GoHtmlTmpl
  def DetectGoHtmlTmpl()
    if expand('%:e') == "html" && search("{{") != 0
      setf gohtmltmpl
    endif
  enddef
  defc

  autocmd BufRead,BufNewFile * DetectGoHtmlTmpl()
augroup END
