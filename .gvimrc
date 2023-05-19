vim9script
# MacVim Setting
if has('gui_running')
  if has('win32')
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
  endif


  set imdisable # Kill IME

  set antialias
  set guioptions& # Win: egmrLtT / MacVim-Kaoriya : egimrL / Other : aegimrLtT
  set guioptions=egimrL
  set guioptions-=mrLtT
  set guioptions+=c

  set lines=60
  set columns=200

  # MacVim
  if has('gui_macvim')
    # Cursorline
    set cursorline
    highlight clear CursorLine
    highlight CursorLine gui=underline guibg=black ctermbg=black

    augroup cch
      autocmd!
      autocmd WinLeave * set nocursorline
      autocmd WinEnter,BufRead * set cursorline

      autocmd InsertEnter * set nocursorline
      autocmd InsertLeave * set cursorline
    augroup END

    set transparency=15
    set guifont=Cica-Regular:h14,Osaka-Mono:h14
    set guifontwide=Cica-Regular:h14,Osaka-Mono:h14

    if has('transparency') || exists('+transparency')
      augroup hack234
        autocmd!
        autocmd FocusGained * set transparency=10 cursorline
        autocmd FocusLost * set transparency=50 nocursorline
      augroup END
    endif
  endif
endif
