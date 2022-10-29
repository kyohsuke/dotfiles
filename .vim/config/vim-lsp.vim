UsePlugin 'vim-lsp'

let g:lsp_use_lua = has('nvim-0.4.0') || (has('lua') && has('patch-8.2.0775'))
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_format_sync_timeout = 1000

command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  function! s:lsp_definition_split_window() abort
    split
    execute "normal \<plug>(lsp-definition)"
  endfunction
  nnoremap <Plug>LspDefinitionS :<C-u>call <SID>lsp_definition_split_window()<Return>

  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <C-]> <plug>LspDefinitionS
  nmap <buffer> ge <plug>(lsp-document-diagnostics)
  nmap <buffer> <f2> <plug>(lsp-rename)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> <c-o> <plug>(lsp-hover)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> K <plug>(lsp-hover)
  nnoremap <buffer> gs :<C-u>CtrlPLspDocumentSymbol<Return>
  nnoremap <buffer> gS :<C-u>CtrlPLspWorkspaceSymbol<Return>

  inoremap <buffer> <expr> <C-o> lsp#internal#document_hover#under_cursor#do({}) ? '' : ''
  inoremap <buffer> <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"

  " setlocal foldmethod=expr foldexpr=lsp#ui#vim#folding#foldexpr() foldtext=lsp#ui#vim#folding#foldtext() " 激重なので常用するのは無理
endfunction

augroup LspInstall
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  autocmd BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
augroup END
