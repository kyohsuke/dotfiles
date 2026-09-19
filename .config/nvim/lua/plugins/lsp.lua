return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",

      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },

    opts = {
      ensure_installed = {
        "gopls",
        "solargraph",
        "sqls",
        "graphql",
      },

      automatic_enable = true,
    },

    config = function(_, opts)
      local cmp = require("cmp")

      -- vim-lsp-settings の gopls 設定を移植
      vim.lsp.config("gopls", {
        cmd = {
          "gopls",
          "-rpc.trace",
          "-debug=localhost:6060",
        },

        settings = {
          gopls = {
            directoryFilters = {
              "-.git",
              "-**/.github",
              "-**/node_modules",
            },
          },
        },
      })

      ------------------------------------------------------------
      -- LSP capabilities
      ------------------------------------------------------------
      local capabilities =
        require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      require("mason-lspconfig").setup(opts)

      ------------------------------------------------------------
      -- Completion
      --
      -- 元の asyncomplete:
      --   auto_popup = 0
      --   <C-Space> で明示的に開始
      --   <Tab>      次候補
      --   <S-Tab>    前候補
      --   <C-y>      cancel
      --   <BS>       popup を閉じて BS
      --
      -- source も LSP のみにする。
      -- 元の .vimrc には asyncomplete-buffer.vim がないため。
      ------------------------------------------------------------
      cmp.setup({
        completion = {
          autocomplete = false,
        },

        preselect = cmp.PreselectMode.None,

        performance = {
          debounce = 200,
        },

        mapping = {
          --------------------------------------------------------
          -- asyncomplete の Tab / Shift-Tab
          --------------------------------------------------------
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          --------------------------------------------------------
          -- asyncomplete の <C-Space>
          --------------------------------------------------------
          ["<C-Space>"] = cmp.mapping.complete(),

          --------------------------------------------------------
          -- asyncomplete の <C-y>
          -- popup をキャンセルして通常の C-y
          --------------------------------------------------------
          ["<C-y>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.abort()
            else
              fallback()
            end
          end, { "i" }),

          --------------------------------------------------------
          -- asyncomplete の <BS>
          -- popup を閉じてから BS
          --------------------------------------------------------
          ["<BS>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.close()
            end
            fallback()
          end, { "i" }),

          --------------------------------------------------------
          -- vim-lsp.vim の
          -- inoremap <expr> <cr>
          --     pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
          --------------------------------------------------------
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({
                select = true,
              })
            else
              fallback()
            end
          end, { "i" }),

          --------------------------------------------------------
          -- これは元の Vim 設定にはない。
          --
          -- 前の質問で問題になった「<C-n>/<C-p> を押すと
          -- Neovim の builtin completion に切り替わる」
          -- 問題を避けるために追加する。
          --------------------------------------------------------
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
        },

        -- 元の構成には buffer completion source がない。
        sources = {
          { name = "nvim_lsp" },
        },
      })

      ------------------------------------------------------------
      -- LSP keymaps
      ------------------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup(
          "my_lsp_keymaps",
          { clear = true }
        ),

        callback = function(ev)
          local bufnr = ev.buf

          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
              buffer = bufnr,
              silent = true,
              desc = "LSP: " .. desc,
            })
          end

          --------------------------------------------------------
          -- gd
          --------------------------------------------------------
          map(
            "n",
            "gd",
            vim.lsp.buf.definition,
            "definition"
          )

          --------------------------------------------------------
          -- <C-]>
          --
          -- 元の vim-lsp:
          --
          -- function! g:LspDefinitionSplitWindow()
          --   split
          --   call lsp#ui#vim#definition(0)
          -- endfunction
          --------------------------------------------------------
          map("n", "<C-]>", function()
            vim.cmd("aboveleft split")
            vim.lsp.buf.definition()
          end, "definition in split")

          --------------------------------------------------------
          -- ge
          --------------------------------------------------------
          map("n", "ge", function()
            vim.diagnostic.setloclist({
              open = true,
            })
          end, "document diagnostics")

          --------------------------------------------------------
          -- F2
          --------------------------------------------------------
          map(
            "n",
            "<F2>",
            vim.lsp.buf.rename,
            "rename"
          )

          --------------------------------------------------------
          -- gr
          --------------------------------------------------------
          map(
            "n",
            "gr",
            vim.lsp.buf.references,
            "references"
          )

          --------------------------------------------------------
          -- gi
          --------------------------------------------------------
          map(
            "n",
            "gi",
            vim.lsp.buf.implementation,
            "implementation"
          )

          --------------------------------------------------------
          -- gt
          --------------------------------------------------------
          map(
            "n",
            "gt",
            vim.lsp.buf.type_definition,
            "type definition"
          )

          --------------------------------------------------------
          -- K
          --------------------------------------------------------
          map(
            "n",
            "K",
            vim.lsp.buf.hover,
            "hover"
          )

          --------------------------------------------------------
          -- <C-o>
          --
          -- vim-lsp の設定では Insert mode でも hover。
          --------------------------------------------------------
          vim.keymap.set(
            "i",
            "<C-o>",
            vim.lsp.buf.hover,
            {
              buffer = bufnr,
              silent = true,
              desc = "LSP: hover",
            }
          )

          --------------------------------------------------------
          -- gs
          --
          -- 旧設定では CtrlP + ctrlp-lsp。
          -- Neovim ではまず builtin LSP の document_symbol を使用。
          --------------------------------------------------------
          map(
            "n",
            "gs",
            vim.lsp.buf.document_symbol,
            "document symbol"
          )

          --------------------------------------------------------
          -- gS
          --------------------------------------------------------
          map(
            "n",
            "gS",
            vim.lsp.buf.workspace_symbol,
            "workspace symbol"
          )
        end,
      })

      ------------------------------------------------------------
      -- LspStatus
      ------------------------------------------------------------
      vim.api.nvim_create_user_command("LspStatus", function()
        local clients = vim.lsp.get_clients({
          bufnr = 0,
        })

        if #clients == 0 then
          vim.notify(
            "LSP: no active clients",
            vim.log.levels.INFO
          )
          return
        end

        local lines = {
          "LSP clients:",
        }

        for _, client in ipairs(clients) do
          table.insert(
            lines,
            string.format(
              "  %-20s id=%d",
              client.name,
              client.id
            )
          )
        end

        vim.notify(
          table.concat(lines, "\n"),
          vim.log.levels.INFO
        )
      end, {})

      ------------------------------------------------------------
      -- LspRestartServer
      --
      -- Neovim の native :lsp restart をラップする。
      ------------------------------------------------------------
      vim.api.nvim_create_user_command(
        "LspRestartServer",
        function(cmd)
          if cmd.args == "" then
            vim.cmd("lsp restart")
          else
            vim.cmd(
              "lsp restart " .. cmd.args
            )
          end
        end,
        {
          nargs = "?",
          desc = "Restart LSP server",
        }
      )

      ------------------------------------------------------------
      -- LspDebug
      ------------------------------------------------------------
      vim.api.nvim_create_user_command(
        "LspDebug",
        function()
          vim.lsp.set_log_level("debug")

          vim.notify(
            "LSP log level: debug\n" ..
            "Log: " .. vim.lsp.log.get_filename(),
            vim.log.levels.INFO
          )
        end,
        {}
      )

      ------------------------------------------------------------
      -- Diagnostics
      --
      -- 元設定:
      --   virtual_text = 0
      ------------------------------------------------------------
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  },
}
