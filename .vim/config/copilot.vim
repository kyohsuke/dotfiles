UsePlugin 'copilot.vim'

let g:copilot_no_tab_map = v:true

inoremap <silent><script><expr> <C-L> copilot#Accept("\<CR>")
inoremap <C-0> <Plug>(copilot-next)
inoremap <C-9> <Plug>(copilot-previous)
