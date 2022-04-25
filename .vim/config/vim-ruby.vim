UsePlugin 'vim-ruby'

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

  " Ruby
  autocmd FileType ruby setlocal formatoptions-=ro expandtab foldmethod=marker omnifunc=
  autocmd FileType ruby,eruby nnoremap <silent> <Leader>t :split<Return> <C-]>

  " Rspec / TestUnit
  autocmd BufRead,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
  autocmd BufRead,BufNewFile *_test.rb setlocal filetype=ruby.testunit

  autocmd BufRead,BufNewFile {Schemafile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*,*.arb} set filetype=ruby

  autocmd BufRead,BufNewFile *.haml   setlocal ts=2 sw=2
  autocmd BufRead,BufNewFile *.rhtml  setlocal ts=2 sw=2
  autocmd BufRead,BufNewFile *.rb     setlocal ts=2 sw=2
  autocmd BufRead,BufNewFile *.yml    setlocal ts=2 sw=2
augroup END
