# コミットルール（dotfiles）

このリポジトリのコミットスタイル。moqada-commit スキルのオーバーレイとして適用する。

## 形式

- `scope: Subject` 形式（Conventional Commit 寄り）。scope は変更対象のトピック（`nvim` / `tmux` / `git` / `karabiner` / `claude` など）。
- **subject は英語**。先頭大文字・命令形（imperative mood）・末尾ピリオドなし。
- **body は日本語**。必要な場合のみ記述し、変更の理由・背景を書く。

## トレーラー

- 末尾に `Co-Authored-By: Claude <モデル名> <noreply@anthropic.com>` を付ける。

## 例

```
nvim: Add symbols outline sidebar via outline.nvim

関数・変数・型などの LSP シンボル一覧を、編集中もサイドバーに
出しっぱなしにできるようにする。

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>
```
