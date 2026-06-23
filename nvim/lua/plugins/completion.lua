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
      -- <M-i> (Option+i) で明示呼び出し (VSCode の Ctrl+i 相当; <C-i> は <Tab> と区別不能なため避ける)
      -- <Tab> は VSCode 風: blink.cmp メニュー可視時は確定、次に Copilot ghost text を受け入れ、それ以外は通常の Tab
      keymap = {
        preset = "default",
        ["<M-i>"] = { "show", "show_documentation", "hide_documentation" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_and_accept()
            end
            -- カーソル直前が空白だけ (= インデント入力中) なら Copilot suggestion を
            -- 受理せず通常の <Tab> にフォールバックする。VSCode Copilot と同じ挙動。
            local col = vim.fn.col(".") - 1
            local before = vim.fn.getline("."):sub(1, col)
            if before:match("^%s*$") then
              return
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
