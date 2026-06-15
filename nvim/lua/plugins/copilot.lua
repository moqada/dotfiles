-- GitHub Copilot: ghost text (インライン候補) 表示モード
-- VSCode 風に薄文字で suggestion が出て、<C-l> で受け入れる。
-- 補完エンジン (blink.cmp) とは独立して動く。
-- 初回は :Copilot auth で OAuth 認証が必要。
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = { enabled = false }, -- 別ウィンドウのパネル表示は無効 (ghost text のみ使う)
      suggestion = {
        enabled = true,
        auto_trigger = true, -- 入力中に自動で suggestion を出す
        debounce = 75,
        keymap = {
          accept = "<C-l>", -- suggestion 全体を受け入れ (Tab は blink.cmp と衝突するため避ける)
          accept_word = "<C-Right>", -- 単語単位で受け入れ
          accept_line = false,
          next = "<M-]>", -- Option + ]
          prev = "<M-[>",
          dismiss = "<C-h>",
        },
      },
      filetypes = {
        -- 機密情報や個人ノートでは無効化する
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        markdown = true, -- ドキュメント執筆では便利なので有効
        ["."] = false, -- 拡張子なしファイルは無効
      },
    },
  },
}
