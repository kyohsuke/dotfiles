-- vim: expandtab softtabstop=2 shiftwidth=2
-- vim: foldmethod=marker

require("config.lazy")

-- Global Settings
require('global')

-- vscode only
if vim.g.vscode then
  require('vsc')
end

-- neovim only
if not vim.g.vscode then
  require('neovim')
end
