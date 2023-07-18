vim9script
UsePlugin 'vim-better-whitespace'

g:better_whitespace_enabled = 1
g:strip_whitespace_on_save  = 1
g:strip_whitespace_confirm  = 0
g:strip_only_modified_lines = 1
g:strip_whitelines_at_eof   = 1
g:diff_binary = 'diff'

augroup BetterWhiteSpace
  autocmd! * <buffer>

  autocmd FileType MAKE DisableStripWhitespaceOnSave
  autocmd FileType GOHTMLTMPL DisableStripWhitespaceOnSave
augroup END
