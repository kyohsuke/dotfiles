UsePlugin 'vim-quickrun'

nnoremap <Leader>r <Plug>(quickrun)
nnoremap <expr><Leader>t ":<C-u>QuickRun " .. expand(&ft) .. "/test" .. "<Return>"

let g:quickrun_config = {
      \   '_': {
      \     'outputter/buffer/close_on_empty': 1,
      \     'outputter/buffer/opener': 'rightbelow split',
      \     'runner': 'job',
      \   },
      \   'go/test': {
      \     'exec': 'go test ./...',
      \   },
      \   'ruby': {
      \     'command': 'ruby',
      \     'cmdopt': '-C ' .. $PWD .. ' -r ' .. $XDG_CONFIG_HOME .. '/vim/stash/rubyopts.rb',
      \   },
      \   'ruby/rspec': {
      \     'command': 'rspec',
      \     'cmdopt': '-r ' .. $XDG_CONFIG_HOME .. '/vim/stash/rubyopts.rb -r ' .. $XDG_CONFIG_HOME .. '/vim/stash/vim_rspec_formatter.rb --format QuickfixFormatter',
      \     'exec': "%c %o %s:%{line('.')}",
      \     'outputter': 'quickfix',
      \   },
      \   'ruby/rspec_all': {
      \     'command': 'rspec',
      \     'cmdopt': '-r ' .. $HOME .. '/.vim/stash/rubyopts.rb -r ' .. $HOME .. '/.vim/stash/vim_rspec_formatter.rb --format QuickfixFormatter',
      \     'exec': "%c %o",
      \     'outputter': 'quickfix',
      \   },
      \   'ruby/test': {
      \     'exec': 'rake test',
      \   },
      \   'cpp': {
      \     'command': 'g++',
      \     'cmdopt': '-std=c++11',
      \   }
      \ }
