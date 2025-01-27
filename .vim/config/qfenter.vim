UsePlugin 'QFEnter'

let g:qfenter_keymap = {
      \ 'vopen': ['<C-v>'],
      \ 'hopen': ['<C-CR>', '<C-s>', '<C-x>'],
      \ 'topen': ['<C-t>'],
      \ }
let g:qfenter_exclude_filetypes = [
      \ 'nerdtree',
      \ 'tagbar'
      \ ]
