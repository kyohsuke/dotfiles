UsePlugin 'vim-quickrun'

nmap <Leader>r <Plug>(quickrun)

let g:quickrun_config = {
      \   '_': {
      \     'outputter/buffer/close_on_empty': 1,
      \     'outputter/buffer/opener': 'rightbelow split',
      \     'runner': 'job',
      \   },
      \     'go/bench': {
      \     'command': 'go',
      \     'tempfile': '%{printf("%s_test.go", tempname())}',
      \     'exec': ['%C test -bench . -benchmem'],
      \     'type': 'go',
      \     'runner': 'terminal',
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
