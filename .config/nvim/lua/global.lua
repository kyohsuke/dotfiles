-- Set Complete Options
vim.opt.completeopt = "menu,noselect"

-- Set Visual settings
vim.opt.showmatch = true
vim.opt.virtualedit = "all"
vim.opt.number = true
vim.opt.relativenumber = true

-- ColorColumn
vim.opt.colorcolumn = "80,128"
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "DarkRed", ctermbg = 4 })

-- File Encoding detects
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "ucs-bom,utf-8,euc-jp,cp932,iso-2022-jp"
vim.opt.fileformats = "unix,dos,mac"
vim.opt.langmenu = "ja_JP.utf-8"

-- languages
vim.cmd.language('ja_JP.utf-8')
vim.opt.helplang = { 'ja', 'en' }

-- noremap : ;
vim.keymap.set({ "n", "v", "o" }, ":", ";")
-- noremap ; :
vim.keymap.set({ "n", "v", "o" }, ";", ":")

-- nnoremap <silent> <D-[> :<C-u>bprev<Return>
vim.keymap.set("n", "<D-[>", "<Cmd>bprev<CR>", { silent = true })
-- nnoremap <silent> <D-]> :<C-u>bnext<Return>
vim.keymap.set("n", "<D-]>", "<Cmd>bnext<CR>", { silent = true })

-- 物理行と論理行の移動入れ替え
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "gk", "k")

-- Esc 2回でハイライト消去
vim.keymap.set("n", "<Esc><Esc>", "<Cmd>noh<CR>", { silent = true })
