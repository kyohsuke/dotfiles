UsePlugin 'nerdtree'

let g:NERDTreeNaturalSort = 1
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeStatusline = '  NERDTree  '. nerdtree#version()
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeMinimalMenu = 1

nnoremap <silent> ,nf :<C-u>NERDTreeFind<Return>
nnoremap <silent> <C-e> :<C-u>NERDTreeToggle<Return>

augroup NerdTree
  autocmd! * <buffer>

  function! s:auCloseWindow()
    if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
      q
    endif
  endfunction

  autocmd BufEnter * call s:auCloseWindow()
augroup END
