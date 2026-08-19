return {
  "vim-skk/skkeleton",
  dependencies = {
    "vim-denops/denops.vim",
    "Shougo/ddc.vim",
  },
  lazy = false,
  keys = {
    { mode = {"i", "c"}, "<C-j>", "<Plug>(skkeleton-enable)", { noremap = true } },
    { mode = {"i", "c"}, "<C-l>", "<Plug>(skkeleton-disable)", { noremap = true } },
  },
  config = function()
    vim.cmd([[ call skkeleton#config({
        \ 'completionRankFile': '~/.local/state/skkeleton_rank.json',
        \ 'userDictionary': '~/.local/state/skkeleton_user.dic',
        \ 'sources': ['skk_server'],
        \ 'eggLikeNewline': v:true,
        \ })]])
  end
}
