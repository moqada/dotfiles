-- neo-tree: ファイルエクスプローラ (旧 vimfiler 置き換え)
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      -- 旧 <Leader>e (VimFilerBufferDir) 相当
      { "<leader>e", "<cmd>Neotree toggle reveal<CR>", desc = "Explorer (reveal current file)" },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        width = 32,
      },
    },
  },
}
