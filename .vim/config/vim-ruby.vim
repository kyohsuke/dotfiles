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
  autocmd BufRead,BufNewFile {Schemafile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*,*.arb} setlocal filetype=ruby
  autocmd BufRead,BufNewFile *_spec.rb nnoremap <buffer> <expr><Leader>t ":<C-u>QuickRun " .. expand(&ft) .. "/rspec" .. "<Return>"
augroup END
