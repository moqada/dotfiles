-- lualine: ステータスライン (旧 lightline 置き換え)
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true, -- laststatus=3 に合わせる
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } }, -- 相対パス表示
        lualine_x = { "encoding", "fileformat", "filetype" },
      },
    },
  },
}
