-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

-- 快速打开右侧垂直终端
vim.keymap.set("n", "<leader>tc", function()
  Snacks.terminal.open("claude-internal", {
    win = {
      position = "right", -- "float" | "right" | "bottom" | "left" | "top"
      width = 0.4, -- 占屏幕宽度 40%（也可写整数列数，如 80）
      height = 0.9,
      border = "rounded",
      wo = { winbar = "" },
    },
    -- 同一个 cwd + 同一条 cmd 会复用同一个 terminal 实例（toggle 行为）
    cwd = vim.fn.getcwd(),
    interactive = true,
    auto_close = false, -- 进程退出后不自动关
    auto_insert = true, -- 打开后直接进入 insert 模式
  })
end, { desc = "Claude terminal" })
