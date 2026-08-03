UsePlugin 'copilot.vim'

let g:copilot_no_tab_map = v:true
let g:copilot_filetypes = {
      \ 'markdown': v:false,
      \ 'text': v:false,
      \ }

inoremap <silent><script><expr> <C-L> copilot#Accept("\<CR>")
inoremap <silent> <C-0> <Plug>(copilot-next)
inoremap <silent> <C-9> <Plug>(copilot-previous)
