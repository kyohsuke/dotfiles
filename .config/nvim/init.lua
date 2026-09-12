-- vim: expandtab softtabstop=2 shiftwidth=2
-- vim: foldmethod=marker

-- ステータスライン
vim.opt.statusline = "%<%f %m%r%h%w[%Y]%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%c%V%8P"

require("config.lazy")

-- Global Settings
require('global')

if vim.g.vscode then
  require('vsc')
else
  require('neovim')
end

if vim.g.neovide then
  require('neovide')
end
