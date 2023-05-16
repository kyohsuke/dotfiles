vim9script
UsePlugin 'vim-lsp'

g:lsp_use_native_client = 1
g:lsp_use_lua = has('nvim-0.4.0') || (has('lua') && has('patch-8.2.0775'))
g:lsp_diagnostics_echo_cursor = 1
g:lsp_format_sync_timeout = 1000
g:lsp_diagnostics_virtual_text_enabled = 0
g:lsp_diagnostics_virtual_text_prefix = '» '

command! LspDebug g:lsp_log_verbose = 1 | g:lsp_log_file = expand('~/lsp.log')

def g:LspDefinitionSplitWindow()
  split
  execute "normal \<plug>(lsp-definition)"
enddef
nnoremap <Plug>LspDefinitionS :<C-u>call LspDefinitionSplitWindow()<Return>

def OnLspBufferEnabled()
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <C-]> <plug>LspDefinitionS
  nmap <buffer> ge <plug>(lsp-document-diagnostics)
  nmap <buffer> <f2> <plug>(lsp-rename)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> K <plug>(lsp-hover)
  nmap <buffer> <c-o> <plug>(lsp-hover)
  nnoremap <buffer> gs :<C-u>CtrlPLspDocumentSymbol<Return>
  nnoremap <buffer> gS :<C-u>CtrlPLspWorkspaceSymbol<Return>

  inoremap <buffer> <expr> <C-o> lsp#internal#document_hover#under_cursor#do({}) ? '' : ''
  inoremap <buffer> <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
enddef

augroup LspInstall
  autocmd! * <buffer>
  autocmd User lsp_buffer_enabled OnLspBufferEnabled()
  autocmd BufWritePre *.rs,*.go execute('LspDocumentFormatSync')
augroup END
