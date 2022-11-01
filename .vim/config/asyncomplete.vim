UsePlugin 'asyncomplete.vim'

" let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200

inoremap <expr> <C-y>     pumvisible() ? asyncomplete#cancel_popup() : "\<C-y>"
inoremap <expr> <TAB>     pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-Tab>   pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <bs>      pumvisible() ? asyncomplete#close_popup()."\<BS>" : "\<BS>"
inoremap <expr> <c-space> asyncomplete#force_refresh()
