UsePlugin 'editorconfig-vim'

let g:EditorConfig_max_line_indicator = "none"
let g:EditorConfig_preserve_formatoptions = 1

augroup EditorConfig
  autocmd!
  autocmd FileType gitconfig b:EditorConfig_disable = 1
  autocmd FileType gitcommit b:EditorConfig_disable = 1
augroup END
