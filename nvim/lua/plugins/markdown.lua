-- Markdown 周辺プラグイン
--   render-markdown.nvim     : バッファ内でインライン描画 (見出し/コードフェンス/チェックボックス等)
--   markdown-preview.nvim    : ブラウザでプレビュー (旧 previm 置き換え)
-- LSP (marksman) は lua/plugins/lsp.lua、整形 (prettier) は lua/plugins/format.lua にある。
-- バッファローカル設定 (2sp / foldmethod / ToggleCheckbox) は ftplugin/markdown.lua。
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft = { "markdown" },
    -- build は autoload 関数を呼ぶ必要があるが、build フック時点では plugin が
    -- ランタイムにロードされていないので、:Lazy load を挟んでから関数を呼ぶ。
    build = function()
      vim.cmd("Lazy load markdown-preview.nvim")
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
}
