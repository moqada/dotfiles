-- Git 連携
--   gitsigns: 差分サイン・hunk 操作 (旧 vim-gitgutter 置き換え)
--   vim-fugitive: :G コマンド群 (旧設定から継続。現在も現役のデファクト)
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
}
