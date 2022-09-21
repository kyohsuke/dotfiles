" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker

" {{{ Skip Loading Default plugins
if has('gui_macvim')
  let g:macvim_skip_colorscheme=1
endif
let g:no_gvimrc_example = 1
let g:no_vimrc_example  = 1

let g:loaded_gzip               = 1
let g:loaded_tar                = 1
let g:loaded_tarPlugin          = 1
let g:loaded_zip                = 1
let g:loaded_zipPlugin          = 1
let g:loaded_rrhelper           = 1
let g:loaded_vimball            = 1
let g:loaded_vimballPlugin      = 1
let g:loaded_getscript          = 1
let g:loaded_getscriptPlugin    = 1
let g:loaded_netrw              = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_netrwSettings      = 1
let g:loaded_netrwFileHandlers  = 1
let g:skip_loading_mswin        = 1
let g:did_install_syntax_menu   = 1
let g:loaded_2html_plugin       = 1
" }}}
" {{{ Setup PytonX
if has('vim_starting') && has('mac')
  set pythonthreehome&
  set pythonthreedll&
  set pyx&
  set pyxversion&
  set pyx=3
  set pyxversion=3
  let s:pyenv_root_path = system('pyenv prefix')
  let s:pyenv_dll_path = substitute(system("ls \"$(pyenv prefix)/lib/libpython3.\"*m.dylib"), "\n", '', 'g')
  exe 'set pythonthreehome='.s:pyenv_root_path
  exe 'set pythonthreedll='.s:pyenv_dll_path
