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
    local function skkeleton_mode_impl()
      local mode = vim.fn['skkeleton#mode']()
      if mode == '' then
        mode = 'ascii'
      end

      local mode_map = {
        ascii   = '[＠]',
        hira    = '[あ]',
        kata    = '[ア]',
        hankata = '[ｶﾅ]',
        zenkaku = '[英]',
        abbrev  = '[A]',
      }

      local display_mode = mode_map[mode] or mode
      return display_mode .. ' ' or ''
    end

    local function skkeleton_mode_cursor_impl()
      local mode = vim.fn['skkeleton#mode']()
      if mode == '' then
        mode = 'ascii'
      end

      -- ascii: ivory4:#8b8b83, gray:#bebebe
      -- hira: coral4:#8b3e2f, pink:#ffc0cb
      -- kata: forestgreen:#228b22, green:#00ff00
      -- abbrev: royalblue:#4169e1
      -- zenei: gold:#ffd700
      local mode_cursor_color_map = {
        ascii   = { fg = '#8b8b83', bg = '#bebebe' },
        hira    = { fg = '#8b3e2f', bg = '#ffc0cb' },
        kata    = { fg = '#228b22', bg = '#00ff00' },
        hankata = { fg = '#228b22', bg = '#00ff00' },
        zenkaku = { fg = '#ffd700' },
        abbrev  = { fg = '#4169e1' },
      }
      local current_color = mode_cursor_color_map[mode]
      vim.api.nvim_set_hl(0, "iCursor", current_color) -- SKK のモードでカーソル色を変更する
    end

    -- グローバルスコープに登録
    _G.skkeleton_mode = skkeleton_mode_impl
    _G.skkeleton_mode_cursor = skkeleton_mode_cursor_impl

    -- statusline に追加
    vim.o.statusline = "%{v:lua.skkeleton_mode()}" .. vim.o.statusline

    -- モード変更時に statusline を redraw
    vim.api.nvim_create_autocmd('User', {
      pattern = 'skkeleton-mode-changed',
      callback = function()
        skkeleton_mode_cursor()
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
