-- lazy.nvim (プラグインマネージャ) の bootstrap と読み込み
-- 旧 dein.vim 相当。未導入なら自動で clone する。
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "lazy.nvim の clone に失敗しました:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nEnter キーで終了します..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- lua/plugins/ 配下の *.lua をすべてプラグイン定義として読み込む
  spec = { { import = "plugins" } },
  install = { colorscheme = { "tokyonight" } },
  -- 更新チェックは行うが通知はうるさいので抑制
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  -- luarocks サポートは無効化。今回採用したプラグイン群では不要で、
  -- これを切っておくと checkhealth から noisy な ERROR/WARNING が消える。
  -- 将来 luarocks 依存のプラグインを入れたくなったらここを外す。
  rocks = { enabled = false },
  performance = {
    rtp = {
      -- 使わない標準プラグインを無効化して起動を軽くする
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "zipPlugin", "netrwPlugin" },
    },
  },
})
