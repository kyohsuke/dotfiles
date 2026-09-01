-- vim: expandtab softtabstop=2 shiftwidth=2
-- vim: foldmethod=marker

-- ステータスライン
vim.opt.statusline = "%<%f %m%r%h%w[%Y]%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%c%V%8P"

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
