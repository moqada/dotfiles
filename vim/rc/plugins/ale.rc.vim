" eslint_dを使う
let g:ale_javascript_eslint_executable = 'eslint_d'

" statuslineの表現
let g:ale_statusline_format = ['👺%d', '👻%d', 'OK']

" エラー表示フォーマット
let g:ale_echo_msg_format = '[%linter%] %s'

" エラー箇所への移動キーマップ
nmap <silent> <F8> <Plug>(ale_next_wrap)
nmap <silent> <S-F8> <Plug>(ale_prev_wrap)

" lightline.vim用ステータス表示関数
function! ALEStatus()
  return ALEGetStatusLine()
endfunction

