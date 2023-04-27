UsePlugin 'vim-lsp-settings'

let g:lsp_settings_filetype_graphql = [ 'graphql-language-server' ]
let g:lsp_settings_filetype_sql = [ 'sqls' ]
" let g:lsp_settings_filetype_go = [ 'gopls', 'golangci-lint-langserver' ]

augroup JsonnetLanguageServer
  autocmd! * <buffer>
  if executable('jsonnet-language-server')
    autocmd User lsp_setup call lsp_settings#register_server({
          \ 'name': 'jsonnet-language-server',
          \ 'cmd': {
          \   server_info->lsp_settings#get(
          \   'jsonnet-language-server',
          \   'cmd',
          \   [lsp_settings#exec_path('jsonnet-language-server')]+lsp_settings#get('jsonnet-language-server', 'args', ['-t'])
          \ )},
          \ 'root_uri':{server_info->lsp_settings#get('jsonnet-language-server', 'root_uri', lsp_settings#root_uri('jsonnet-language-server'))},
          \ 'initialization_options': lsp_settings#get('jsonnet-language-server', 'initialization_options', v:null),
          \ 'allowlist': lsp_settings#get('jsonnet-language-server', 'allowlist', ['jsonnet']),
          \ 'blocklist': lsp_settings#get('jsonnet-language-server', 'blocklist', []),
          \ 'config': lsp_settings#get('jsonnet-language-server', 'config', lsp_settings#server_config('jsonnet-language-server')),
          \ 'workspace_config': lsp_settings#get('jsonnet-language-server', 'workspace_config', {
          \   'jsonnet': {'lint': {'validProperties': []}},
          \ }),
          \ 'semantic_highlight': lsp_settings#get('jsonnet-language-server', 'semantic_highlight', {}),
          \ })
  endif
augroup END
