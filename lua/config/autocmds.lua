-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("auto_pull_config", { clear = true }),
  callback = function()
    local config_path = vim.fn.stdpath("config") -- ~/.config/nvim
    vim.fn.jobstart({ "git", "-C", config_path, "pull", "--ff-only", "--quiet" }, {
      detach = true,
      on_exit = function(_, code)
        if code == 0 then
          vim.schedule(function()
            vim.notify("Config updated", vim.log.levels.INFO)
          end)
        end
      end,
    })
  end,
})
