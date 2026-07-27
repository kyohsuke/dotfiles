UsePlugin 'vim-lsp-settings'

let g:lsp_settings_filetype_graphql = [ 'graphql-language-server' ]
let g:lsp_settings_filetype_sql = [ 'sqls' ]
let g:lsp_settings_filetype_go = [ 'gopls' ]
let g:lsp_settings_filetype_ruby = [ 'solargraph' ]
let g:lsp_settings = {
      \   'gopls': {
      \     'args': [
      \       '-rpc.trace',
      \       '-debug=localhost:6060',
      \     ],
      \     'workspace_config': {
      \       'gopls': {
      \         'directoryFilters': [
      \           '-.git',
      \           '-**/.github',
      \           '-**/node_modules'
      \         ]
      \       }
      \     }
      \   },
      \  'efm-langserver': {
      \     'disabled': v:true
      \   }
      \ }
