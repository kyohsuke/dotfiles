vim9script
UsePlugin 'editorconfig-vim'

augroup EditorConfig
  autocmd! * <buffer>
  autocmd FileType gitconfig let b:EditorConfig_disable = 1
  autocmd FileType gitcommit let b:EditorConfig_disable = 1
augroup END
