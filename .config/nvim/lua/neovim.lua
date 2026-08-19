-- vim: expandtab softtabstop=2 shiftwidth=2
-- vim: foldmethod=marker

-- コンフィグロード
vim.keymap.set("n", ",vimrc", "<Cmd>e $MYVIMRC<CR>", { silent = true})

-- 背景を無効にして透過する
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- ステータスライン
vim.opt.statusline = "%<%f %m%r%h%w[%Y]%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%c%V%8P"

-- Neovimでクリップボードとヤンクを共有
vim.opt.clipboard = "unnamedplus"

-- Change title on Ghostty.app
vim.opt.title = true
vim.opt.titlestring = "%t - Nvim"

-- Kill Indent
vim.opt.autoindent = false
vim.opt.cindent = false
vim.opt.copyindent = false
vim.opt.preserveindent = false
vim.opt.smartindent = false

-- Kill Backup
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.swapfile = false

-- Shortcuts
vim.keymap.set("n", "<C-h>", ":help<Space>", {})
vim.keymap.set("n", "<C-f>", ":setf<Space>", {})

-- Folding Keymap
-- Normal mode: h
vim.keymap.set('n', 'h', function()
  if vim.fn.virtcol('.') == 1 and vim.fn.foldlevel(vim.fn.line('.')) > 0 then
    return 'zc'
  else
    return 'h'
  end
end, { expr = true })

-- Normal mode: l
vim.keymap.set('n', 'l', function()
  if vim.fn.foldclosed(vim.fn.line('.')) ~= -1 then
    return 'zo0'
  else
    return 'l'
  end
end, { expr = true })

-- Visual mode: h
vim.keymap.set('v', 'h', function()
  if vim.fn.virtcol('.') == 1 and vim.fn.foldlevel(vim.fn.line('.')) > 0 then
    return 'zcgv'
  else
    return 'h'
  end
end, { expr = true })

-- Visual mode: l
vim.keymap.set('v', 'l', function()
  if vim.fn.foldclosed(vim.fn.line('.')) ~= -1 then
    return 'zogv0'
  else
    return 'l'
  end
end, { expr = true })
