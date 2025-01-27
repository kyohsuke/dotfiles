UsePlugin 'ctrlp.vim'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

let g:ctrlp_show_hidden = 1
let g:ctrlp_regexp = 0
let g:ctrlp_reuse_window =  'netrw'
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_open_new_file = 'h'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_match_current_file = 1
let g:ctrlp_cmd = 'call CtrlPCommand()'

function! g:CtrlPCommand()
  let wincount = winnr('$')
  var curr: number = 0
  " Don't open it here if current buffer is not writable (e.g. NERDTree)
  while !empty(getbufvar(str2nr(expand("<abuf>")), "&buftype")) && curr < wincount
    exec 'wincmd w'
    let curr = curr + 1
  endwhile
  exec 'CtrlP'
endfunction


UsePlugin 'ctrlp-matchfuzzy'
let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
