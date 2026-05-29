-- UI 補助
--   indent-blankline : インデントガイド (旧 vim-indent-guides 置き換え)
--   which-key        : キーマップをポップアップ表示 (何が割り当たっているか把握しやすくする)
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
