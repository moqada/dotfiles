-- 基本オプション (旧 vimrc から移植・現代化)
local opt = vim.opt

-- 検索
opt.ignorecase = true -- 検索時に大文字小文字を無視
opt.smartcase = true -- 大文字を含む場合のみ大文字小文字を区別
opt.hlsearch = true -- 検索語をハイライト
opt.incsearch = true -- インクリメンタル検索

-- インデント・タブ (デフォルトは 4 / expandtab。ftplugin で言語別に上書き)
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 0
opt.autoindent = true
opt.smartindent = true

-- 編集
opt.clipboard = "unnamedplus" -- システムクリップボードと連携
opt.spelllang = { "en", "cjk" } -- スペルチェックで日本語を除外
opt.fixeol = false -- 自動末尾改行追加を無効化
opt.completeopt = { "menu", "menuone", "noselect" }
opt.undofile = true -- undo 履歴を永続化 (旧設定には無かったが現代的に有効化)

-- 表示
opt.termguicolors = true -- True Color
opt.background = "dark"
opt.number = true -- 行番号
opt.cursorline = true -- カーソル行をハイライト
opt.wrap = true -- 長い行を折り返す
opt.list = true -- タブ・行末スペース等を可視化
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.showmatch = true -- 対応する括弧を強調
opt.matchtime = 2
opt.colorcolumn = "80" -- 80 桁にガイド
opt.scrolloff = 5 -- カーソル前後に最低 5 行表示
opt.signcolumn = "yes" -- 診断・Git サインで横幅がブレないよう常時表示
opt.title = true
opt.showcmd = true
opt.laststatus = 3 -- グローバルステータスライン (lualine と相性が良い)
-- ambiwidth は Neovim デフォルト (single) のまま。
-- 旧 vimrc は "double" を指定していたが、ghostty 等の現代端末は ambiguous=single 想定で
-- 表示するため、Neovim 側で double にすると listchars との衝突 (E834) や幅のズレが発生する。

-- ベル
opt.visualbell = false
opt.errorbells = false

-- バックアップ・スワップ
opt.backup = false
opt.writebackup = true
opt.swapfile = true

-- 文字コード・改行コード
opt.fileencodings = { "ucs-bom", "utf-8", "euc-jp", "cp932" }
opt.fileformats = { "unix", "dos", "mac" }

-- ターミナルでの日本語入力の取りこぼし対策
-- https://hori-ryota.com/blog/neovim-fix-input-broken-ttimeout/
opt.ttimeout = true
opt.ttimeoutlen = 50
