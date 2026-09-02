return {
  "ryanoasis/vim-devicons",
  lazy = false,
  config = function()
    -- devicons
    vim.g.webdevicons_enable_ctrlp = 0
    vim.g.WebDevIconsNerdTreeGitPluginForceVAlign = 0
    vim.g.WebDevIconsNerdTreeAfterGlyphPadding = ''

    -- ブラケットを隠す
    vim.g.webdevicons_conceal_nerdtree_brackets = 1
  end,
}
