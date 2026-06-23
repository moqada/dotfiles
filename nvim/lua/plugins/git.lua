-- Git 連携
--   gitsigns: 差分サイン・hunk 操作 (旧 vim-gitgutter 置き換え)
--   vim-fugitive: :G コマンド群 (旧設定から継続。現在も現役のデファクト)
--   gitlinker: カーソル位置の GitHub permalink を yank / open
--   octo.nvim: GitHub PR / Issue を buffer ベースで操作 (gh CLI 経由)
--   diffview.nvim: PR 差分や file history をファイルツリー付きで表示
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- カーソル行に inline blame を表示 (VSCode GitLens / Zed と同等)
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 行末に出す (右側)
        delay = 500, -- カーソル停止から表示までの ms
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "  ╲ <author>, <author_time:%Y-%m-%d> • <summary>",
      on_attach = function(buffer)
        local gs = require("gitsigns")
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
        end
        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Prev hunk")
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Gdiffsplit", "Gblame", "Glog", "Gstatus" },
  },
  -- カーソル行 (or 選択範囲) の GitHub permalink を yank / ブラウザで開く
  -- (VSCode の "Copy Remote File URL" 相当)
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git permalink (commit)" },
      { "<leader>gY", "<cmd>GitLink default_branch<cr>", mode = { "n", "v" }, desc = "Yank git link (default branch)" },
      { "<leader>gB", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git permalink in browser" },
    },
    opts = {
      router = {
        -- 通常の permalink (現在の HEAD 固定)。
        -- gitlinker.nvim 標準だと lk.repo に ".git" が残るリポジトリで 404 になる
        -- ケースがあるため、明示的にサフィックスを落とす。
        browse = {
          ["^github%.com"] = function(lk)
            local repo = lk.repo:gsub("%.git$", "")
            local url = ("https://github.com/%s/%s/blob/%s/%s"):format(lk.org, repo, lk.rev, lk.file)
            if lk.lstart and lk.lend and lk.lend ~= lk.lstart then
              return url .. "#L" .. lk.lstart .. "-L" .. lk.lend
            elseif lk.lstart then
              return url .. "#L" .. lk.lstart
            end
            return url
          end,
        },
        -- default branch の **最新 commit hash** で固定する permalink。
        -- ブランチ名のままだと内容が変動して permalink にならないため、
        -- origin/<default_branch> の HEAD hash を解決して埋め込む。
        default_branch = {
          ["^github%.com"] = function(lk)
            local cwd = lk.cwd or vim.fn.expand("%:p:h")
            local branch = vim.fn.systemlist({ "git", "-C", cwd, "rev-parse", "--abbrev-ref", "origin/HEAD" })[1] or ""
            branch = branch:gsub("^origin/", "")
            if branch == "" then branch = "main" end
            local hash = vim.fn.systemlist({ "git", "-C", cwd, "rev-parse", "origin/" .. branch })[1]
            local rev = (hash and hash ~= "") and hash or branch
            local repo = lk.repo:gsub("%.git$", "")
            local url = ("https://github.com/%s/%s/blob/%s/%s"):format(lk.org, repo, rev, lk.file)
            if lk.lstart and lk.lend and lk.lend ~= lk.lstart then
              return url .. "#L" .. lk.lstart .. "-L" .. lk.lend
            elseif lk.lstart then
              return url .. "#L" .. lk.lstart
            end
            return url
          end,
        },
      },
    },
  },
  -- GitHub の PR / Issue を Neovim から操作 (gh CLI 経由)。
  -- レビュー submit、行コメント、suggestion 適用、approve / request changes まで賄える。
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      -- Octo PR 系は <leader>op プレフィックスに統一 (op = Octo PR)。
      -- 3 文字目: l=list / s=search / c=checkout / r=review start / R=resume / S=submit / D=discard
      { "<leader>opl", "<cmd>Octo pr list<cr>", desc = "Octo PR: list" },
      { "<leader>ops", "<cmd>Octo pr search<cr>", desc = "Octo PR: search" },
      { "<leader>opc", "<cmd>Octo pr checkout<cr>", desc = "Octo PR: checkout" },
      -- GitHub は PR ごとに pending review を 1 つしか持てない。
      -- start でエラー (You can only have one pending review …) が出たら R で resume する。
      { "<leader>opr", "<cmd>Octo review start<cr>", desc = "Octo PR: start review" },
      { "<leader>opR", "<cmd>Octo review resume<cr>", desc = "Octo PR: resume pending review" },
      { "<leader>opS", "<cmd>Octo review submit<cr>", desc = "Octo PR: submit review" },
      { "<leader>opD", "<cmd>Octo review discard<cr>", desc = "Octo PR: discard pending review" },
      -- Issue 系
      { "<leader>oil", "<cmd>Octo issue list<cr>", desc = "Octo Issue: list" },
    },
    opts = {
      enable_builtin = true,
      picker = "telescope",
      default_merge_method = "squash",
      -- <space> を leader にしているため、デフォルトの <space>ca / <space>sa は
      -- which-key の <leader>c… サブメニューに飲まれて候補に出ない。
      -- review 系の主要操作を <leader>v* (review/visual) 配下に明示的に再配置する。
      mappings = {
        review_diff = {
          add_review_comment = { lhs = "<leader>vc", desc = "add review comment" },
          add_review_suggestion = { lhs = "<leader>vs", desc = "add review suggestion" },
          -- GitHub の "Viewed" チェックボックス相当 (mark file as viewed をトグル)
          toggle_viewed = { lhs = "<leader>vv", desc = "toggle viewed (this file)" },
        },
        file_panel = {
          -- file panel 側でも同じキーで toggle できるように揃える
          toggle_viewed = { lhs = "<leader>vv", desc = "toggle viewed (this file)" },
        },
        review_thread = {
          add_comment = { lhs = "<leader>vc", desc = "add review comment" },
          add_suggestion = { lhs = "<leader>vs", desc = "add review suggestion" },
          delete_comment = { lhs = "<leader>vd", desc = "delete review comment" },
        },
      },
    },
  },
  -- 差分をファイルツリー付きで閲覧。PR の "Files changed" 相当を nvim 内で見るのに使う。
  -- octo の review と組み合わせると、行コメントを付けながら差分を歩ける。
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewRefresh" },
    keys = {
      { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Diffview: working tree vs HEAD" },
      -- origin の default branch との 3-dot 差分 (PR のレビュー範囲と同じ)
      {
        "<leader>dV",
        function()
          local cwd = vim.fn.expand("%:p:h")
          local branch = vim.fn.systemlist({ "git", "-C", cwd, "rev-parse", "--abbrev-ref", "origin/HEAD" })[1] or ""
          branch = branch:gsub("^origin/", "")
          if branch == "" then branch = "main" end
          vim.cmd("DiffviewOpen origin/" .. branch .. "...HEAD")
        end,
        desc = "Diffview: PR diff (origin/HEAD...HEAD)",
      },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diffview: close" },
      { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: current file history" },
      { "<leader>dH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: repo history" },
      -- GitHub の "Hide whitespace" 相当。diffopt は vim の diff 全般に効くので
      -- gitsigns / fugitive / diffview いずれの差分表示にも反映される。
      {
        "<leader>dw",
        function()
          local list = vim.opt.diffopt:get()
          local removed = false
          for i = #list, 1, -1 do
            if list[i] == "iwhite" or list[i] == "iwhiteall" or list[i] == "iwhiteeol" then
              table.remove(list, i)
              removed = true
            end
          end
          if removed then
            vim.opt.diffopt = list
            vim.notify("Diff: show whitespace", vim.log.levels.INFO)
          else
            vim.opt.diffopt:append("iwhite")
            vim.notify("Diff: hide whitespace (iwhite)", vim.log.levels.INFO)
          end
          pcall(vim.cmd.DiffviewRefresh)
        end,
        desc = "Diff: toggle hide whitespace",
      },
    },
  },
}
