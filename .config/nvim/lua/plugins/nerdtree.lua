return {
  "preservim/nerdtree",
  dependencies = {
    "Xuyuanp/nerdtree-git-plugin",
  },
  lazy = false,
  keys = {
    { mode = { "n" }, ",nf",   "<Cmd>NERDTreeFind<Return>", { noremap = true } },
    { mode = { "n" }, "<C-e>", "<Cmd>NERDTreeToggle<Return>", { noremap = true } },
  },
  config = function()

    -- NERDTree
    vim.g.NERDTreeNaturalSort = 1
    vim.g.NERDTreeHighlightCursorline = 0
    vim.g.NERDTreeAutoDeleteBuffer = 1
    vim.g.NERDTreeChDirMode = 2
    vim.g.NERDTreeLimitedSyntax = 1
    vim.g.NERDTreeMinimalMenu = 1

    local version = vim.fn['nerdtree#version']()
    vim.g.NERDTreeStatusline = '  NERDTree  ' .. version

    -- NERDTreeバッファで conceal を有効化
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "nerdtree",
      callback = function()
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = "nvic"
      end,
    })
  end,
}
