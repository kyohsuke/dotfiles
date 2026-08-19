return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
      { mode = "n", "<C-e>", "<Cmd>Neotree toggle<CR>", { noremap = true, silent = true } },
      { mode = "n", ",nf", "<Cmd>Neotree reveal<CR>", { noremap = true, silent = true } },
    },
    opts = {
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            local root_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
            vim.opt_local.statusline = '  Neo-tree  ' .. root_dir .. ' '
          end,
        },
      },
      filesystem = {
        filtered_items = {
          visible = false,          -- trueにすると、隠しファイル等のステータスに関わらず全て表示されます
          hide_gitignored = false,  -- .gitignoreで指定されたファイルを隠すかどうか
          hide_hidden = false,      -- Windows等のOSの隠しファイル属性を持つファイルを隠すかどうか
        }
      }
    },
  }
}
