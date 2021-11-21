UsePlugin 'ctrlp.vim'

let g:ctrlp_show_hidden = 1
let g:ctrlp_regexp = 0
let g:ctrlp_reuse_window =  'netrw'
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_open_new_file = 'h'
let g:ctrlp_user_command = 'files -a %s'
let g:ctrlp_match_current_file = 1

set wildignore+=*/tmp/*,*.so,*.swp,*.zip 

function! CtrlPCommand()
  let c = 0
  let wincount = winnr('$')
  " Don't open it here if current buffer is not writable (e.g. NERDTree)
  while !empty(getbufvar(+expand("<abuf>"), "&buftype")) && c < wincount
    exec 'wincmd w'
    let c = c + 1
  endwhile
  exec 'CtrlP'
endfunction
let g:ctrlp_cmd = 'call CtrlPCommand()'
