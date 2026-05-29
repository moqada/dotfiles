-- Markdown: 旧 vim/after/ftplugin/markdown.vim から踏襲
--   - 2 スペースインデント
--   - インデントベースの折りたたみ
--   - `tl` 略語で `- [ ]`
--   - <Leader><Leader> でチェックボックスをトグル
vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

vim.wo.foldmethod = "indent"

-- TODO 項目の入力補助
vim.cmd("iabbrev <buffer> tl - [ ]")

local function toggle_checkbox()
  local line = vim.api.nvim_get_current_line()
  local new
  if line:match("%-%s%[%s%]") then
    new = line:gsub("%-%s%[%s%]", "- [x]", 1)
  elseif line:match("%-%s%[x%]") then
    new = line:gsub("%-%s%[x%]", "- [ ]", 1)
  end
  if new then
    vim.api.nvim_set_current_line(new)
  end
end

vim.keymap.set({ "n", "v" }, "<leader><leader>", toggle_checkbox, {
  buffer = true,
  silent = true,
  desc = "Markdown: Toggle checkbox",
})
