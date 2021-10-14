" MacVim Setting
if has('gui')
  if has('win32')
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
  endif

  " Cursorline 
  if has('gui_macvim')
    set cursorline
    augroup cch
      autocmd!
      autocmd WinLeave * set nocursorline
      autocmd WinEnter,BufRead * set cursorline
    augroup END

    highlight clear CursorLine
    highlight CursorLine gui=underline
    highlight CursorLine guibg=black ctermbg=black
  endif

  " Kill IME
  set imdisable

  set antialias
  set guioptions& " Win: egmrLtT / MacVim-Kaoriya : egimrL / Other : aegimrLtT
  set guioptions=egimrL
  set guioptions-=mrLtT
  set guioptions+=c

  set lines=60
  set columns=200

  if has('mac')
    set transparency=15
    set guifont=OsakaNerdFont-Regular-Mono:h14,Osaka-Mono:h14

    augroup hack234
      autocmd!
      autocmd FocusGained * set transparency=10
      autocmd FocusLost * set transparency=50
    augroup END
  endif
endif
