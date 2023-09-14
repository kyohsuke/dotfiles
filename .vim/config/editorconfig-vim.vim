vim9script
UsePlugin 'editorconfig-vim'

augroup EditorConfig
  autocmd! * <buffer>
  autocmd FileType gitconfig b:EditorConfig_disable = 1
  autocmd FileType gitcommit b:EditorConfig_disable = 1
augroup END
