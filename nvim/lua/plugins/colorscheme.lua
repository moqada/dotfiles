-- カラースキーム (旧 monokai → tokyonight)
-- 背景透過は旧設定の `highlight Normal guibg=NONE` を踏襲。
return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- メインの colorscheme は起動時に読み込む
    priority = 1000, -- 他プラグインより先に読み込む
    opts = {
      style = "night",
      transparent = true, -- 背景透過
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        -- ウィンドウ境界線が薄くて見えにくいので青系で強調する
        hl.WinSeparator = { fg = c.blue, bg = "NONE", bold = true }
        -- Copilot の ghost text の明度調整。
        -- comment (薄すぎ) と fg_dark (通常テキストに近く濃すぎ) の中間。
        hl.CopilotSuggestion = { fg = c.dark5, italic = true }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
