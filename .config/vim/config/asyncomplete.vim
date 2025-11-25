UsePlugin 'asyncomplete.vim'

let g:asyncomplete_popup_delay = 200

inoremap <expr> <C-y>     pumvisible() ? asyncomplete#cancel_popup() : "\<C-y>"
inoremap <expr> <TAB>     pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-Tab>   pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <bs>      pumvisible() ? asyncomplete#close_popup() .. "\<BS>" : "\<BS>"
inoremap <expr> <c-space> asyncomplete#force_refresh()

function! s:sort_by_kind_preprocessor(options, matches) abort
  let l:items = []
  for [l:source_name, l:matches] in items(a:matches)
    for l:item in l:matches['items']
      if stridx(l:item['word'], a:options['base']) == 0
        call add(l:items, l:item)
      endif
    endfor
  endfor

  let l:items = sort(l:items, {a, b -> b['kind'] - a['kind']})

  call asyncomplete#preprocess_complete(a:options, l:items)
endfunction

let g:asyncomplete_preprocessor = [function('s:sort_by_kind_preprocessor')]
