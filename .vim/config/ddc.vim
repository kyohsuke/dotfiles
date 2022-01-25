UsePlugin 'ddc-vim-lsp'

call ddc#custom#patch_global('sources', ['vim-lsp'])
call ddc#custom#patch_global('sourceOptions', {
      \ '_': { 'matchers': ['matcher_head'] },
      \ 'vim-lsp': {
      \   'mark': 'lsp',
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*' },
      \ })
