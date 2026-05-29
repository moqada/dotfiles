-- Neovim 設定エントリポイント
-- 構成は把握しやすさ重視で機能/言語ごとに lua/ 配下へ分割している。
--   lua/config/  ... プラグインに依存しない基本設定 (options/keymaps/autocmds) と lazy bootstrap
--   lua/plugins/ ... lazy.nvim が読み込むプラグイン定義 (1 ファイル = 1 関心事)
--   ftplugin/    ... filetype ごとのバッファローカル設定

-- leader はプラグイン読み込み前に設定する必要がある
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- リモートプラグイン (古い VimScript プラグインが Node/Python/Ruby/Perl ホストを使う仕組み)
-- 用のプロバイダを無効化。今回採用したプラグイン群はすべて Lua/Neovim 組込みで動作し
-- これらは不要。:checkhealth のノイズも消える。
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
