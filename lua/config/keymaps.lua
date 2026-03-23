-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

-- 快速打开右侧垂直终端
vim.keymap.set(
  "n",
  "<leader>tv",
  "<cmd>2ToggleTerm direction=vertical size=60<cr>",
  { desc = "Terminal Vertical (Right)" }
)
