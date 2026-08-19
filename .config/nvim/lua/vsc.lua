-- VSCode SKK (AquaSKK) 用の autocmd
local group_id = vim.api.nvim_create_augroup("VisualStudioCodeSKK", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  group = group_id,
  pattern = "*",
  callback = function()
    vim.fn.system("macism jp.sourceforge.inputmethod.aquaskk.Ascii")
  end,
})
