vim9script
UsePlugin 'vim-ruby'

# Indent
g:ruby_indent_access_modifier_style = 'normal'
g:ruby_indent_block_style = 'do'
g:ruby_indent_assignment_style = 'variable'

# Syntax
g:ruby_operators = 1
g:ruby_pseudo_operators = 1
g:ruby_space_errors = 1
g:ruby_no_expensive = 1
g:ruby_minlines = 500
g:ruby_spellcheck_strings = 1

augroup VimRuby
  autocmd! * <buffer>

  # Ruby
  autocmd FileType ruby setlocal formatoptions-=ro expandtab foldmethod=marker omnifunc=
  autocmd FileType ruby,eruby nnoremap <buffer> <silent> <Leader>t :split<Return> <C-]>

  # Rspec / TestUnit
  autocmd BufRead,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
  autocmd BufRead,BufNewFile *_test.rb setlocal filetype=ruby.testunit
  autocmd BufRead,BufNewFile {Schemafile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*,*.arb} setlocal filetype=ruby
augroup END
