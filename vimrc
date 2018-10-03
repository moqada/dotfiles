" このファイルではマーカー文字列でソースコードを折り畳み表示
" vim: foldmethod=marker
" vim: foldlevel=0
if !has('nvim')
  " neovimはデフォルトでutf-8になる
  set encoding=utf-8
endif
" 日本語文字化けの対処
" https://hori-ryota.com/blog/neovim-fix-input-broken-ttimeout/
set ttimeout
set ttimeoutlen=50
scriptencoding utf8

" dein.vim "{{{
if &compatible
  set nocompatible               " Be iMproved
endif

" 以下の設定はコピペ
" see: http://qiita.com/delphinus35/items/00ff2c0ba972c6e41542

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath != '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリスト
  let s:toml = '~/.vim/rc/dein.toml'
  let s:lazy_toml = '~/.vim/rc/dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" 未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
" }}}"

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
if !has('nvim')
  set t_Co=256
endif
" True color対応
if has('guicolors')
  set guicolors
endif
" nvim >= 0.1.5
if has('termguicolors')
  set termguicolors
endif
" nvim < 0.1.5
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
set background=dark
" colorscheme
" colorscheme iceberg
colorscheme monokai
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
" 必ずカーソルの前後に指定の行数表示してくれるようにする
set scrolloff=5
" エラービープ音の全停止
set visualbell t_vb=
set noerrorbells
" カーソル行のハイライト
set cursorline
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
" backup時にコピーしてから元に戻す
set backupcopy=yes
" コマンド履歴の保存数
set history=500
" buffer切り替え時にhidden状態にする(変更未保存でもbuffer切り替え/undo履歴の保持が可能)
set hidden
"}}}

" 文字コード/改行コード "{{{
" vim-refのwindowsでの文字化け対策
" http://www.karakaram.com/20120726-vim-ref
if has("win32")
  " set encoding より上に書くこと
  let &termencoding = &encoding
endif
set fileencodings=ucs_bom,utf-8,ucs-2le,ucs-2,cp932
set fileformats=unix,dos,mac
" }}}

" キーマッピング "{{{
" 一つ前のバッファに戻る
nnoremap <C-b><C-p> :bprevious<CR>
nnoremap <C-b><C-n> :bnext<CR>
nnoremap <C-b><C-b> :b#<CR>
" スペルチェック機能 ON / OFF をトグルする
nnoremap <silent><Space>s :<C-u>setl spell! spell?<CR>
" vimrc を再読み込み
nnoremap <Space>rv :<C-u>source ~/.vimrc<CR>
" vimrc を編集
nnoremap <silent><Space>ev :<C-u>edit ~/.vimrc<CR>
" jjでesc
inoremap <silent> jj <ESC>
" mmでカレントディレクトリ移動
nnoremap <silent> mm :lcd %:h<CR>
" }}}

" FileType Settings "{{{
" ----------
augroup MyAutoCmd
  " Markdown "{{{2
  autocmd!
  " そのままだと *.md なファイルは modula2 と判断されてしまう
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setl ft=markdown
  " 2}}}"

  " Flow "{{{2
  autocmd BufNewFile,BufRead *.{js,js.flow} setl ft=javascript.jsx
  " 2}}}"

  " Golang "{{{2
  " @see: http://akirachiku.com/2016/03/01/go16-development.html
  autocmd FileType go nmap <leader>gb <Plug>(go-build)
  autocmd FileType go nmap <leader>gt <Plug>(go-test)
  autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
  autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
  autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
  autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
  autocmd FileType go :highlight goErr cterm=bold ctermfg=214
  autocmd FileType go :match goErr /\<err\>/
  " 2}}}"

  " Golang "{{{2
  " for Git commit message
  autocmd FileType gitcommit setl spell
  " 2}}}"

  " TypeScript "{{{2
  autocmd BufRead,BufNewFile *.ts set filetype=typescript
  " 2}}}"
augroup END
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
      \ 'colorscheme': 'tenderplus',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['fugitive', 'gitgutter', 'filename'],
      \   ],
      \   'right': [
      \     ['lineinfo', 'ale'],
      \     ['percent'],
      \     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
      \   ]
      \ },
      \ 'component': {
      \   'lineinfo': '⭡ %3l:%-2v',
      \ },
      \ 'component_function': {
      \   'ale': 'ALEStatus',
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
      \ }
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

" github-complete.vim "{{{
augroup config-github-complete
    autocmd!
    autocmd FileType gitcommit setl omnifunc=github_complete#complete
augroup END
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
" paramとdescriptionのセパレータ文字列
let g:jsdoc_param_description_separator = '-'
" ES6用の省略記法を許可
let g:jsdoc_enable_es6 = 1
nmap <silent> <C-l> <Plug>(jsdoc)
" }}}"

" previm "{{{
let g:previm_open_cmd = 'open -a Google\ Chrome'
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

" vim-submode "{{{
if dein#tap('vim-submode')
  " http://thinca.hatenablog.com/entry/20130131/1359567419
  " window sizeを連続で変更する
  call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
  call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
  call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
  call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
  call submode#map('winsize', 'n', '', '>', '<C-w>>')
  call submode#map('winsize', 'n', '', '<', '<C-w><')
  call submode#map('winsize', 'n', '', '+', '<C-w>+')
  call submode#map('winsize', 'n', '', '-', '<C-w>-')
endif
" }}}"

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
nnoremap <silent> ;; :<C-u>Unite line<CR>
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" 入力モードで開始
call unite#custom#profile('default', 'context', {
\   'short_source_names': 1,
\   'start_insert': 1
\ })

let g:unite_source_rec_max_cache_files = 10000
let s:unite_ignore_file_rec_patterns=
      \ ''
      \ .'.android/\|.atom/\|.cabal/\|.cache/\|.cocoapods/\|.eskk/\|.gem/\|.go/\|.gradle/\|'
      \ .'vendor/bundle\|.bundle/\|\.sass-cache/\|'
      \ .'node_modules/\|bower_components/\|'
      \ .'\.\(bmp\|gif\|jpe\?g\|png\|webp\|ai\|psd\)"\?$'

call unite#custom#source(
      \ 'file_rec/async,file_rec/git',
      \ 'ignore_pattern',
      \ s:unite_ignore_file_rec_patterns)

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
" @see: http://mattn.kaoriya.net/software/vim/20150209151638.htm
  let g:unite_source_rec_async_command=['ag', '--nocolor', '--nogroup', '-g', '""']
endif
" }}}"

" ag を利用したファイル選択など "{{{
" @see: http://mattn.kaoriya.net/software/vim/20150209151638.htm
let g:unite_source_history_yank_enable = 1
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

" vim-go {{{
" @see: http://akirachiku.com/2016/03/01/go16-development.html
let g:go_fmt_command = "goimports"
let g:go_highlight_build_constraints = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
"let g:go_metalinter_autosave = 1
"let g:go_metalinter_autosave_enabled = ['golint', 'gotype', 'govet', 'go']
let g:go_term_enabled = 1
" }}}

" vim-jsx {{{
" .jsx拡張子以外のファイルでも有効にする
let g:jsx_ext_required = 0
" }}}

" vim-test {{{
" @see: http://akirachiku.com/2016/03/01/go16-development.html
if dein#tap('vim-test')
  if has('nvim')
    " neotermを使用する
    let g:test#strategy = 'neoterm'
    " vim-test用に開くbufferのサイズを調整
    let g:neoterm_size = 15
  endif
  nmap <silent> <leader>f :TestNearest<CR>
  nmap <silent> <leader>i :TestFile<CR>
  nmap <silent> <leader>a :TestSuite<CR>
  nmap <silent> <leader>l :TestLast<CR>
  nmap <silent> <leader>g :TestVisit<CR>

  let test#python#pytest#options = {
        \ 'nearest': '-v',
        \ 'file':    '-v',
        \ 'suite':   '-v',
        \ }
  let test#go#gotest#options = {
        \ 'nearest': '-v',
        \ 'file':    '-v',
        \ 'suite':   '-v',
        \ }
endif
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
let g:neosnippet#snippets_directory += ['~/.vim/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets']
let g:neosnippet#snippets_directory += ['~/.vim/dein/repos/github.com/honza/vim-snippets/snippets']
" snippets変数
let g:snips_author = 'Masahiko OKADA'
" keymapping
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" }}}"

" deoplete-go "{{{
if dein#tap('deoplete.nvim')
  " 補完の表示位置を揃える
  let g:deoplete#sources#go#align_class = 1
  " 補完の並び順
  let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
  let g:deoplete#sources#go#package_dot = 1
endif
" }}}"

" neocomplete.vim "{{{
if dein#tap('neocomplete') && !has('nvim')
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
  " for javascirpt(tern_for_vim)
  " see: https://github.com/Shougo/neocomplete.vim/issues/91
  let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'

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
endif
" }}}"

" neco-look "{{{
if dein#tap('neco-look')
  if dein#tap('neocomplete')
    " vim(neocomplete)の場合はneco-lookが発動するfiletypesを設定する
    if !exists('g:neocomplete#text_mode_filetypes')
      let g:neocomplete#text_mode_filetypes = {}
    endif
    let g:neocomplete#text_mode_filetypes = {
          \ 'rst': 1,
          \ 'markdown': 1,
          \ 'gitrebase': 1,
          \ 'gitcommit': 1,
          \ 'vcs-commit': 1,
          \ 'hybrid': 1,
          \ 'text': 1,
          \ 'help': 1,
          \ 'tex': 1,
          \ }
    call neocomplete#custom#source('look', 'min_pattern_length', 1)
  endif
endif
" }}}"

" neoterm "{{{
" start neoterm
nnoremap <silent> tt :T<Space>
" send `cd $(directory of current buffer)` to terminal
nnoremap <silent> tb :T<Space>cd %:p:h<CR>
" hide/close terminal
nnoremap <silent> th :call neoterm#close()<CR>
" clear terminal
nnoremap <silent> tl :call neoterm#clear()<CR>
" kills the current job (send a <c-c>)
vnoremap <silent> tk :call neoterm#kill()<CR>
" }}}"

" tagbar "{{{
if dein#tap('tagbar')
  " Tagbarを開いたときに自動でfocusする
  let g:tagbar_autofocus = 1
  " tagbarのwindow幅を変更
  let g:tagbar_width = 30
  " ,tlでTagbarをtoggleする
  nnoremap ,tl :TagbarToggle<CR>
endif
" }}}"

"---------------------------
" ローカル設定
"--------------------------


" 環境に依存した非公開設定を読み込む "{{{
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
" }}}
