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
          -- accept は blink.cmp の <Tab> マッピング側で分岐させる (VSCode 風: 補完メニュー > Copilot > 通常 Tab)
          -- <C-l> は明示的に Copilot だけ受け入れたい時のフォールバック
          accept = "<C-l>",
          accept_word = "<C-Right>", -- 単語単位で受け入れ
          accept_line = false,
          next = "<M-]>", -- Option + ]
          prev = "<M-[>",
          -- <C-h> は backspace として使うので避ける。物理的には Ctrl+/ で
          -- 押しているが、ghostty / 多くの terminal は <C-/> を 0x1F (= <C-_>) として
          -- 送るため、表記はそれに合わせる。
          dismiss = "<C-_>",
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