endif
" }}}
" {{{ Indivisual Settings
  " {{{ Reset Global 
    set wildignore&
    set statusline&
  " }}}
  " {{{ Language & Encodings
  set encoding=utf-8
  set fileencodings=ucs-bom,utf-8,euc-jp,cp932,iso-2022-jp
  set fileformats=unix,dos,mac
  set langmenu=ja_JP.utf-8
  " Kill termencoding on MacVim
  if !has('gui_macvim')
    set termencoding=utf-8
  endif
  " }}}
  " {{{ Keybind ReMap
    nnoremap <silent> ,sh :<C-u>:terminal<Return>
    nnoremap <silent> ,gvimrc :<C-u>e<Space>$MYGVIMRC<Return>
    nnoremap <silent> ,vimrc :<C-u>e<Space>$MYVIMRC<Return>
    nnoremap <silent> ,rt :<C-u>set<Space>ft=ruby<Return>
    nnoremap <silent> ,md :<C-u>set<Space>ft=markdown<Return>

    " {{{ key mappings tradition of Vim 
    noremap : ;
    noremap ; :

    nnoremap <silent> <D-[> :<C-u>bprev<Return>
    nnoremap <silent> <D-]> :<C-u>bnexxt<Return>

    nnoremap j gj
    nnoremap k gk
    nnoremap gj j
    nnoremap gk k

    nnoremap <silent> <Esc><Esc> :<C-u>noh<Return>
    nnoremap <C-h> :<C-u>help<Space>
    nnoremap <C-f> :<C-u>setf<Space>
    " }}}
    " {{{ Folding Remap 
    nnoremap <expr> h virtcol('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
    nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
    vnoremap <expr> h virtcol('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
    vnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'
    " }}}
    " {{{ Commandline Remap
    cnoremap <C-h> <Left>
    cnoremap <C-l> <Right>
    " }}}
  " }}}
  " {{{ Mode Color StatusLine ( Vim Technique Bible 1-10 )
  augroup VimrcTechniqueBible_1_10
    autocmd!
    autocmd InsertEnter * hi StatusLine guifg=DarkBlue guibg=DarkYellow gui=none ctermfg=Blue ctermbg=Yellow cterm=none
    autocmd InsertLeave * hi StatusLine guifg=DarkBlue guibg=DarkGray gui=none ctermfg=Blue ctermbg=DarkGray cterm=none
  augroup END
  " }}}
  " {{{ Kill Indent 
  set noautoindent
  set nocindent
  set nocopyindent
  set nopreserveindent
  set nosmartindent
  " }}}
  " {{{ Kill Backup 
  set nobackup
  set noundofile
  set noswapfile " Kill Swapfile
  " }}}
  " {{{ Paste withmut space on virtual edit ( vim hacks #195 )
  set virtualedit=all
  if has('virtualedit') && &virtualedit =~# '\<all\>'
    nnoremap <expr> p (col('.') >= col('$') ? '$' : '') . 'p'
  endif
  " }}}

  set ts=2 sts=2 sw=2
  set wildmode=list:full
  set showmatch
  set t_Co=256
  set visualbell t_vb=
  set colorcolumn=80,128
  set clipboard+=unnamed
  set completeopt=menu,noselect
  set number relativenumber
  set maxmempattern=10240

  set hlsearch
  set hid
  set expandtab
  set autoread

  set ambiwidth=double
  set backspace=indent,eol,start
  set laststatus=2
  set statusline=%<%f\ %m%r%h%w[%Y]%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%c%V%8P

  set noshowcmd
  set ignorecase
  set smartcase
  set noshowmode
  set foldlevel=99

  autocmd WinEnter * checktime
  " {{{ Kill Auto Commentout
  augroup VimrcKillAutoCommentOut
    autocmd!
    autocmd FileType * setlocal formatoptions-=ro
  augroup END
  " }}}
" }}}
" {{{ Detect FileTypes
augroup DetectFileTypes
  autocmd!

  " Type Detect
  autocmd BufRead,BufNewFile *.json.tpl                                     setf json
  autocmd BufRead,BufNewFile {before_config,.ssh_config.local,after_config} setf sshconfig
  autocmd BufRead,BufNewFile .env.*                                         setf sh.env
  autocmd BufRead,BufNewFile .babelrc                                       setf json
  " autocmd BufRead,BufNewFile {*.js,*.jsx,*.es6}                           setf javascript
  " autocmd BufRead,BufNewFile *.ts                                         setf typescript
  " autocmd BufRead,BufNewFile {*.ts,*.tsx}                                 setf typescript

  " Set up synclines
  autocmd FileType jsp,asp,php,ruby,xml,perl,markdown syntax sync minlines=500 maxlines=1000

  " YAML
  autocmd FileType yaml setlocal indentexpr=

  " gitconfig
  autocmd FileType gitconfig setlocal noexpandtab ts=4 sts=4 sw=4

  " Markdown
  autocmd FileType markdown setlocal ts=2 sts=2 sw=2
  autocmd FileType markdown syntax sync fromstart

  " golang
  autocmd FileType go setlocal foldmethod=syntax

  " Remap vim help
  autocmd FileType help nnoremap <buffer> <CR> <C-]>
  autocmd FileType help nnoremap <buffer> <BS> <C-O>
augroup END
" }}}
" {{{ vim-plug
call plug#begin('~/.vim/plugged')
  " Japanese Help
  Plug 'vim-jp/vimdoc-ja'

  " Color Scheme
  Plug 'mrkn/mrkn256.vim'

  " Syntax Plugins
  Plug 'direnv/direnv.vim'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'hashivim/vim-terraform'
  Plug 'jparise/vim-graphql'
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'mechatroner/rainbow_csv'
  Plug 'autowitch/hive.vim'
  Plug 'google/vim-jsonnet'

  " Markdown
  Plug 'tpope/vim-markdown'

  " PostgreSQL
  Plug 'lifepillar/pgsql.vim'

  " TOML
  Plug 'cespare/vim-toml'
    Plug 'maralla/vim-toml-enhance' 

  " JavaScript
  Plug 'othree/yajs.vim'
    Plug 'othree/es.next.syntax.vim'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'maxmellon/vim-jsx-pretty'

  " html5
  Plug 'othree/html5.vim'

  " golang
  Plug 'mattn/vim-goimports'
  Plug 'kyohsuke/vim-go-syntax'

  " ruby
  Plug 'vim-ruby/vim-ruby'

  " NerdTree
  Plug 'scrooloose/nerdtree'

  Plug 'previm/previm'

  Plug 'thinca/vim-quickrun'
  Plug 'kana/vim-smartchr'
  Plug 'yssl/QFEnter'

  Plug 'kyohsuke/sinplu.vim'
  Plug 'kyohsuke/yaml-key.vim'

  Plug 'itspriddle/vim-shellcheck' 

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'hotwatermorning/auto-git-diff'

  " CtrlP
  Plug 'ctrlpvim/ctrlp.vim'
    Plug 'mattn/ctrlp-matchfuzzy'

  " Vim-LSP & AsynComplete
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'mattn/ctrlp-lsp'

  Plug 'LeafCage/foldCC.vim'

  Plug 'vim-skk/eskk.vim'
  Plug 'tyru/open-browser.vim'
  Plug 'kyohsuke/vimlc.vim'
  Plug 'chrisbra/matchit'

  Plug 'markonm/traces.vim'

  Plug 'tyru/current-func-info.vim'

  
  " Devicons
  Plug 'ryanoasis/vim-devicons'
    Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

if !isdirectory($HOME.'/.vim/plugged')
  PlugInstall
endif

let s:plugs = get(s:, 'plugs', get(g:, 'plugs', {}))
function! FindPlugin(name) abort
  return has_key(s:plugs, a:name) ? isdirectory(s:plugs[a:name].dir) : 0
endfunction
command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

runtime! config/*.vim
" }}}

set secure
syntax on
