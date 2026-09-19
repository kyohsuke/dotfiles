-- vim: expandtab softtabstop=2 shiftwidth=2
-- vim: foldmethod=marker

-- コンフィグロード
vim.keymap.set("n", ",vimrc", function()
  vim.cmd("edit $MYVIMRC")

  if vim.fn.exists(":NERDTreeFind") == 2 then
    local win = vim.api.nvim_get_current_win()

    vim.cmd("NERDTreeFind")

    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_set_current_win(win)
    end
  end
end, { silent = true })

-- 背景を無効にして透過する
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

local augroup = vim.api.nvim_create_augroup('VimrcTechniqueBible_1_10', { clear = true })
vim.api.nvim_create_autocmd('InsertEnter', {
  group = augroup,
  callback = function()
    vim.api.nvim_set_hl(0, 'StatusLine', {
      fg = 'DarkBlue',
      bg = 'DarkYellow',
      ctermfg = 'Blue',
      ctermbg = 'Yellow',
    })
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  group = augroup,
  callback = function()
    vim.api.nvim_set_hl(0, 'StatusLine', {
      fg = 'DarkBlue',
      bg = 'DarkGray',
      ctermfg = 'Blue',
      ctermbg = 'DarkGray',
    })
  end,
})


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
