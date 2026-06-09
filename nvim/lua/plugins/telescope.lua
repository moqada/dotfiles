-- telescope: ファジーファインダ (旧 unite.vim 置き換え)
-- fzf-native でソートを高速化 (要 make。Brewfile の fzf とは別物で内部ビルド)
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
      -- カレントファイルのディレクトリを起点に検索 (大文字版)
      {
        "<leader>fF",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.expand("%:p:h"),
            prompt_title = "Find Files (current dir)",
          })
        end,
        desc = "Find files (current file's dir)",
      },
      {
        "<leader>fG",
        function()
          require("telescope.builtin").live_grep({
            cwd = vim.fn.expand("%:p:h"),
            prompt_title = "Live Grep (current dir)",
          })
        end,
        desc = "Live grep (current file's dir)",
      },
      -- 旧 unite の <Space><Space> 相当 (ファイル検索)
      { "<leader><leader>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    },
    -- opts は関数で遅延評価する (telescope.actions の require はロード後に行う必要があるため)
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          mappings = {
            i = { ["jj"] = actions.close },
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
