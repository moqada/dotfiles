-- outline.nvim: LSP シンボルのアウトラインをサイドバー常設表示
--
-- 用途: 関数・変数・型などの一覧を横に出しっぱなしにしつつ、
-- アウトライン上のカーソル移動で該当箇所のコードをフロートプレビューする。
-- 粒度は LSP ベースなので treesitter より粗く、俯瞰しやすい。
return {
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      -- s = symbols (<leader>o は Octo/oil のプレフィックスと衝突するため回避)
      { "<leader>s", "<cmd>Outline<CR>", desc = "Toggle symbols outline" },
    },
    opts = {
      outline_window = {
        -- コードへジャンプしてもアウトラインは開いたままにする
        auto_close = false,
      },
      preview_window = {
        -- アウトライン上でカーソルを合わせると自動でコードをフロートプレビュー
        auto_preview = true,
      },
    },
  },
}
