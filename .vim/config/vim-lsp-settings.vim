vim9script
UsePlugin 'vim-lsp-settings'

g:lsp_settings_filetype_graphql = [ 'graphql-language-server' ]
g:lsp_settings_filetype_sql = [ 'sqls' ]
g:lsp_settings_filetype_go = [ 'gopls' ]
g:lsp_settings_filetype_ruby = [ 'solargraph' ]
g:lsp_settings = {
  gopls: {
    args: [
      '-rpc.trace',
      '-debug=localhost:6060',
    ],
  },
}
