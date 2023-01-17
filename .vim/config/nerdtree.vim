vim9script
UsePlugin 'nerdtree'

g:NERDTreeNaturalSort = 1
g:NERDTreeHighlightCursorline = 0
g:NERDTreeAutoDeleteBuffer = 1
g:NERDTreeChDirMode = 2
g:NERDTreeStatusline = '  NERDTree  ' .. nerdtree#version()
g:NERDTreeLimitedSyntax = 1
g:NERDTreeMinimalMenu = 1

nnoremap <silent> ,nf :<C-u>NERDTreeFind<Return>
nnoremap <silent> <C-e> :<C-u>NERDTreeToggle<Return>

augroup NerdTree
  autocmd! * <buffer>

  def AuCloseWindow()
    if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
      q
    endif
  enddef
  defc

  autocmd BufEnter * AuCloseWindow()
augroup END
