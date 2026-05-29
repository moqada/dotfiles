-- mini.nvim: 軽量な編集補助モジュール群
--   mini.surround : 旧 surround.vim 置き換え (sa/sd/sr で囲み操作)
--   mini.pairs    : 旧 vim-smartinput 置き換え (括弧の自動補完)
--   mini.comment  : gc/gcc でコメントトグル
--   mini.ai       : テキストオブジェクト拡張 (a/i の対象を強化)
return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup()
      require("mini.pairs").setup()
      require("mini.comment").setup()
      require("mini.ai").setup()
    end,
  },
}
