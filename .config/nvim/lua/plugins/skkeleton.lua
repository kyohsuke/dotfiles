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
    -- statusline に追加
    vim.o.statusline = vim.o.statusline .. "%{get(g:, 'skkeleton#mode', '')} "

    -- モード変更時に statusline を redraw
    vim.api.nvim_create_autocmd('User', {
      pattern = 'skkeleton-mode-changed',
      callback = function()
        local function skkeleton_mode()
          local mode = vim.fn['skkeleton#mode']()
          if mode == '' then
            return ''
          end

          local mode_map = {
            hira = '[ひ]',
            kata = '[カ]',
            hankata = '[ハ]',
            zenkaku = '[全]',
            abbrev = '[A]',
          }

          local display_mode = mode_map[mode] or mode
          vim.api.nvim_echo({{'SKK mode: ' .. mode .. ' -> ' .. display_mode, "Normal"}}, true, {})

          return display_mode or 'NONE'
        end

        vim.api.nvim_echo({{'Redraw'}}, true, {})
        vim.cmd.redrawstatus()
      end,
      group = vim.api.nvim_create_augroup('skkeleton-statusline', { clear = true }),
    })

    vim.cmd([[ call skkeleton#config({
      \ 'completionRankFile': '~/.local/state/skkeleton_rank.json',
      \ 'userDictionary': '~/.local/state/skkeleton_user.dic',
      \ 'sources': ['skk_server'],
      \ 'eggLikeNewline': v:true,
      \ })]])
    end
  }
