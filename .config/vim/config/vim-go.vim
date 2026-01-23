UsePlugin 'vim-go'

let g:go_decls_mode = 'ctrlp.vim'
let g:go_decls_includes = 'func'
let g:go_doc_popup_window = 1

augroup VimGo
  " GoHtmlTmpl
  function! s:DetectGoHtmlTmpl()
    if search("{{") != 0
      setf gohtmltmpl
    endif
  endfunction


  function! s:OnBufferEnabled()
    setlocal foldmethod=syntax regexpengine=1

    nnoremap <buffer> <C-]> <plug>(go-def-split)
    nnoremap <buffer> <f2> <plug>(go-rename)
    nnoremap <buffer> gr <plug>(go-referrers)
    nnoremap <buffer> gi <plug>(go-implements)
    nnoremap <buffer> gt <plug>(go-def-type)
    nnoremap <buffer> gs :<C-u>GoDecls<Return>
    nnoremap <buffer> gS :<C-u>GoDeclsDir<Return>
    inoremap <buffer> <c-space> <C-x><C-o>
  endfunction

  autocmd!
  autocmd FileType go call <SID>OnBufferEnabled()
  autocmd BufRead,BufNewFile *.html call <SID>DetectGoHtmlTmpl()
augroup END
