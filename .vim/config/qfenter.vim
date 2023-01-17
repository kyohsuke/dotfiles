vim9script
UsePlugin 'QFEnter'

g:qfenter_keymap = {
  vopen: ['<C-v>'],
  hopen: ['<C-CR>', '<C-s>', '<C-x>'],
  topen: ['<C-t>'],
}
g:qfenter_exclude_filetypes = [
  'nerdtree',
  'tagbar',
]
