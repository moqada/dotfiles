-- nvim-treesitter: 構文解析ベースのハイライト・インデント
-- 旧 yajs/vim-flow/typescript-vim 等の言語別 syntax プラグインを置き換える。
-- 対応言語を増やしたいときは ensure_installed に追記する。
return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- 2025 年にデフォルトブランチが master → main に変わった。main は API が刷新中で
    -- 周辺プラグイン (render-markdown 等) は引き続き master 系を前提にしているため master 固定。
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        -- 主要ターゲット
        "typescript",
        "tsx",
        "javascript",
        "go",
        "gomod",
        "gosum",
        "markdown",
        "markdown_inline",
        -- 設定・周辺
        "lua",
        "vim",
        "vimdoc",
        "json",
        "jsonc",
        "yaml",
        "toml",
        "bash",
        "html",
        "css",
        "dockerfile",
        "gitcommit",
        "diff",
      },
      auto_install = true, -- 未インストールの parser を開いたとき自動導入
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
