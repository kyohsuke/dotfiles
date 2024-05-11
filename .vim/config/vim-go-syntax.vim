vim9script
UsePlugin 'vim-go-syntax'

augroup VimGoSyntax
  # GoHtmlTmpl
  def DetectGoHtmlTmpl()
    if search("{{") != 0
      setf gohtmltmpl
    endif
  enddef
  defc

  autocmd!
  autocmd FileType go setlocal foldmethod=syntax regexpengine=1
  autocmd BufRead,BufNewFile *.html DetectGoHtmlTmpl()
augroup END
