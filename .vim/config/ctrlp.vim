vim9script
UsePlugin 'ctrlp.vim'

g:ctrlp_show_hidden = 1
g:ctrlp_regexp = 0
g:ctrlp_reuse_window =  'netrw'
g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
g:ctrlp_working_path_mode = 'r'
g:ctrlp_open_new_file = 'h'
g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
g:ctrlp_match_current_file = 1

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

def g:CtrlPCommand()
  const wincount: number = winnr('$')
  var curr: number = 0
  # Don't open it here if current buffer is not writable (e.g. NERDTree)
  while !empty(getbufvar(str2nr(expand("<abuf>")), "&buftype")) && curr < wincount
    exec 'wincmd w'
    curr = curr + 1
  endwhile
  exec 'CtrlP'
enddef
g:ctrlp_cmd = 'call CtrlPCommand()'

UsePlugin 'ctrlp-matchfuzzy'
g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
