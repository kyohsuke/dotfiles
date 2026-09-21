return {
  {
    "ray-x/go.nvim",

    -- Go buffer を開いたときだけロード
    ft = {
      "go",
      "gomod",
      "gowork",
    },

    dependencies = {
      -- go.nvim の float/select/terminal UI
      "ray-x/guihua.lua",

      -- 既存の gopls/LSP 設定をそのまま利用
      "neovim/nvim-lspconfig",

      -- Delve / DAP
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },

    -- Neovim 0.12 では master を使用。
    -- Neovim 0.11 の場合は:
    -- version = "v0.11",

    opts = {
      ------------------------------------------------------------------
      -- LSP
      --
      -- gopls は lua/plugins/lsp.lua が唯一の設定箇所。
      ------------------------------------------------------------------
      lsp_cfg = false,
      lsp_keymaps = false,
      lsp_codelens = false,

      -- 既存の vim.diagnostic.config() を維持
      diagnostic = false,

      ------------------------------------------------------------------
      -- Formatting
      --
      -- 旧 vim-go:
      --   g:go_fmt_command = "goimports"
      --   g:go_fmt_autosave = 1
      ------------------------------------------------------------------
      goimports = "goimports",
      gofmt = "goimports",

      -- gopls の format を go.nvim から設定しない。
      -- BufWritePre で goimports を明示的に呼ぶ。
      lsp_document_formatting = false,

      ------------------------------------------------------------------
      -- Inlay hints
      --
      -- 旧 Vim 設定には存在しなかったので OFF。
      ------------------------------------------------------------------
      lsp_inlay_hints = {
        enable = false,
      },

      ------------------------------------------------------------------
      -- Go testing
      --
      -- 旧 quickrun:
      --   go test ./...
      ------------------------------------------------------------------
      test_runner = "go",
      verbose_tests = false,

      ------------------------------------------------------------------
      -- Terminal
      --
      -- 旧 quickrun は split buffer に出力していたため、
      -- go.nvim の floating terminal をデフォルトにしない。
      ------------------------------------------------------------------
      run_in_floaterm = false,

      ------------------------------------------------------------------
      -- Treesitter textobject
      --
      -- 現在の dotfiles では go.nvim のために Treesitter plugin を
      -- 追加していないので、ここでは有効化しない。
      ------------------------------------------------------------------
      textobjects = false,

      ------------------------------------------------------------------
      -- Snippets
      --
      -- 現在 nvim-cmp は LSP source のみを使っているため、
      -- go.nvim 内蔵 LuaSnip は有効化しない。
      ------------------------------------------------------------------
      luasnip = false,

      ------------------------------------------------------------------
      -- AI
      --
      -- 現在の dotfiles には不要。
      ------------------------------------------------------------------
      ai = {
        enable = false,
      },

      ------------------------------------------------------------------
      -- null-ls
      --
      -- 現在の構成では利用していないので使用しない。
      ------------------------------------------------------------------
      null_ls = false,

      ------------------------------------------------------------------
      -- Trouble 等
      ------------------------------------------------------------------
      trouble = false,
    },

    config = function(_, opts)
      require("go").setup(opts)

      ------------------------------------------------------------------
      -- goimports on save
      --
      -- 旧 vim-go:
      --   let g:go_fmt_command = "goimports"
      --   let g:go_fmt_autosave = 1
      ------------------------------------------------------------------
      local format_group = vim.api.nvim_create_augroup(
        "GoFormat",
        { clear = true }
      )

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_group,
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
      })

      ------------------------------------------------------------------
      -- quickrun からの移行
      --
      -- 旧:
      --   <Leader>r -> go run %:p
      --   <Leader>t -> go test ./...
      --
      -- Go buffer にだけ設定する。
      ------------------------------------------------------------------
      local go_group = vim.api.nvim_create_augroup(
        "GoKeymaps",
        { clear = true }
      )

      vim.api.nvim_create_autocmd("FileType", {
        group = go_group,
        pattern = {
          "go",
          "gomod",
          "gowork",
        },
        callback = function(ev)
          local opts_local = {
            buffer = ev.buf,
            silent = true,
          }

          ----------------------------------------------------------------
          -- Run
          --
          -- go.nvim の GoRun は通常 current package を実行する。
          -- 旧 quickrun の「現在ファイルだけを go run」ではなく、
          -- Go の通常の package 実行に合わせている。
          ----------------------------------------------------------------
          vim.keymap.set(
            "n",
            "<Leader>r",
            "<cmd>GoRun<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: run",
            })
          )

          ----------------------------------------------------------------
          -- Test: go test ./...
          ----------------------------------------------------------------
          vim.keymap.set(
            "n",
            "<Leader>t",
            "<cmd>GoTest<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: test ./...",
            })
          )

          ----------------------------------------------------------------
          -- Current test function
          ----------------------------------------------------------------
          vim.keymap.set(
            "n",
            "<Leader>tn",
            "<cmd>GoTestFunc<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: test nearest function",
            })
          )

          ----------------------------------------------------------------
          -- Current test file
          ----------------------------------------------------------------
          vim.keymap.set(
            "n",
            "<Leader>tf",
            "<cmd>GoTestFile<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: test file",
            })
          )

          ----------------------------------------------------------------
          -- Current package
          ----------------------------------------------------------------
          vim.keymap.set(
            "n",
            "<Leader>tp",
            "<cmd>GoTestPkg<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: test package",
            })
          )

          ----------------------------------------------------------------
          -- Coverage
          ----------------------------------------------------------------
          vim.keymap.set(
            "n",
            "<Leader>tc",
            "<cmd>GoCoverage<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: coverage",
            })
          )

          ----------------------------------------------------------------
          -- Go implementation / tooling
          --
          -- 以下は vim-go からの移行時によく使うものだけ shortcut 化。
          -- その他は :GoXXX を直接利用する。
          ----------------------------------------------------------------
          vim.keymap.set(
            "n",
            "<Leader>gi",
            "<cmd>GoImpl<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: implement interface",
            })
          )

          vim.keymap.set(
            "n",
            "<Leader>ge",
            "<cmd>GoIfErr<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: if err",
            })
          )

          vim.keymap.set(
            "n",
            "<Leader>gm",
            "<cmd>GoModTidy<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: mod tidy",
            })
          )

          vim.keymap.set(
            "n",
            "<Leader>gl",
            "<cmd>GoLint<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: lint",
            })
          )

          vim.keymap.set(
            "n",
            "<Leader>gv",
            "<cmd>GoVet<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: vet",
            })
          )

          ----------------------------------------------------------------
          -- Debug
          ----------------------------------------------------------------
          vim.keymap.set(
            "n",
            "<Leader>dd",
            "<cmd>GoDebug<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: debug",
            })
          )

          vim.keymap.set(
            "n",
            "<Leader>dt",
            "<cmd>GoDebug -n<CR>",
            vim.tbl_extend("force", opts_local, {
              desc = "Go: debug nearest test",
            })
          )
        end,
      })
    end,
  },
}
