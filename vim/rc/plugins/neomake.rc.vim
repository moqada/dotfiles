autocmd! BufWritePost,BufEnter * Neomake

let g:neomake_javascript_enabled_makers = ['eslint_d']
let g:neomake_jsx_enabled_makers = ['eslint_d']

let g:neomake_error_sign = {'text': '>>', 'texthl': 'Error'}
let g:neomake_warning_sign = {'text': '>>',  'texthl': 'Todo'}
