if exists('b:did_ftplugin_javascript_option')
  finish
endif
let b:did_ftplugin_javascript_option = 1

setl softtabstop=2
setl shiftwidth=2

" For pretitter
let g:neoformat_javascript_prettiereslint = {
      \ 'exe': './node_modules/.bin/prettier-eslint',
      \ 'args': ['--stdin', '-l silent'],
      \ 'stdin': 1,
      \ }
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END
let g:neoformat_enabled_javascript = ['prettiereslint']
