setl tabstop=4
setl softtabstop=4
setl shiftwidth=4
setl smarttab
setl expandtab
setl autoindent
setl cindent
"" 一旦smartindentは切った方がいいらしい
setl nosmartindent
" 自動改行の幅
setl textwidth=80

" folding
setl foldmethod=indent
setl foldlevel=99

" jedi-vim
" @see: http://d.hatena.ne.jp/heavenshell/20121025/1351179999
if g:jedi#popup_on_dot
  inoremap <buffer> . .<C-R>=jedi#do_popup_on_dot() ? "\<lt>C-X>\<lt>C-O>\<lt>C-P>" : ""<CR>
end
