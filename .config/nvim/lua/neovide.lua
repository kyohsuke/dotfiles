-- vim: expandtab softtabstop=2 shiftwidth=2
-- vim: foldmethod=marker

vim.g.neovide_remember_window_size = false
vim.opt.guifont     = 'Cica:h14'
vim.opt.guifontwide = 'Cica-Regular:h14'
vim.g.neovide_opacity = 0.9
vim.opt.lines   = 60
vim.opt.columns = 200


-- copy & paste
local function copy() vim.cmd([[normal! "+y]]) end
local function paste() vim.api.nvim_paste(vim.fn.getreg("+"), true, -1) end
vim.keymap.set("v", "<D-c>", copy, { silent = true, desc = "Copy" })
vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-v>", paste, { silent = true, desc = "Paste" })

vim.api.nvim_create_autocmd("FocusGained", {
  pattern = "*",
  callback = function()
    vim.g.neovide_opacity = 0.9
  end,
})

vim.api.nvim_create_autocmd("FocusLost", {
  pattern = "*",
  callback = function()
    vim.g.neovide_opacity = 0.5
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      vim.g.neovide_opacity = 0.9
      vim.opt.lines   = 60
      vim.opt.columns = 200
    end, 60)
  end,
})
