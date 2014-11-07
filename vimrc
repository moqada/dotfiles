" このファイルではマーカー文字列でソースコードを折り畳み表示
" vim: foldmethod=marker

" neobundle.vim "{{{
" 初期化
set nocompatible
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle'))
endif

" Plug in
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
     \ 'build': {
     \     'windows': 'mingw32-make -f make_mingw32.mak',
     \     'cygwin': 'make -f make_cygwin.mak',
     \     'mac': 'make -f make_mac.mak',
     \     'unix': 'make -f make_unix.mak',
     \    },
     \ }
NeoBundleLazy 'Shougo/unite.vim', {
     \ 'autoload': {'commands': ['Unite', 'UniteWithBufferDir', 'UniteWithCurrentDir']}
     \ }
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'thinca/vim-ref'
NeoBundle 'itchyny/lightline.vim'
NeoBundleLazy 'majutsushi/tagbar', {
     \ 'autoload': {'commands': ['TagbarToggle']}
     \ }
NeoBundleLazy 'sudo.vim', {
     \ 'autoload': {'commands': ['SudoRead', 'SudoWrite']}
     \ }
NeoBundle 'tyru/skk.vim'
NeoBundle 'mojako/ref-sources.vim'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'mattn/excitetranslate-vim'
NeoBundle 'surround.vim'
NeoBundle 'yuratomo/w3m.vim'
NeoBundle 'honza/vim-snippets'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'nanotech/jellybeans.vim'

" for CoffeeScript
NeoBundleLazy 'kchmck/vim-coffee-script', {
     \ 'autoload': {'filetypes': ['coffee']}
     \ }

" for Git
NeoBundle 'tpope/vim-fugitive'

" for GitHub
NeoBundleLazy 'mattn/gist-vim', {
     \ 'autoload': {'commands': ['Gist']}
     \ }

" for HTML / CSS
NeoBundleLazy 'mattn/emmet-vim', {
     \ 'autoload': {'filetypes': ['css', 'html', 'sass', 'scss']}
     \ }
NeoBundleLazy 'hail2u/vim-css3-syntax', {
     \ 'autoload': {'filetypes': ['css']}
     \ }
NeoBundleLazy 'cakebaker/scss-syntax.vim', {
     \ 'autoload': {'filetypes': ['scss']}
     \ }

" for JavaScript
NeoBundleLazy 'jelera/vim-javascript-syntax', {
     \ 'autoload': {'filetypes': ['javascript']}
     \ }
NeoBundleLazy 'jiangmiao/simple-javascript-indenter', {
     \ 'autoload': {'filetypes': ['javascript']}
     \ }
NeoBundle 'nono/jquery.vim'
NeoBundleLazy 'digitaltoad/vim-jade', {
     \ 'autoload': {'filetypes': ['jade']}
     \ }

" for Markdown
NeoBundleLazy 'rcmdnk/vim-markdown', {
     \ 'autoload': {'filetypes': ['markdown']}
     \ }

" for Python
NeoBundle 'django.vim'
NeoBundleLazy 'indentpython.vim--nianyang', {
     \ 'autoload': {'filetypes': ['python']}
     \ }
NeoBundleLazy 'davidhalter/jedi-vim', {
     \ 'autoload': {'filetypes': ['python']}
     \ }
NeoBundleLazy 'hynek/vim-python-pep8-indent', {
     \ 'autoload': {'filetypes': ['python']}
     \ }
NeoBundleLazy 'alfredodeza/pytest.vim', {
     \ 'autoload': {'filetypes': ['python']}
     \ }

" for ReST
NeoBundleLazy 'Rykka/riv.vim', {
     \ 'autoload': {'filetypes': ['rest']}
     \ }
NeoBundleLazy 'Rykka/clickable.vim', {
     \ 'autoload': {'filetypes': ['rest']}
     \ }

" for Serverspec
NeoBundleLazy 'glidenote/serverspec-snippets', {
     \ 'autoload': {'filetypes': ['ruby']}
     \ }

" for Vim Script
NeoBundleLazy 'mattn/learn-vimscript', {
     \ 'autoload': {'filetypes': ['vim']}
     \ }
NeoBundleLazy 'vim-jp/vimdoc-ja', {
     \ 'autoload': {'filetypes': ['vim']}
     \ }

" 後始末
call neobundle#end()
filetype plugin indent on
" }}}

"---------------------------
" 基本設定
"--------------------------

" 検索に関する設定 "{{{
" 検索時に大文字小文字を無視する
set ignorecase
" 特殊な検索ロジックの設定
" @see http://vimwiki.net/?'smartcase'
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻って再び検索する
set wrapscan
" 検索文字列をハイライトする(omited:"hls")
set hlsearch
"}}}

" 編集に関する設定"{{{
" タブの画面上での幅
set tabstop=4
" cindentやautoindent時に挿入されるタブの幅
set shiftwidth=4
" Tabキー使用時にTabでは無くホワイトスペースを入れたい時に使用する
" この値が0以外の時はtabstopの設定が無効になる
set softtabstop=0
" タブをスペースに展開する
set expandtab
" 自動的にインデントする
set autoindent
" バックスペースでインデントや改行を削除できるようにする
" @see http://vimwiki.net/?'backspace'
set backspace=indent,eol,start
" paste/nopasteをtoggleするキーマップ
set pastetoggle=;p
" 補完候補表示、候補1つでも表示、候補文字列の最長の共通部分だけを挿入
set completeopt=menu,menuone
" クリップボードを使う
set clipboard=unnamed
"}}}

" 画面表示の設定"{{{
" シンタックスハイライトを有効にする
syntax on
" 256色対応
set t_Co=256
" colorscheme
colorscheme jellybeans
" 行番号を表示
set number
" ルーラーを表示
set ruler
" タブや改行を表示する
set list
" どの文字でタブや改行を表示するかを設定
set listchars=tab:>-
" 長い行を折り返して表示する
set wrap
" 常にステータスラインを表示
set laststatus=2
" コマンドモード入力部分の縦幅
set cmdheight=1
" コマンドをステータス行に表示する
set showcmd
" タイトルバーに情報を表示する
set title
" 縦にラインを引く
set colorcolumn=80
hi ColorColumn guibg=#666666
"" 対応する括弧を強調表示する
set showmatch
"" 対応する括弧の強調表示時間を設定する
set matchtime=2
"}}}

" バックアップ・スワップ・履歴に関する設定"{{{
" バックアップファイルを作成しない
set nobackup
" スワップファイルを作成する
set swapfile
" スワップファイルの保存先
set directory=~/.tmp,~/tmp,/var/tmp,/tmp
" 一時的なバックアップファイルを作成する
" ファイルの上書きの前にバックアップを作成
set writebackup
" コマンド履歴の保存数
set history=500
"}}}

" 文字コード/改行コード "{{{
" vim-refのwindowsでの文字化け対策
" http://www.karakaram.com/20120726-vim-ref
if has("win32")
  " set encoding より上に書くこと
  let &termencoding = &encoding
endif
set encoding=utf-8
set fileencodings=ucs_bom,utf-8,ucs-2le,ucs-2,cp932
set fileformats=unix,dos,mac
" }}}

" FileType Settings "{{{
" ----------
" for JavaScript
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
" for Markdown
" そのままだと *.md なファイルは modula2 と判断されてしまう
au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setl ft=markdown
" ----------
"}}}

"---------------------------
" プラグイン設定
"--------------------------

" vim-anzu "{{{
" 通常のn/Nと置き換えてコマンドラインに結果を表示する
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" }}}

" lightline.vim "{{{
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['fugitive', 'gitgutter', 'filename'],
      \   ],
      \   'right': [
      \     ['lineinfo', 'syntastic'],
      \     ['percent'],
      \     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
      \   ]
      \ },
      \ 'component': {
      \   'lineinfo': '⭡ %3l:%-2v',
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'syntastic': 'SyntasticStatuslineFlag',
      \   'charcode': 'MyCharCode',
      \   'gitgutter': 'MyGitGutter',
      \ },
      \ 'separator': {'left': '⮀', 'right': '⮂'},
      \ 'subseparator': {'left': '⮁', 'right': '⮃'}
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\' && &ro ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:t') ? expand('%:.') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return &ft == 'unite' ? 'Unite':
        \ winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
function! MyCharCode()
  if winwidth('.') <= 70
    return ''
  endif

  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction
" }}}

" gist-vim "{{{
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1
let g:github_user = 'moqada'
" }}}

" tagbar.vim "{{{
" window 幅設定
let g:tagbar_width = 30
" shortcut key 設定
map ,tl :TagbarToggle<CR> 
" }}}

" emmet-vim "{{{
" ファイルタイプ毎の設定.
let g:user_emmet_settings = {
\    'indentation': '   ',
\    'html': {
\        'indentation': '  ',
\        'inline_elements': 'a,abbr,acronym,applet,b,basefont,bdo,big,br,button,cite,code,del,dfn,em,font,i,iframe,img,input,ins,kbd,label,map,object,q,s,samp,script,small,span,strike,strong,sub,sup,textarea,tt,u,var,li',
\    },
\}
" }}}

" jedi-vim "{{{
" Omni 補完に jedi を使用する (neocomplete で利用する)
au FileType python setlocal omnifunc=jedi#completions
" jedi の補完を無効にする
let g:jedi#completions_enabled = 0
" 補完表示を jedi-vim のデフォルト設定にしない
let g:jedi#auto_vim_configuration = 0
" }}}

" indent_guides "{{{
" @see: http://qiita.com/items/fb442cfa78f91634cfaa
" インデントの深さに色を付ける
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=1
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_color_change_percent=20
let g:indent_guides_guide_size=1
let g:indent_guides_space_guides=1

hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=237
au FileType coffee,ruby,javascript,python IndentGuidesEnable
nmap <silent><Leader>ig <Plug>IndentGuidesToggle
" }}}

" syntastic "{{{
" ファイルオープン時に syntax check を実行しない
let g:syntastic_check_on_open = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--max-line-length=120'
" }}}"

" ref.vim"{{{
let g:ref_use_vimproc = 1
let g:ref_source_webdict_sites = {
\   'alc': {
\       'url': 'http://eow.alc.co.jp/%s/UTF-8/',
\       'keyword_encoding': 'utf-8',
\       'cache': 1,
\   }
\}
" phpドキュメントのパス
" ファイルは事前にダウンロードしておく
" http://www.php.net/download-docs.php
let g:ref_phpmanual_path = $HOME . '/.phpdoc/php-chunked-xhtml'
" }}}

" skk.vim "{{{
" 有効/無効切り替え
map! <C-j><C-e> <Plug>(skk-enable-im)
map! <C-j><C-d> <Plug>(skk-disable-im)
let g:skk_jisyo = expand('~/.skk-jisyo')
let g:skk_large_jisyo = expand('~/SKK-JISYO.L')
let g:skk_auto_save_jisyo = 1
let g:skk_sticky_key = ";"
" 変換確定時のenterで改行しない
let g:skk_egg_like_newline = 1
" insertモードを抜けて、再度insertモードに入ったときに前の状態を維持する
let g:skk_keep_state = 1
" 変換時の三角を綺麗に表示
set ambiwidth=double
" モードマークを指定
let g:skk_marker_white = '<>'
let g:skk_marker_black = '>>'
" }}}

" unite.vim "{{{
"------------------------------
" The prefix key.
nnoremap    [unite]   <Nop>
xnoremap    [unite]   <Nop>
nmap     ;u [unite]
xmap     ;u  [unite]

nnoremap <silent> [unite]u
      \ :<C-u>Unite
      \ -buffer-name=files buffer file_mru bookmark file file/new<CR>
nnoremap <silent> [unite]c
      \ :<C-u>UniteWithCurrentDir
      \ -buffer-name=files buffer file_mru bookmark file file/new<CR>
nnoremap <silent> [unite]b
      \ :<C-u>UniteWithBufferDir
      \ -buffer-name=files -prompt=%\  buffer file_mru bookmark file file/new<CR>
nnoremap <silent> [unite]r  :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
nnoremap <silent> [unite]f
      \ :<C-u>Unite -buffer-name=resume resume<CR>
nnoremap <silent> [unite]ma
      \ :<C-u>Unite mapping<CR>
nnoremap  [unite]f  :<C-u>Unite source<CR>
nnoremap <silent> [unite]s
      \ :<C-u>Unite -buffer-name=files -no-split
      \ jump_point file_point buffer_tab
      \ file_rec:! file file/new<CR>

" 入力モードで開始
let g:unite_enable_start_insert = 1
" ソース名を短縮表示する
let g:unite_enable_short_source_names = 1

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.

  nmap <buffer> <ESC>      <Plug>(unite_exit)
  imap <buffer> jj      <Plug>(unite_insert_leave)
  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

  imap <buffer><expr> j unite#smart_map('j', '')
  "imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  imap <buffer><expr> x
          \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
  nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
  nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
  nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
  nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
  nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  nnoremap <silent><buffer><expr> l
          \ unite#smart_map('l', unite#do_action('default'))

  let unite = unite#get_current_unite()
  if unite.profile_name ==# 'search'
    nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
  nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
          \ empty(unite#mappings#get_current_filters()) ?
          \ ['sorter_reverse'] : [])

  " Runs "split" action by <C-s>.
  imap <silent><buffer><expr> <C-s>     unite#do_action('split')
endfunction"}}}

let g:unite_cursor_line_highlight = 'TabLineSel'
let g:unite_abbr_highlight = 'TabLine'

if executable('jvgrep')
  " For jvgrep.
  let g:unite_source_grep_command = 'jvgrep'
  let g:unite_source_grep_default_opts = '--exclude ''\.(git|svn|hg|bzr)'''
  let g:unite_source_grep_recursive_opt = '-R'
endif

" For ack.
if executable('ack-grep')
  " let g:unite_source_grep_command = 'ack-grep'
  " let g:unite_source_grep_default_opts = '--no-heading --no-color -k -H'
  " let g:unite_source_grep_recursive_opt = ''
endif
" }}}

" vimfiler {{{
" vimデフォルトのエクスプロラーをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
" セーフモード無効にした状態で起動
let g:vimfiler_safe_mode_by_default = 0
"<Leader>e で現在開いているバッファのディレクトリを開く
nnoremap <silent> <Leader>e :<C-u>VimFilerBufferDir<CR>
" }}}

" neosnippet "{{{
let g:neosnippet#snippets_directory = $HOME . '/.vim/bundle/vim-snippets/snippets'
\   . ',' . $HOME .  '/.vim/bundle/serverspec-snippets'
\   . ',' . $HOME .  '/.vim/snippets'
" snipMate互換にする
let g:neosnippet#enable_snipmate_compatibility = 1
" snippets変数
let g:snips_author = 'Masahiko OKADA'
" keymapping
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" }}}"

" neocomplete.vim "{{{
" AutoComplPop を無効にする
let g:acp_enableAtStartup = 0
" 起動時に neocomplete を有効にする
let g:neocomplete#enable_at_startup = 1
" smartcase を有効にする
let g:neocomplete#enable_smart_case = 1
" 大文字小文字を考慮しない
let g:neocomplete#enable_ignore_case = 0

let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define keyword
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Omni 補完
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
" for jedi-vim
let g:neocomplete#force_omni_input_patterns.python =
\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" My key-mappings "{{{
" <C-n>でマニュアル補完を開始する
inoremap <expr><C-n>  neocomplete#start_manual_complete()
" }}}"

" key-mappings "{{{
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" }}}"

" Recommended key-mappings "{{{
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" vim-smartinputの<BS>と競合するため一旦無効化
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" }}}"
" }}}"

"---------------------------
" ローカル設定
"--------------------------

" 環境に依存した非公開設定を読み込む "{{{
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
" }}}
