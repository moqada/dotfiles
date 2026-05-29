-- conform.nvim: フォーマッタ統合 (旧 neoformat 置き換え)
-- 保存時に自動整形する。formatter バイナリは lsp.lua の mason-tool-installer で導入済み。
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      -- conform の formatters_by_ft はリストを順番にすべて実行する。
      -- prettierd は mason で必ず導入され、プロジェクトの prettier 設定を解決するので
      -- prettier フォールバックは不要。
      formatters_by_ft = {
        lua = { "stylua" },
        -- JS/TS は prettier 整形 → eslint --fix で論理的な修正 (未使用 import 削除等) も実行
        javascript = { "prettierd", "eslint_d" },
        javascriptreact = { "prettierd", "eslint_d" },
        typescript = { "prettierd", "eslint_d" },
        typescriptreact = { "prettierd", "eslint_d" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        -- Go は goimports (import 整理含む) → gofumpt の順で適用
        go = { "goimports", "gofumpt" },
      },
      format_on_save = function(bufnr)
        -- 大きすぎるファイル・整形対象外の filetype はスキップ
        if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
          return
        end
        -- eslint_d の初回起動はデーモン立ち上げで数秒かかる場合があるため余裕を持たせる。
        -- (2 回目以降は速い)
        return { timeout_ms = 5000, lsp_fallback = true }
      end,
    },
    init = function()
      -- 一時的に保存時整形を切るためのコマンド
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, { desc = "Disable autoformat-on-save", bang = true })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, { desc = "Re-enable autoformat-on-save" })
    end,
  },
}
