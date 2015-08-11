scriptencoding utf8
" このファイルではマーカー文字列でソースコードを折り畳み表示
" vim: foldmethod=marker

" neobundle.vim "{{{
" 初期化
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle'))

" Plug in
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
     \ 'build': {
     \     'windows': 'mingw32-make -f make_mingw32.mak',
     \     'cygwin': 'make -f make_cygwin.mak',
     \     'mac': 'make -f make_mac.mak',
     \     'unix': 'make -f make_unix.mak',
     \    },
     \ }
NeoBundle 'Shougo/unite.vim'
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
NeoBundle 'rking/ag.vim'
NeoBundle 'tyru/eskk.vim'
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
NeoBundle 'editorconfig/editorconfig-vim'

" for CoffeeScript
NeoBundleLazy 'kchmck/vim-coffee-script', {
     \ 'autoload': {'filetypes': ['coffee']}
     \ }

" for Git
NeoBundle 'tpope/vim-fugitive'

" for GitHub
NeoBundleLazy 'mattn/gist-vim', {
     \ 'autoload': {'commands': ['Gist']},
     \ 'depends': 'mattn/webapi-vim'
     \ }

" for Golang
NeoBundleLazy 'dgryski/vim-godef', {
      \ 'autoload': {'filetypes': ['go']}
      \ }
NeoBundleLazy 'vim-jp/vim-go-extra', {
      \ 'autoload': {'filetypes': ['go']}
      \ }

" for HTML / CSS
NeoBundleLazy 'mattn/emmet-vim', {
     \ 'autoload': {'filetypes': ['css', 'html', 'sass', 'scss', 'jsx']}
     \ }
NeoBundleLazy 'hail2u/vim-css3-syntax', {
     \ 'autoload': {'filetypes': ['css']}
     \ }
NeoBundleLazy 'cakebaker/scss-syntax.vim', {
     \ 'autoload': {'filetypes': ['scss']}
     \ }
NeoBundle 'wavded/vim-stylus'

" for JavaScript
NeoBundleLazy 'jiangmiao/simple-javascript-indenter', {
     \ 'autoload': {'filetypes': ['javascript']}
     \ }
NeoBundle 'nono/jquery.vim'
NeoBundleLazy 'digitaltoad/vim-jade', {
     \ 'autoload': {'filetypes': ['jade']}
     \ }
NeoBundleLazy 'pangloss/vim-javascript', {
     \ 'autoload': {'filetypes': ['javascript']},
     \ 'depends': ['mxw/vim-jsx', 'jelera/vim-javascript-syntax']
     \ }
NeoBundleLazy '1995eaton/vim-better-javascript-completion', {
     \ 'autoload': {'filetypes': ['javascript']}
     \ }
NeoBundleLazy 'heavenshell/vim-jsdoc', {
      \ 'autoload': {'filetypes': ['javascript']}
      \ }

" for Markdown
NeoBundleLazy 'rcmdnk/vim-markdown', {
     \ 'autoload': {'filetypes': ['markdown']}
     \ }
NeoBundleLazy 'kannokanno/previm', {
     \ 'autoload': {'filetypes': ['markdown']},
     \ 'depends': 'tyru/open-browser.vim'
     \ }
NeoBundleLazy "joker1007/vim-markdown-quote-syntax", {
     \ 'autoload': {'filetypes': ['markdown']}
     \ }

" for Python
NeoBundle 'django.vim'
NeoBundleLazy 'davidhalter/jedi-vim', {
     \ 'autoload': {'filetypes': ['python', 'python3']}
     \ }
NeoBundleLazy 'hynek/vim-python-pep8-indent', {
     \ 'autoload': {'insert': 1, 'filetypes': ['python', 'python3']}
     \ }
NeoBundleLazy 'alfredodeza/pytest.vim', {
     \ 'autoload': {'filetypes': ['python', 'python3']}
     \ }
NeoBundleLazy 'jmcantrell/vim-virtualenv', {
     \ 'autoload': {'filetypes': ['python', 'python3']}
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
NeoBundleLazy 'syngan/vim-vimlint', {
     \ 'autoload': {'filetypes': ['vim']},
     \ 'depends' : 'ynkdir/vim-vimlparser'
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
" スペルチェックで日本語を除外する
set spelllang=en,cjk
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
" 記号を ASCII 文字の2倍の幅にする
set ambiwidth=double
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

" キーマッピング "{{{
" 一つ前のバッファに戻る
nnoremap <C-b> :bp<CR>
" スペルチェック機能 ON / OFF をトグルする
nnoremap <silent><Space>s :<C-u>setl spell! spell?<CR>
" vimrc を再読み込み
nnoremap <Space>rv :<C-u>source ~/.vimrc<CR>
" vimrc を編集
nnoremap <silent><Space>ev :<C-u>edit ~/.vimrc<CR>
" }}}

" FileType Settings "{{{
" ----------
" for JavaScript
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
" for Markdown
" そのままだと *.md なファイルは modula2 と判断されてしまう
au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setl ft=markdown
" for Golang
au FileType go au BufWritePre <buffer> Fmt
" for Git commit message
au FileType gitcommit setl spell

" ----------
"}}}

"---------------------------
" プラグイン設定
"--------------------------

" ag.vim "{{{
" カーソル下の文字列を ag を使って検索する
nmap & :Ag <C-r>=expand("<cword>")<cr><cr>
" ag を使って指定の文字列で検索する
nnoremap <space>/ :Ag 
" }}}

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

" vim-jsx "{{{
" .js 拡張子でも jsx を有効にする
let g:jsx_ext_required = 0
" }}}"

" vim-better-javascript-completion "{{{
" Chrome API の補完を有効にする
let g:vimjs#chromeapis = 0
" }}}"

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

" vim-javascript-syntax "{{{
" Folding を有効にする
au FileType javascript call JavaScriptFold()
" }}}

" jedi-vim "{{{
" Omni 補完に jedi を使用する (neocomplete で利用する)
au FileType python,python3 setlocal omnifunc=jedi#completions
" jedi の補完を無効にする
let g:jedi#completions_enabled = 0
" 補完表示を jedi-vim のデフォルト設定にしない
let g:jedi#auto_vim_configuration = 0
" for performace?
let g:jedi#show_call_signatures = 0
" }}}

" jsdoc-vim "{{{
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_allow_shorthand = 1
nmap <silent> <C-l> <Plug>(jsdoc)
" }}}"

" pytest.vim "{{{
" pytestを実行キーマップ設定
nmap <silent><leader>F <Esc>:Pytest file<CR>
nmap <silent><leader>f <Esc>:Pytest function<CR>
nmap <silent><leader>c <Esc>:Pytest class<CR>
nmap <silent><leader>m <Esc>:Pytest method<CR>
" }}}"

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
" check に該当する項目があってもそのまま全ての checker を実行する
let g:syntastic_aggregate_errors = 1
" 各言語の checker 設定
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['flake8', 'pep257']
let g:syntastic_python_flake8_args = '--max-line-length=120'
let g:syntastic_python_pep257_args = '--ignore=D100,D302,D400'
let g:syntastic_coffee_coffeelint_args = '--file ' . $HOME . '/.coffeelint.json'
let g:syntastic_go_checkers = ["go", "golint"]
" 自動実行設定
" vimlint は遅いので自動実行しない
let g:syntastic_mode_map = { "mode": "active",
      \ "active_filetypes": [],
      \ "passive_filetypes": ["vim"] }
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

" eskk.vim "{{{
" 有効/無効切り替え
map! <C-j><C-e> <Plug>(eskk:enable)
map! <C-j><C-d> <Plug>(eskk:disable)
" 辞書ファイルの指定
if exists('g:eskk#directory')
  unlet g:eskk#dictionary
endif
if exists('g:eskk#large_dictionary')
  unlet g:eskk#large_dictionary
endif
let g:eskk#dictionary = expand('~/.skk-jisyo')
let g:eskk#large_dictionary = expand('~/.skk/SKK-JISYO.L')
" 変換確定時のenterで改行しない
let g:eskk#egg_like_newline = 1
" 変換候補確定のenterで改行しない
let g:eskk#egg_like_newline_completion = 1
" insertモードを抜けて、再度insertモードに入ったときに前の状態を維持する
let g:eskk#keep_state = 1
" 変換候補にアノテーションを表示する
let g:eskk#show_annotation = 1
" モードマークを指定
let g:eskk#marker_henkan = '<>'
let g:eskk#marker_henkan_select = '>>'
" }}}

" unite.vim "{{{
"------------------------------
" The prefix key.
nnoremap    [unite]   <Nop>
nmap     ;u [unite]

nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir
      \ -buffer-name=files buffer bookmark file file/new<CR>
nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir
      \ -buffer-name=files buffer bookmark file file/new<CR>
nnoremap <silent> [unite]r  :<C-u>Unite
      \ -buffer-name=register register<CR>
nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
nnoremap <silent> [unite]f
      \ :<C-u>Unite -buffer-name=resume resume<CR>
nnoremap <silent> [unite]ma
      \ :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]me
      \ :<C-u>Unite output:message<CR>
nnoremap  [unite]f  :<C-u>Unite source<CR>
nnoremap <silent> [unite]u
      \ :<C-u>Unite -buffer-name=files
      \ jump_point file_point buffer
      \ file_rec/async file file_mru file/new<CR>

" 入力モードで開始
call unite#custom#profile('default', 'context', {
\   'short_source_names': 1,
\   'start_insert': 1
\ })

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.

  imap <buffer> jj      <Plug>(unite_insert_leave)
  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

  imap <buffer><expr> j unite#smart_map('j', '')
  "imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  imap <buffer><expr> x
          \ unite#smart_map('x', "\<Plug>(unite_quick_match_jump)")
  nmap <buffer> x     <Plug>(unite_quick_match_jump)
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

" fuzzy match を利用する最大文字数
let g:unite_matcher_fuzzy_max_input_length = 3

" Grep "{{{
if executable('ag')
  " Use ag in unite grep source.
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
elseif executable('jvgrep')
  " For jvgrep.
  let g:unite_source_grep_command = 'jvgrep'
  let g:unite_source_grep_default_opts = '-i --exclude ''\.(git|svn|hg|bzr)'''
  let g:unite_source_grep_recursive_opt = '-R'
endif
" }}}"

" ag を利用したファイル選択など "{{{
" @see: http://mattn.kaoriya.net/software/vim/20150209151638.htm
let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
catch
endtry
" search a file in the filetree
nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)
" }}}"

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
" see: http://rcmdnk.github.io/blog/2015/01/12/computer-vim/
" 一旦 neosnippet-snipetts を無効にする
let g:neosnippet#disable_runtime_snippets = {
\   '_' : 1,
\ }
" snipMate互換にする
let g:neosnippet#enable_snipmate_compatibility = 1
" スニペットの指定
" 同じ定義があった場合は最初に指定した方が優先されるため独自スニペットの方を先頭にする
let g:neosnippet#snippets_directory = []
let g:neosnippet#snippets_directory += ['~/.vim/snippets']
let g:neosnippet#snippets_directory += ['~/.vim/bundle/serverspec-snippets']
let g:neosnippet#snippets_directory += ['~/.vim/bundle/neosnippet-snippets/neosnippets']
let g:neosnippet#snippets_directory += ['~/.vim/bundle/vim-snippets/snippets']
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
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

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

let g:previm_open_cmd = 'open -a Firefox'
