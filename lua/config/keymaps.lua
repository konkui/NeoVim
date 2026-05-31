-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Ctrl-] 强制走 ctags 文件（绕过 LSP 的 tagfunc 劫持）
-- gd 继续走 LSP（自己的代码更精准）
vim.keymap.set("n", "<C-]>", function()
  local word = vim.fn.expand("<cword>")
  -- 临时清空 tagfunc，让 :tag 直接读 tags 文件
  local old = vim.bo.tagfunc
  vim.bo.tagfunc = ""
  local ok, err = pcall(vim.cmd, "tag " .. word)
  vim.bo.tagfunc = old
  if not ok then
    vim.notify("ctags: no tag found for '" .. word .. "'", vim.log.levels.WARN)
  end
end, { desc = "Jump to tag (ctags, bypass LSP)" })

-- <leader>tc: 在右侧打开终端并运行 claude-internal
vim.keymap.set("n", "<leader>tc", function()
  Snacks.terminal("claude-internal", {
    win = {
      position = "right",
      width = 0.3,
      height = 0.3,
      wo = {
        winfixwidth = true,
      },
    },
  })
end, { desc = "Terminal: claude-internal (right)" })
