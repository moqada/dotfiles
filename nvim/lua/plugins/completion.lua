-- 補完エンジン: blink.cmp (旧 neocomplete/deoplete 置き換え)
-- Rust 製で高速・設定少なめ。LuaSnip と friendly-snippets を組み合わせて使う。
return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "*", -- 安定版タグを使用 (build 不要のプリビルトを取得)
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    opts = {
      keymap = { preset = "default" }, -- <C-y> 確定 / <C-n><C-p> 候補移動 / <C-e> キャンセル
      appearance = { nerd_font_variant = "mono" },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
      },
      signature = { enabled = true },
    },
  },
}
