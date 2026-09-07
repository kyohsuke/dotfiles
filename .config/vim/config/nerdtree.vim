UsePlugin 'nerdtree'

let g:NERDTreeNaturalSort = 1
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeStatusline = '  NERDTree  ' .. nerdtree#version()
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeMinimalMenu = 1

nnoremap <silent> ,nf :<C-u>NERDTreeFind<Return>
nnoremap <silent> <C-e> :<C-u>NERDTreeToggle<Return>

if !empty($XDG_DATA_HOME)
  if !isdirectory($XDG_DATA_HOME .. "/nerdtree")
    call mkdir($XDG_DATA_HOME .. "/nerdtree", "p")
  endif

  let g:NERDTreeBookmarksFile = $XDG_DATA_HOME .. "/nerdtree/bookmarks"
endif

augroup NerdTree
  function! s:AuCloseWindow()
  " Close the tab if NERDTree is the only window remaining in it.
    if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
      call feedkeys(":quit\<CR>:\<BS>")
    endif
  endfunction

  autocmd!
  autocmd BufEnter * call <SID>AuCloseWindow()
augroup END
