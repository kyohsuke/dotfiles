" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker

" {{{ MacVim 8 patch 1272 or above
if has('vim_starting') && has('mac')
  let s:rubydll_path = substitute(system('rbenv prefix')."/lib/libruby.dylib", "\n", '', 'g')
  set rubydll&
  exe "set rubydll=".s:rubydll_path

  " PythonX
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
" {{{ vim-plug
call plug#begin('~/.vim/plugged')
  " Color Scheme
  Plug 'mrkn/mrkn256.vim'

  " Syntax Plugins
  Plug 'mechatroner/rainbow_csv'
  Plug 'kchmck/vim-coffee-script'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'othree/yajs.vim'
    Plug 'othree/es.next.syntax.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'lifepillar/pgsql.vim'
  Plug 'direnv/direnv.vim'
  Plug 'tyru/skkdict.vim'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'slim-template/vim-slim'
  Plug 'tpope/vim-haml'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'cespare/vim-toml'
    Plug 'maralla/vim-toml-enhance' 
  Plug 'tpope/vim-markdown'
    Plug 'joker1007/vim-markdown-quote-syntax'
  Plug 'hashivim/vim-terraform'
  Plug 'rafael84/vim-wsd'
  Plug 'jparise/vim-graphql'

  " NerdTree
  Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'

  Plug 'previm/previm'

  Plug 'thinca/vim-quickrun'
  Plug 'kana/vim-smartchr'
  Plug 'yssl/QFEnter'

  Plug 'kyohsuke/sinplu.vim'
  Plug 'kyohsuke/yaml-key.vim'

  Plug 'hotwatermorning/auto-git-diff'

  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'

  " Ruby
  Plug 'thoughtbot/vim-rspec'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-rails'

  " vim-ref
  Plug 'thinca/vim-ref'
    Plug 'yuku-t/vim-ref-ri'
    Plug 'soh335/vim-ref-pman'

  Plug 'LeafCage/foldCC.vim'
  Plug 'Shougo/vimproc.vim', { 'do':  'make' }
  Plug 'ctrlpvim/ctrlp.vim'

  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'
  Plug 'tyru/eskk.vim'
  Plug 'tyru/open-browser.vim'
  Plug 'kyohsuke/vimlc.vim'
call plug#end()
if !isdirectory($HOME.'/.vim/plugged')
  PlugInstall
