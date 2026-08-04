UsePlugin 'vim-lsp'

let g:lsp_use_lua = has('nvim-0.4.0') || (has('lua') && has('patch-8.2.0775'))
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_format_sync_timeout = 1000
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_virtual_text_prefix = '» '

command! LspDebug let g:lsp_log_verbose = 1 | let g:lsp_log_file = expand('~/lsp.log')

function! g:LspDefinitionSplitWindow()
  split
  call lsp#ui#vim#definition(0)
endfunction

function! g:LspRestartServer() abort
  let l:servers =lsp#get_allowed_servers()
  for l:server in l:servers
    echomsg "[vim-lsp] Restarting " . l:server
    call lsp#stop_server(l:server)
  endfor
  redraw

  call lsp#activate()
endfunction
command! LspRestartServer call g:LspRestartServer()

function! s:OnLspBufferEnabled()
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  nnoremap <buffer> gd <plug>(lsp-definition)
  nnoremap <buffer> <C-]> :<C-u>call LspDefinitionSplitWindow()<Return>
  nnoremap <buffer> ge <plug>(lsp-document-diagnostics)
  nnoremap <buffer> <f2> <plug>(lsp-rename)
  nnoremap <buffer> gr <plug>(lsp-references)
  nnoremap <buffer> gi <plug>(lsp-implementation)
  nnoremap <buffer> gt <plug>(lsp-type-definition)
  nnoremap <buffer> K <plug>(lsp-hover)
  nnoremap <buffer> <c-o> <plug>(lsp-hover)
  nnoremap <buffer> gs :<C-u>CtrlPLspDocumentSymbol<Return>
  nnoremap <buffer> gS :<C-u>CtrlPLspWorkspaceSymbol<Return>

  inoremap <buffer> <expr> <C-o> lsp#internal#document_hover#under_cursor#do({}) ? '' : ''
  inoremap <buffer> <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

augroup VimLsp
  autocmd!
  autocmd User lsp_buffer_enabled call <SID>OnLspBufferEnabled()
  " autocmd BufWritePre *.rs, execute('LspDocumentFormatSync')
  autocmd BufWritePre *.rs,*.go execute('LspDocumentFormatSync')
augroup END
