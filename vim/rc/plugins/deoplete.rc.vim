" smartcaseを有効にする
let g:deoplete#enable_smart_case = 1
" 大文字小文字を考慮しない
let g:deoplete#enable_ignore_case = 0
" vim-smartinputと競合するため無効化
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
" inoremap <expr><BS>  deoplete#mappings#smart_close_popup()."\<C-h>"

" bufferの表示順を一番前に
call deoplete#custom#set("buffer", "rank", 9999)

" Omni補完自動表示
let g:deoplete#omni#input_patterns = {}
" for JavaScirpt
" see: https://github.com/Shougo/neocomplete.vim/issues/91
let g:deoplete#omni#input_patterns.javascript = '[^. \t]\.\w*'
