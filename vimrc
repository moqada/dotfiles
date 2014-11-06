" このファイルではマーカー文字列でソースコードを折り畳み表示
" vim: foldmethod=marker

" neobundle.vim "{{{
" 初期化
set nocompatible
filetype off     " required!
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle'))
endif

" Plug in
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimproc'
NeoBundle 'thinca/vim-ref'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'sudo.vim'
NeoBundle 'tyru/skk.vim'
NeoBundle 'mojako/ref-sources.vim'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'mattn/excitetranslate-vim'
NeoBundle 'surround.vim'
NeoBundle 'yuratomo/w3m.vim'
NeoBundle 'honza/vim-snippets'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'h1mesuke/vim-alignta'
" for git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mattn/gist-vim'
NeoBundle 'kana/vim-fakeclip'
" for javascript
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'nono/jquery.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'digitaltoad/vim-jade'
" for python
NeoBundle 'django.vim'
NeoBundle 'VST'
NeoBundle 'indentpython.vim--nianyang'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'alfredodeza/pytest.vim'
" for ReST
NeoBundle 'rest.vim'
NeoBundle 'Rykka/riv.vim'
NeoBundle 'Rykka/clickable.vim'
" for markdown
NeoBundle 'rcmdnk/vim-markdown'
" for color
NeoBundle 'nanotech/jellybeans.vim'
" for coffeescript
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'nathanaelkane/vim-indent-guides'
" for css
NeoBundle 'hail2u/vim-css3-syntax'
" for sass
NeoBundle 'cakebaker/scss-syntax.vim'
" for vimscript
NeoBundle 'mattn/learn-vimscript'
NeoBundle 'vim-jp/vimdoc-ja'
" for Serverspec
NeoBundle 'glidenote/serverspec-snippets'

call neobundle#end()

" 後始末
filetype plugin indent on
" }}}

"---------------------------
" 基本設定
"--------------------------

" 検索に関する設定 "{{{
" 検索時に大文字小文字を無視するか否か
set ignorecase
" 特殊な検索ロジックの設定
" @see http://vimwiki.net/?'smartcase'
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻るか否か
set wrapscan
" 検索文字列をハイライトするか否か(omited:"hls")
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
" タブをスペースに展開するか否か
set expandtab
" 自動的にインデントするか否か
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
" 長い行を折り返して表示するか否か
set wrap
" 常にステータスラインを表示
set laststatus=2
" コマンドモード入力部分の縦幅
set cmdheight=1
" コマンドをステータス行に表示するか否か
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
" バックアップファイルを作成する
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
" for CoffeeScript
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable shiftwidth=2 softtabstop=2 tabstop=2 filetype=coffee
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

" vim-colors-solarized "{{{
syntax enable
set background=dark
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
" period の入力時自動的に補完を開始しない
let g:jedi#popup_on_dot = 0
" 補完表示を jedi-vim のデフォルト設定にしない
" デフォルト設定は menuone,longest,preview で preview が表示されてつらい
let g:jedi#auto_vim_configuration = 0
" 補完時に最初の項目を選択させない
let g:jedi#popup_select_first = 0
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
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': ['javascript', 'php']
            \ }
let g:syntastic_check_on_open=1
let g:syntastic_python_checkers=['flake8']
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
"}}}

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

"---------------------------
" ローカル設定
"--------------------------

" 環境に依存した非公開設定を読み込む "{{{
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
" }}}
