if exists('b:did_ftplugin_javascript_syntastic')
  finish
endif
let b:did_ftplugin_javascript_syntastic = 1

" ローカルのeslintを参照するようにする
" see: https://github.com/mtscout6/syntastic-local-eslint.vim
" let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
" let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

" ローカルのflowを参照するようにする
" 現状うまく動作しないし、server 経由でチェックしてくれないので遅い
" let s:flow_path = system('PATH=$(npm bin):$PATH && which flow')
" let b:syntastic_javascript_flow_exec = substitute(s:flow_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" let b:syntastic_javascript_flow_exe = substitute(s:flow_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '') . ' status'
