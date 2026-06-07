-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Use PowerShell as the shell ONLY on Windows (or when pwsh/powershell is the
-- intended shell). On macOS/Linux these flags would be passed to /bin/zsh,
-- which interprets `-NoLogo` as `-N -o Logo` and fails with
-- "no such option: Logo", breaking :terminal and Snacks.terminal.
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  if vim.fn.executable("pwsh") == 1 then
    vim.o.shell = "pwsh"
  elseif vim.fn.executable("powershell") == 1 then
    vim.o.shell = "powershell"
  end

  vim.o.shellcmdflag =
    "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
  vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.o.shellpipe = '2>&1 | %{ "$_" } | Tee-Object %s; exit $LastExitCode'
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end
