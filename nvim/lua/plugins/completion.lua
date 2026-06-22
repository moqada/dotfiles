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
      -- <C-y> 確定 / <C-n><C-p> 候補移動 / <C-e> キャンセル
      -- <Tab> は VSCode 風: blink.cmp メニュー可視時は確定、次に Copilot ghost text を受け入れ、それ以外は通常の Tab
      keymap = {
        preset = "default",
        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_and_accept()
            end
            if require("copilot.suggestion").is_visible() then
              require("copilot.suggestion").accept()
              return true
            end
          end,
          "fallback",
        },
      },
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
