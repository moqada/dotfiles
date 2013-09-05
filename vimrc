" vim:fdm=marker
" 未分類の設定"{{{
syntax on
" 編集中でのバッファ切り替えを可能にする、タブモードの為に必要っぽい
set hidden
" コマンドモードの補完をするときに強化されたものを使うか否か(使わない)
set nowildmenu
" Vimがテキストを整形する方法を決定するオプションのリスト
" @see http://vimwiki.net/?'formatoptions'
set formatoptions=qltcmM
" 補完モードの指定
set wildmode=list:longest
"}}}

" initialize "{{{
set nocompatible
filetype off     " required!
filetype plugin indent off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/bundle'))
"}}}

" neobundle.vim"{{{
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vimproc'
NeoBundle 'thinca/vim-ref'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'taglist.vim'
NeoBundle 'sudo.vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'tyru/skk.vim'
NeoBundle 'mojako/ref-sources.vim'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'edsono/vim-viewoutput'
NeoBundle 'mattn/excitetranslate-vim'
NeoBundle 'surround.vim'
NeoBundle 'visSum.vim'
NeoBundle 'yuratomo/w3m.vim'
NeoBundle 'honza/vim-snippets'
" for git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mattn/gist-vim'
" for javascript
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'nono/jquery.vim'
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'digitaltoad/vim-jade'
" for python
NeoBundle 'django.vim'
NeoBundle 'VST'
NeoBundle 'indentpython.vim--nianyang'
NeoBundle 'klen/python-mode'
NeoBundle 'davidhalter/jedi-vim'
" for ReST
NeoBundle 'rest.vim'
NeoBundle 'Rykka/riv.vim'
" for markdown
NeoBundle 'tpope/vim-markdown'
NeoBundle 'jtratner/vim-flavored-markdown'
" for color
NeoBundle 'altercation/vim-colors-solarized'
" for coffeescript
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'nathanaelkane/vim-indent-guides'
" for less
NeoBundle 'groenewege/vim-less'
" for css
NeoBundle 'hail2u/vim-css3-syntax'
" for php
NeoBundle 'phpfolding.vim'
NeoBundle 'shawncplus/php.vim'
" for tweetvim
NeoBundle 'basyura/TweetVim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'basyura/bitly.vim'
NeoBundle 'yomi322/neco-tweetvim'
" for vimscript
NeoBundle 'mattn/learn-vimscript'
NeoBundle 'vim-jp/vimdoc-ja'
" for autoit
NeoBundle 'moqada/autoit.vim--Breland'
NeoBundle 'moqada/neco-autoit'
" for yii
NeoBundle 'mikehaertl/yii-api-vim'
" }}}

filetype plugin indent on
filetype on

" 検索に関する設定"{{{
" 検索時に大文字小文字を無視するか否か
set ignorecase
" 特殊な検索ロジックの設定
" @see http://vimwiki.net/?'smartcase'
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻るか否か
set wrapscan
" 検索文字列をハイライトするか否か(omited:"hls")
set hlsearch
" grepに外部コマンドを利用する
set grepprg=grep\ -nH
"}}}

" 編集に関する設定"{{{
" タブの画面上での幅
set tabstop=4
set softtabstop=4
set shiftwidth=4
" タブをスペースに展開するか否か
set expandtab
" 自動的にインデントするか否か
set autoindent
" バックスペースでインデントや改行を削除できるようにする
" @see http://vimwiki.net/?'backspace'
set backspace=indent,eol,start
"" 対応する括弧を強調表示する
set showmatch
"" 対応する括弧の強調表示時間を設定する
set matchtime=2
"}}}

" 画面表示の設定"{{{
" 256色対応
set t_Co=256
" colorscheme
colorscheme solarized
" 行番号
set number
" ルーラー
set ruler
" タブや改行を表示するか否か
set list
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
set listchars=tab:>-
" 長い行を折り返して表示するか否か
set wrap
" 常にステータスラインを表示
set laststatus=2
" コマンドモード入力部分の縦幅
set cmdheight=1
" コマンドをステータス行に表示するか否か
set showcmd
" タイトルバーに情報を表示するか否か
set notitle
" 縦にラインを引く
set colorcolumn=80
hi ColorColumn guibg=#666666
"}}}

" バックアップ・スワップに関する設定"{{{
" スワップファイルの保存先
set directory=~/.tmp,~/tmp,/tmp,/var/tmp
" バックアップファイルの保存先
set backupdir=~/.vim/backup,~/.tmp,~/tmp,/tmp
" バックアップファイルを作成するか否か
set backup
" 一時的なバックアップファイルを作成するか否か
set writebackup
" - 検索履歴の行数
set viminfo+=/50
" - マークの行数
set viminfo+='50
" コマンド履歴の保存数
" - viminfoとの兼ね合いは良くわからない
set history=500
"}}}

" マウス操作に関する設定 "{{{
" マウスの移動でフォーカスを自動的に切替えるか否か
set nomousefocus
" 入力時にマウスポインタを隠すか否か
set mousehide
" ビジュアル選択を自動的にシステムのクリップボードに入れる
"set guioptions+=a
" }}}

" 色に関する設定 "{{{
" 被検索対象文字列
"highlight Search ctermbg=Yellow ctermfg=Black
" タブと行末半角スペースと半角スペース
"highlight TabSpace ctermbg=DarkBlue
"match TabSpace /\t\|\s\+$/
" }}}

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
" 文字コードの自動認識
" @see http://www.kawaz.jp/pukiwiki/?vim#content_1_7
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = s:fileencodings_default .','. &fileencodings
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" }}}

" key mappnig {{{
" --------------------------
" バッファ切り替え
nnoremap <C-N> :bn!<CR>
nnoremap <C-P> :bp!<CR>
" 5回移動する
"nnoremap <C-J> 5j
"nnoremap <C-K> 5k
"nnoremap <C-H> 5h
"nnoremap <C-L> 5l
" カーソル上下の前方一致補完にする
cnoremap <C-P> <UP>
cnoremap <C-N> <DOWN>
" ウィンドウサイズ変更
"nnoremap ,w1 :set columns=80<CR>
"nnoremap ,w2 :set columns=115<CR>
"nnoremap ,w3 :set columns=150<CR>
" ヴィジュアルモードで選択した範囲を検索する
" @see: http://vim-users.jp/2009/11/hack104/
"vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>
" 指定コマンド後にquickfixを表示させる
autocmd QuickFixCmdPost CoffeeLint if len(getqflist()) != 0 | copen | endif
"}}}

" 短縮入力"{{{
" for EC-CUBE
iab scq new SC_Query();
iab md new SC_DB_MasterData_Ex();
iab plog GC_Utils_Ex::gfPrintLog();
iab dlog GC_Utils_Ex::gfDebugLog();
"}}}

" FileType Settings "{{{
" ----------
" for CoffeeScript
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable shiftwidth=2 filetype=coffee
" for JavaScript
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
" for Vim Script
" 行継続のための \ のインデント量を元のインデントと同じにする
let g:vim_indent_cont = 0
" for Markdown
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END
" ----------
"}}}

"---------------------------
" plugin
"--------------------------
" vim-airline "{{{
let g:airline_powerline_fonts=1
let g:airline_theme = 'solarized'
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_linecolumn_prefix = '␊ '
let g:airline_linecolumn_prefix = '␤ '
let g:airline_linecolumn_prefix = '¶ '
let g:airline#extensions#branch#symbol = '⭠'
let g:airline#extensions#readonly#symbol = '⭤'
let g:airline#extensions#paste#symbol = 'ρ'
let g:airline#extensions#paste#symbol = 'Þ'
let g:airline#extensions#paste#symbol = '∥'
let g:airline#extensions#whitespace#symbol = 'Ξ'
let g:airline_linecolumn_prefix = '⭡'
" }}}

" vim-colors-solarized "{{{
syntax enable
set background=dark
" }}}

" gist-vim "{{{
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1
let g:github_user = 'moqada'
" }}}

" taglist.vim "{{{
set tags=tags
let Tlist_Use_Right_Window=1  " 右側に表示
let Tlist_Auto_Highlight_Tag=1  " なんかわからん
let Tlist_Exit_OnlyWindow=1  " taglist以外のウィンドウがなくなったら自動的にウィンドウを閉じる
let Tlist_Show_One_File = 1 " 現在編集中のソースのタグのみ表示
map ,tl :TlistToggle<CR> 
" for php
let g:tlist_php_settings = 'php;c:class;d:constant;f:function;v:variable'
" }}}

" zen-coding.vim "{{{
" ファイルタイプ毎の設定.
let g:user_zen_settings = {
\    'indentation': '   ',
\    'html': {
\        'indentation': '  ',
\        'inline_elements': 'a,abbr,acronym,applet,b,basefont,bdo,big,br,button,cite,code,del,dfn,em,font,i,iframe,img,input,ins,kbd,label,map,object,q,s,samp,script,small,span,strike,strong,sub,sup,textarea,tt,u,var,li',
\    },
\}
" }}}

" python-mode "{{{
" lint を実行する
let g:pymode_lint = 1
let g:pymode_lint_onfly = 1
let g:pymode_lint_write = 1
let g:pymode_lint_cwindow = 0
let g:pymode_lint_message = 1
let g:pymode_lint_signs = 1
let g:pymode_lint_select = ''
let g:pymode_lint_onfly_= 1
let g:pymode_lint_checker = 'pep8,pyflakes,mccabe'
" rope を無効にする
" neocomplcacheのS-Tab補完がRopeCodeAssistと被るため
let g:pymode_rope = 0
" python-mode のインデント設定
let g:pymode_indent = 1
" python-mode の設定を利用しない
let g:pymode_options = 0
" python-mode の折りたたみを利用する
let g:pymode_folding = 1
" }}}

" indent_guides "{{{
" @see: http://qiita.com/items/fb442cfa78f91634cfaa
" インデントの深さに色を付ける
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_color_change_percent=20
let g:indent_guides_guide_size=1
let g:indent_guides_space_guides=1

hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=237
au FileType coffee,ruby,javascript,python IndentGuidesEnable
nmap <silent><Leader>ig <Plug>IndentGuidesToggle
" }}}

" jscomplete-vim "{{{
" DOM / Mozilla関連 / ES6 のメソッドを補完
let g:jscomplete_use = ['dom', 'moz', 'es6th']
" }}}"

" syntastic "{{{
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': ['javascript', 'php'],
            \ 'passive_filetypes': ['python'] }
" }}}"

" tweetvim "{{{
" @see http://d.hatena.ne.jp/basyura/20111230/p1
" 発言用バッファを表示する
nnoremap <silent> s :TweetVimSay<CR>
" @see http://qiita.com/items/a28eb714151886358b1a
" 1ページあたりのツイート数
let g:tweetvim_tweet_per_page = 60
" アイコンを表示する
let g:tweetvim_display_icon = 1
" }}}

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

" gundo.vim "{{{
nnoremap U :GundoToggle<CR>
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
" 入力モードで開始
let g:unite_enable_start_insert=1

" The prefix key.
nnoremap    [unite]   <Nop>
xnoremap    [unite]   <Nop>
nmap     ;u [unite]
xmap     ;u  [unite]

nnoremap <silent> [unite]u  :<C-u>Unite -buffer-name=files buffer file_mru bookmark file file/new<CR>
nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file file/new<CR>
nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir -buffer-name=files -prompt=%\  buffer file_mru bookmark file file/new<CR>
nnoremap <silent> [unite]r  :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
nnoremap  [unite]f  :<C-u>Unite source<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
    " Overwrite settings.

    nmap <buffer> <ESC>      <Plug>(unite_exit)
    imap <buffer> jj      <Plug>(unite_insert_leave)
    "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

    " <C-l>: manual neocomplcache completion.
    inoremap <buffer> <C-l>  <C-x><C-u><C-p><Down>

    " Start insert.
    "let g:unite_enable_start_insert = 1
endfunction"}}}

let g:unite_source_file_mru_limit = 200
let g:unite_cursor_line_highlight = 'TabLineSel'
let g:unite_abbr_highlight = 'TabLine'

" For optimize.
let g:unite_source_file_mru_filename_format = ''

" For unite-session.
" Save session automatically.
"let g:unite_source_session_enable_auto_save = 1
" Load session automatically.
"autocmd VimEnter * UniteSessionLoad
" }}}

" unite de diff "{{{
" @see http://daisuzu.hatenablog.com/entry/2012/08/22/231557
let diff_action = {
    \   'description': 'diff',
    \   'is_selectable': 1,
    \ }

function! diff_action.func(candidates)
    if len(a:candidates) == 1
        " カレントバッファとdiffをとる
        execute 'vert diffsplit ' . a:candidates[0].action__path
    elseif len(a:candidates) == 2
        " 選択されたファイルとdiffをとる
        execute 'tabnew ' . a:candidates[0].action__path
        execute 'vert diffsplit ' . a:candidates[1].action__path
    else
        " 3-way以上は非対応
        echo 'too many candidates!'
    endif
endfunction

call unite#custom_action('file', 'diff', diff_action)
unlet diff_action
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
let g:neosnippet#snippets_directory = $HOME . '/.vim/snippets'
\   . ',' . $HOME .  '/.vim/bundle/vim-snippets/snippets'
" snipMate互換にする
let g:neosnippet#enable_snipmate_compatibility = 1
" snippets変数
let g:snips_author = 'Masahiko OKADA'
" keymapping
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)
" }}}"

" neocomplcache.vim"{{{
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 0
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 0
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 0
" Set minimum syntax keyword length. (デフォルト値は4)
let g:neocomplcache_min_syntax_length = 3
" Set auto completion length.
let g:neocomplcache_auto_completion_start_length = 2
" Set manual completion length.
let g:neocomplcache_manual_completion_start_length = 4
" Set minimum keyword length.
let g:neocomplcache_min_keyword_length = 3
" wildcardを許可しない
let g:neocomplcache_enable_wildcard = 0
" cursor hold?
let g:neocomplcache_enable_cursor_hold_i = 0
let g:neocomplcache_cursor_hold_i_time = 300

" For auto select.
let g:neocomplcache_enable_auto_select = 0
" 自動補完しない
let g:neocomplcache_disable_auto_complete = 0


let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_disable_auto_select_buffer_name_pattern = '\[Command Line\]'
let g:neocomplcache_max_list = 10
let g:neocomplcache_force_overwrite_completefunc = 1

" 一旦無効
" let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" 関数補完の際の区切り文字パターン
if !exists('g:neocomplcache_delimiter_patterns')
    let g:neocomplcache_delimiter_patterns = {}
endif
let g:neocomplcache_delimiter_patterns['php'] = ['->', '::', '\']

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
     \ 'default' : '',
     \ 'php' : $HOME.'/.vim/dict/php.dict',
     \ 'vimshell' : $HOME.'/.vimshell_hist',
     \ 'scheme' : $HOME.'/.gosh_completions'
     \ }

let g:neocomplcache_omni_functions = {
     \ 'python' : 'pythoncomplete#Complete',
     \ 'ruby' : 'rubycomplete#Complete',
     \ }

" Define keyword pattern
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.mail = '^\s*\w\+'

if !exists('g:neocomplcache_same_filetype_lists')
  let g:neocomplcache_same_filetype_lists = {}
endif
"let g:neocomplcache_same_filetype_lists.perl = 'ref'

" let g:neocomplcache_source_look_dictionary_path = $HOME . '/words'
let g:neocomplcache_source_look_dictionary_path = ''

let g:neocomplcache_vim_completefuncs = {
      \ 'Ref' : 'ref#complete',
      \ 'Unite' : 'unite#complete_source',
      \ 'VimShellExecute' : 'vimshell#complete#vimshell_execute_complete#completefunc',
      \ 'VimShellInteractive' : 'vimshell#complete#vimshell_execute_complete#completefunc',
      \ 'VimShellTerminal' : 'vimshell#complete#vimshell_execute_complete#completefunc',
      \ 'VimShell' : 'vimshell#complete',
      \ 'VimFiler' : 'vimfiler#complete',
      \}
if !exists('g:neocomplcache_plugin_completion_length')
  let g:neocomplcache_plugin_completion_length = {
      \ 'look' : 4,
      \ }
endif

" Plugin key-mappings."{{{
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
"}}}

" Recommended key-mappings."{{{
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
" vim-smartinputの<BS>と競合するため一旦無効化
" inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" <C-n>でマニュアル補完を開始する
inoremap <expr><C-n>  neocomplcache#start_manual_complete()
"}}}
