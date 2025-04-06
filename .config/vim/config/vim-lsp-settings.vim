UsePlugin 'vim-lsp-settings'

let g:lsp_settings_filetype_graphql = [ 'graphql-language-server' ]
let g:lsp_settings_filetype_sql = [ 'sqls' ]
let g:lsp_settings_filetype_go = [ 'gopls' ]
let g:lsp_settings = {
      \   'gopls': {
      \     'args': [
      \       '-rpc.trace',
      \       '-debug=localhost:6060',
      \     ],
      \   },
      \  'efm-langserver': {
      \     'disabled': v:false
      \   }
      \ }
