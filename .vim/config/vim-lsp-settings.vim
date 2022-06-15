UsePlugin 'vim-lsp-settings'

let g:lsp_settings = {}
let g:lsp_settings_filetype_graphql = [ 'gql-language-server' ]
let g:lsp_settings_filetype_sql = [ 'sqls' ]
let g:lsp_settings_filetype_go = [ 'gopls', 'golangci-lint-langserver' ]
let g:lsp_settings['gopls'] = {
  \  'workspace_config': {
  \    'usePlaceholders': v:true,
  \    'analyses': {
  \      'fillstruct': v:true,
  \    },
  \  },
  \  'initialization_options': {
  \    'usePlaceholders': v:true,
  \    'analyses': {
  \      'fillstruct': v:true,
  \    },
  \  },
  \}

