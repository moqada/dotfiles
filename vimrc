" 素 vim 用の最小設定
" -----------------------------------------------------------------------------
" メインエディタは Neovim (~/.config/nvim/init.lua) 側。
" この vimrc はリモートサーバ・sudo vim・Neovim が無い環境の保険として、
" プラグインを使わずに最低限の操作性を確保することだけを目的とする。
" 重い設定や言語別ハイライト等は Neovim 側に任せる。
" -----------------------------------------------------------------------------

if &compatible
  set nocompatible
endif

set encoding=utf-8
scriptencoding utf-8

" 検索
set ignorecase
set smartcase
set hlsearch
set incsearch

" 編集
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0
set autoindent
set smartindent
set backspace=indent,eol,start
set clipboard=unnamed
set hidden
set nofixeol

" 表示
syntax on
set background=dark
set number
set ruler
set cursorline
set showcmd
set showmatch
set matchtime=2
set scrolloff=5
set laststatus=2
set list
set listchars=tab:>-,trail:·,nbsp:␣
set ambiwidth=double
set title

" バックアップ・スワップ
set nobackup
set writebackup
set swapfile
set directory=~/.tmp,~/tmp,/var/tmp,/tmp

" 文字コード
set fileencodings=ucs-bom,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac

" ターミナル日本語入力の取りこぼし対策
set ttimeout
set ttimeoutlen=50

" True Color (対応端末)
if has('termguicolors')
  set termguicolors
endif

" --- キーマッピング (Neovim 側と揃えた最低限) ---
" jj で挿入モードを抜ける
inoremap <silent> jj <Esc>
" mm でカレントバッファのディレクトリへ移動
nnoremap <silent> mm :lcd %:h<CR>
" バッファ移動
nnoremap <silent> <C-b><C-p> :bprevious<CR>
nnoremap <silent> <C-b><C-n> :bnext<CR>
nnoremap <silent> <C-b><C-b> :b#<CR>

" filetype plugin / indent は標準ランタイムのものを有効化
filetype plugin indent on

" 環境固有の上書き
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
