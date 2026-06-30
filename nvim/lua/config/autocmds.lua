-- autocmd (旧 vimrc の MyAutoCmd から移植)
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- ヤンクした範囲を一瞬ハイライト
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.hl.on_yank() -- Neovim 0.11 で vim.highlight → vim.hl にリネームされた
  end,
})

-- git コミットメッセージではスペルチェックを有効化
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- 多くの言語で標準的な 2 スペースインデントをまとめて設定。
-- (Go = タブ / YAML = 2sp などは ftplugin/ で個別上書き)
--
-- octo は ftplugin/octo.lua にも同じ設定があるが、octo.nvim が buffer を
-- 一度 filetype = "markdown" にしてから "octo" に切り替える経路を持ち、
-- その途中で b:did_ftplugin が立って ftplugin/octo.lua が読まれない
-- ケースがある。FileType autocmd は filetype 変更ごとに発火するので、
-- ここに octo を含めて確実に 2 spaces を最後に set する。
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "jsonc",
    "lua",
    "css",
    "scss",
    "html",
    "vue",
    "svelte",
    "octo",
  },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})

-- ファイルを開いた際に前回のカーソル位置を復元
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
