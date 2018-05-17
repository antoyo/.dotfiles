nunmap <Leader>gu

" Move by screen line instead of file line (only when not giving a <count>
" parameter in front of the binding: this is useful with relativenumber).
nnoremap <expr> t v:count == 0 ? 'gj' : 'j'
nnoremap <expr> s v:count == 0 ? 'gk' : 'k'
