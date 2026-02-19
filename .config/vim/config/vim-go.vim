UsePlugin 'vim-go'

" メタルインタープリターを実行した時に自動的にエラー位置にジャンプするかどうかを設定するオプション。デフォルトではジャンプが有効になっている。
let g:go_jump_to_error = 0

" GoDoc をバルーン表示するかどうかを設定するオプション。詳細は go#tool#DescribeBalloon() を参照。デフォルトでは無効になっている。
let g:go_doc_balloon = 1

" gopls の診断情報を有効にするオプション。0 は無効、1 はエラーのみ、2 はエラーと警告を表示する。
let g:go_diagnostics_level = 2

" K キーおよび :GoDoc の表示にプレビューウィンドウではなくポップアップウィンドウを使用するかどうかを設定するオプション。
" デフォルトではこの機能は無効になっている。
let g:go_doc_popup_window = 1

let g:go_decls_includes = 'func'
let g:go_decls_mode = 'ctrlp.vim'

" コマンド出力用に利用するリストの表示方法を設定するオプション。'quickfix' または 'locationlist' を指定できる。
" デフォルトは実行されたコマンドに応じて自動的に選択される。
let g:go_list_type = 'quickfix'

" コマンド出力用のリストの高さを設定するオプション。デフォルトは 0 (自動調整)。
let g:go_list_height = 10

" 強調表示
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_diagnostic_errors = 1

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
    nnoremap <buffer> ge <plug>(go-diagnostics)
    nnoremap <buffer> <f2> <plug>(go-rename)
    nnoremap <buffer> gr <plug>(go-referrers)
    nnoremap <buffer> gi <plug>(go-implements)
    nnoremap <buffer> gt <plug>(go-def-type)
    nnoremap <buffer> gs :<C-u>GoDecls<Return>
    nnoremap <buffer> gS :<C-u>GoDeclsDir<Return>

    inoremap <buffer> <C-space> <C-x><C-o>

    augroup OnBufferVimGo
      autocmd! * <buffer>
      autocmd BufWritePost <buffer> silent! :<C-u>GoDiagnostics
    augroup END
  endfunction

  autocmd!
  autocmd FileType go call <SID>OnBufferEnabled()
  autocmd BufRead,BufNewFile *.html call <SID>DetectGoHtmlTmpl()
augroup END