endif
" }}}
" {{{ Plugins
  " {{{ NerdTree
  augroup NerdTree
    function! s:auCloseWindow()
      if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
        q
      endif
    endfunction

    autocmd!
    autocmd BufEnter * call s:auCloseWindow()

    nnoremap <silent> ,nf :<C-u>NERDTreeFind<Return>
    nnoremap <silent> <C-e> :<C-u>NERDTreeToggle<Return>

    let g:NERDTreeNaturalSort = 1
    let g:NERDTreeHighlightCursorline = 0
    let g:NERDTreeAutoDeleteBuffer = 1
    let g:NERDTreeChDirMode = 2
    let g:NERDTreeStatusline = '  NERDTree  '. nerdtree#version()
  augroup END
  " }}}
  " {{{ FoldCC
  let g:foldCCtext_maxchars = 150
  let g:foldCCtext_tail = 'printf("   %s[%4d lines  Lv%-2d]%s", v:folddashes, v:foldend-v:foldstart+1, v:foldlevel, v:folddashes)'
  set foldtext=FoldCCtext()
  set foldcolumn=3
  set fillchars=vert:\|
  " }}}
  " {{{ eskk
  if has('vim_starting')
    let g:eskk#large_dictionary = {
          \   'path' : '~/.vim/stash/SKK-JISYO.L',
          \   'sorted' : 1,
          \   'encoding' : 'euc-jp'
          \ }
    let g:eskk#dictionary = {
          \	'path': "~/.skk-jisyo",
          \	'sorted': 0,
          \	'encoding': 'utf-8',
          \}
    let g:eskk#egg_like_newline = 1
    let g:eskk#show_annotation = 1
    let g:eskk#fix_extra_okuri = 0
    let g:eskk#enable_completion = 0
  endif
  " }}}
  " {{{ vim-dispatch
  augroup Dispatch
    autocmd!
    nnoremap <silent> <Leader>d :<C-u>Dispatch<Return>
  augroup END
  " }}}
  " {{{ ctrlp
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip 
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_regexp = 0
  let g:ctrlp_reuse_window = 'NERD'
  let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
  let g:ctrlp_working_path_mode = 'r'
  let g:ctrlp_open_new_file = 'h'
  let g:ctrlp_user_command = 'files -a -A -s -i "^(\.git|\.hg|\.svn|_darcs|\.bzr|^node_modules|tmp|\.vagrant|\.keep|\.log|.tmp|\.DS_Store)$" %s'
  let g:ctrlp_match_current_file = 1
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
  " }}}
  " {{{ vim-fugitive
  augroup vim_fugitive
    autocmd!
    autocmd QuickFixCmdPost *grep* cwindow
    nnoremap <expr><Leader>gg ":<C-u>Ggrep " . expand('<cword>') . "<Return>"
  augroup END
  " }}}
  " {{{ QuickRun
  let g:quickrun_config = {
        \   '_': {
        \     'outputter/buffer/close_on_empty': 1,
        \     'runner': 'job',
        \     'split': 'below'
        \   },
        \   'ruby': {
        \     'command': 'ruby',
        \     'cmdopt': '-C '.$PWD.' -r '.$HOME.'/.vim/stash/rubyopts.rb'
        \   },
        \   'ruby.rspec': {
        \     'command': 'rspec',
        \     'cmdopt': '-r '.$HOME.'/.vim/stash/rubyopts.rb -r '.$HOME.'/.vim/stash/vim_rspec_formatter.rb --format QuickfixFormatter',
        \     'exec': "%c %o %s:%{line('.')}",
        \     'outputter': 'quickfix'
        \   },
        \   'ruby.rspec_all': {
        \     'command': 'rspec',
        \     'cmdopt': '-r '.$HOME.'/.vim/stash/rubyopts.rb -r '.$HOME.'/.vim/stash/vim_rspec_formatter.rb --format QuickfixFormatter',
        \     'exec': "%c %o",
        \     'outputter': 'quickfix'
        \   },
        \   'ruby.testunit': {
        \     'exec': "rake test"
        \   },
        \   'cpp': {
        \     'command': 'g++',
        \     'cmdopt': '-std=c++11'
        \   }
        \ }
  " }}}
  " {{{ vim-smartchr
  inoremap <expr> / smartchr#loop('/', '//', '\/')
  augroup SmartChr
    autocmd!
    " Ruby
    autocmd FileType ruby,rails inoremap <buffer> <expr> <bar> smartchr#one_of('<bar>', '<bar><bar>', '<bar><bar>=')
    autocmd FileType ruby,rails inoremap <buffer> <expr> = smartchr#one_of('=', '==', '=>')
    autocmd FileType ruby,rails inoremap <buffer> <expr> { smartchr#loop('{', '#{', '{{')
    " Python
    autocmd FileType python inoremap <buffer> <expr> ? smartchr#loop('?', '\?')
    " Haml/Slim
    autocmd FileType haml inoremap <buffer> <expr> { smartchr#loop('{', '#{', '{{')
    autocmd FileType slim inoremap <buffer> <expr> { smartchr#loop('{', '#{', '{{')
  augroup END
  " }}}
  " {{{ QFEnter
  let g:qfenter_keymap = {}
  let g:qfenter_keymap.vopen = ['<C-v>']
  let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
  let g:qfenter_keymap.topen = ['<C-t>']
  " }}}
  " {{{ SinPlu
  let g:sinplu_no_mappings = 1
  nmap <Leader>w <Plug>ToggleWord
  let g:sinplu_plural_override_wards = [
        \   ['(ind)ex$', '\1exes', 'i']
        \ ]
  " {{{ vim-lsp
  function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> ge <plug>(lsp-document-diagnostics)
    nmap <buffer> <f2> <plug>(lsp-rename)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> <c-o> <plug>(lsp-hover)
    nmap <buffer> K <plug>(lsp-hover)


    inoremap <buffer> <expr> <C-o> lsp#internal#document_hover#under_cursor#do({}) ? '' : ''
    inoremap <buffer> <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
  endfunction

  augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END
  command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

  let g:lsp_diagnostics_enabled = 1
  let g:lsp_diagnostics_echo_cursor = 1
  let g:lsp_text_edit_enabled = 1
  " }}}
  " {{{ asyncomplete
  let g:asyncomplete_auto_popup = 1
  let g:asyncomplete_auto_completeopt = 0
  let g:asyncomplete_popup_delay = 200
  inoremap <expr> <C-y>     pumvisible() ? asyncomplete#cancel_popup() : "\<C-y>"
  inoremap <expr> <TAB>     pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr> <S-Tab>   pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <BS>      pumvisible() ? asyncomplete#close_popup() : "\<BS>"
  inoremap <expr> <c-space> asyncomplete#force_refresh() 
  " }}}
  " {{{ vim-ref
  nnoremap ,rpy :<C-u>Ref<Space>pydoc<Space>
  nnoremap ,rr :<C-u>Ref<Space>ri<Space>
  nnoremap ,rph :<C-u>Ref<Space>pman<Space>
  " }}}
  " {{{ vim-markdown
  let g:vim_markdown_folding_disabled = 1
  let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'sh']
    " {{{ vim-markdown-quote-syntax
    let g:markdown_quote_syntax_filetypes = {}
    let g:markdown_quote_syntax_filetypes.sshconfig = { 'start' : 'sshconfig' }
    " }}}
  " }}}
  " {{{ auto-git-diff
  augroup auto_git_diff
    function! s:setup_auto_git_diff() abort
        nmap <buffer><C-l> <Plug>(auto_git_diff_scroll_manual_update)
        nmap <buffer><C-n> <Plug>(auto_git_diff_scroll_down_half)
        nmap <buffer><C-p> <Plug>(auto_git_diff_scroll_up_half)
    endfunction
    autocmd!
    autocmd FileType gitrebase call <SID>setup_auto_git_diff()
  augroup END
  " }}}
  " {{{ Ruby
  " Indent
  let g:ruby_indent_access_modifier_style = 'normal'
  let g:ruby_indent_block_style = 'do'
  let g:ruby_indent_assignment_style = 'variable'

  " Syntax
  let g:ruby_operators = 1
  let g:ruby_pseudo_operators = 1
  let g:ruby_space_errors = 1
  let g:ruby_no_expensive = 1
  let g:ruby_minlines = 500
  let g:ruby_spellcheck_strings = 1

  augroup VimRuby
    autocmd!
    autocmd FileType ruby setlocal expandtab
    autocmd FileType ruby,eruby nnoremap <silent> <Leader>t :split<Return> <C-]>
  augroup END
  " }}}
  " {{{ vim-go
  nnoremap ,go :<C-u>Godoc<Space>
  let g:go_def_mapping_enabled = 0
  let g:go_gopls_enabled = 0
  if isdirectory(expand(globpath($GOPATH, "src/github.com/nsf/gocode/vim")))
    exe "set runtimepath+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
  endif
  " }}}
" }}}
" {{{ Indivisual Settings
" Encodings 
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,euc-jp,cp932,iso-2022-jp
set fileformats=unix,dos,mac
set langmenu=ja_JP.utf-8
set maxmempattern=10240

" Kill termencoding on MacVim
if !has('gui_macvim')
  set termencoding=utf-8
endif
" {{{ Folding Remap 
nnoremap <expr> h virtcol('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
vnoremap <expr> h virtcol('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
vnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'
" }}}
" Individual Remap 
nnoremap <silent> ,sh :<C-u>:terminal<Return>
nnoremap <silent> ,gvimrc :<C-u>e<Space>~/.gvimrc<Return>
nnoremap <silent> ,vimrc :<C-u>e<Space>~/.vimrc<Return>
nnoremap <silent> ,rt :<C-u>set<Space>ft=ruby<Return>
nnoremap <silent> ,md :<C-u>set<Space>ft=markdown<Return>
nnoremap <silent> ,date "=strftime("%FT%T%z")<CR>P

" key mappings tradition of Vim 
noremap : ;
noremap ; :

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <silent> <Esc><Esc> :<C-u>noh<Return>
nnoremap <C-h> :<C-u>help<Space>
nnoremap <C-f> :<C-u>setf<Space>

" Color Scheme
try
    colorscheme mrkn256
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme koehler
endtry

" Reset Global 
set wildignore&
set statusline&
" 

set ts=2 sts=2 sw=2
set wildmode=list:full
set showmatch
set t_Co=256
set visualbell t_vb=
set colorcolumn=80,128
set clipboard=unnamed
set completeopt=menu,noselect
set number
set relativenumber

" {{{ Vim Technique Bible 1-10
augroup vimrc_technique_bible_1_10
  autocmd!
  autocmd InsertEnter * hi StatusLine guifg=DarkBlue guibg=DarkYellow gui=none ctermfg=Blue ctermbg=Yellow cterm=none
  autocmd InsertLeave * hi StatusLine guifg=DarkBlue guibg=DarkGray gui=none ctermfg=Blue ctermbg=DarkGray cterm=none
augroup END
" }}}


" Kill Indent 
set noautoindent
set nocindent
set nocopyindent
set nopreserveindent
set nosmartindent

set hlsearch
set hid
set expandtab

set autoread

" Kill Match Hilight 
let loaded_matchparen = 1
" 
" Kill Backup 
set nobackup
set noundofile
set noswapfile " Kill Swapfile

" 
set ambiwidth=double
set backspace=indent,eol,start
set laststatus=2
set statusline=%<%f\ %m%r%h%w[%Y]%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%c%V%8P

set noshowcmd
set ignorecase
set smartcase
set noshowmode

source $VIMRUNTIME/macros/matchit.vim

" Kill Auto Commentout
augroup vimrc_kill_auto_commentout
  autocmd!
  autocmd FileType * setlocal formatoptions-=ro
augroup END

augroup vimrc_checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

augroup RubyFold
  autocmd!
  autocmd FileType ruby setlocal foldmethod=marker
augroup END

augroup help_remap
  autocmd!
  autocmd FileType help nnoremap <buffer> <CR> <C-]>
  autocmd FileType help nnoremap <buffer> <BS> <C-O>
augroup END

" virtual edit, vim hacks #195 
set virtualedit=all
if has('virtualedit') && &virtualedit =~# '\<all\>'
  nnoremap <expr> p (col('.') >= col('$') ? '$' : '') . 'p'
endif
" }}}
" {{{ FileTypes
augroup FileTypes
  autocmd!

  " Type Detect
  autocmd BufRead,BufNewFile *.json.tpl                                     setlocal filetype=json
  autocmd BufRead,BufNewFile .vimrc.local                                   setlocal filetype=vim
  autocmd BufRead,BufNewFile COMMIT_EDITMSG                                 setlocal filetype=gitcommit
  autocmd BufRead,BufNewFile {before_config,.ssh_config.local,after_config} setlocal filetype=sshconfig
  autocmd BufRead,BufNewFile {*.md,*.mkd,*.markdown}                        setlocal filetype=markdown
  autocmd BufRead,BufNewFile {*.js,*.jsx,*.es6}                             setlocal filetype=javascript
  autocmd BufRead,BufNewFile {*.ts,*.tsx}                                   setlocal filetype=typescript

  " Rspec / TestUnit
  autocmd BufRead,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
  autocmd BufRead,BufNewFile *_test.rb setlocal filetype=ruby.testunit

  " Capfile
  autocmd BufRead,BufNewFile {Schemafile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*,*.arb} set filetype=ruby

  " Ruby on Rails
  autocmd BufRead,BufNewFile *.slim   setlocal ts=2 sw=2
  autocmd BufRead,BufNewFile *.haml   setlocal ts=2 sw=2
  autocmd BufRead,BufNewFile *.rhtml  setlocal ts=2 sw=2
  autocmd BufRead,BufNewFile *.rb     setlocal ts=2 sw=2
  autocmd BufRead,BufNewFile *.yml    setlocal ts=2 sw=2

  " Set up synclines
  autocmd FileType jsp,asp,php,ruby,xml,perl syntax sync minlines=500 maxlines=1000

  " Golang
  autocmd FileType go setlocal noexpandtab ts=4 sts=4 sw=4

  " YAML
  autocmd FileType yaml setlocal indentexpr=

  " Ruby
  autocmd FileType ruby set omnifunc=

  " Markdown
  autocmd FileType markdown setlocal ts=4 sts=4 sw=4
  autocmd FileType markdown syntax sync fromstart

  " GoHtmlTmpl
  augroup GoHtmlTemplate
    function! s:DetectGoHtmlTmpl()
      if expand('%:e') == "html" && search("{{") != 0
        set filetype=gohtmltmpl 
      endif
    endfunction

    autocmd!
    autocmd BufRead,BufNewFile * call s:DetectGoHtmlTmpl()
  augroup END
augroup END
" }}}
" {{{ Finalize
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
set secure
syntax on
" }}}
