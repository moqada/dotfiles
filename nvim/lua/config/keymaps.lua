-- キーマッピング (旧 vimrc から移植)
-- LSP 系のマッピングは lua/plugins/lsp.lua の LspAttach、
-- プラグイン固有のものは各プラグイン定義側で設定している。
local map = vim.keymap.set

-- jj で挿入モードを抜ける
map("i", "jj", "<Esc>", { silent = true, desc = "Escape" })

-- mm でカレントバッファのディレクトリへ移動
map("n", "mm", "<cmd>lcd %:h<CR>", { silent = true, desc = "lcd to buffer dir" })

-- バッファ移動 (旧 <C-b> プレフィックス)
map("n", "<C-b><C-p>", "<cmd>bprevious<CR>", { silent = true, desc = "Prev buffer" })
map("n", "<C-b><C-n>", "<cmd>bnext<CR>", { silent = true, desc = "Next buffer" })
map("n", "<C-b><C-b>", "<cmd>b#<CR>", { silent = true, desc = "Alternate buffer" })

-- スペルチェックのトグル
map("n", "<leader>ts", "<cmd>setlocal spell! spell?<CR>", { silent = true, desc = "Toggle spell" })

-- 検索ハイライトを Esc で消す
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

-- ウィンドウ移動 (旧設定には無いが利便性のため追加)
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
