-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.tabstop = 4

-- 让 vim 向上查找 tags 文件（从当前文件目录一直找到项目根目录）
vim.o.tags = "./tags;,tags"
