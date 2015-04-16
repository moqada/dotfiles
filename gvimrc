" visual " {{{
" gui
set guioptions=get
" コマンドラインの高さ
set cmdheight=1
" 全角スペースの表示
hi ZenkakuSpace gui=bold guibg=darkcyan
colorscheme jellybeans
set background=dark
" }}}

" ビジュアルベルの無効化
set visualbell t_vb=

" Device設定 " {{{
" macvimのときは無視される
if has('gui_mac')
    set langmenu=ja_jp.utf-8
    set antialias
    set termencoding=japan
    set guifont=DejaVu\ Sans\ Mono:h12
    set guifontwide=ヒラギノ角ゴ\ ProN\ W3:h12
    set transparency=10
endif
" macvim設定
if has('gui_macvim')
    set antialias
    set transparency=25
    set showtabline=1
    set guifont=Sauce\ Code\ Powerline:h12
    set guifontwide=Ricty\ Discord\ Regular\ for\ Powerline:h12
endif
" for kaoriya
if has('kaoriya')
    " IMEONの時のカーソル色変更
    hi CursorIM  guifg=black  guibg=red  gui=NONE  ctermfg=black  ctermbg=white  cterm=reverse
    set iminsert=0 imsearch=0
endif
" for Windows
if has('win32')
  set langmenu=ja_jp.utf-8
  set guifont=Ricty\ Discord\ for\ Powerline:h10
  set guifontwide=Ricty\ Discord\ for\ Powerline:h10

  " http://d.hatena.ne.jp/orangehat/20080503
  " 選択部分をクリップボードにコピー
  vmap <C-C> "*y
  " 挿入モード時、クリップボードから貼り付け
  imap <C-V> <ESC>"*pa
  " 選択部分をクリップボードの値に置き換え
  vmap <C-V> d"*P
  " コマンドライン時、クリップボードから貼り付け
  cmap <C-V> <C-R>*
  " 選択部分をクリップボードに切り取り
  vmap <C-X> "*d<ESC>
endif
" }}}
