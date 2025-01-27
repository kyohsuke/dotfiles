UsePlugin 'sinplu.vim'

let g:sinplu_no_mappings = 1
let g:sinplu_plural_override_wards = [
      \ ['(ind)ex$', '\1exes', 'i'],
      \ ]

nmap <Leader>w <Plug>ToggleWord
