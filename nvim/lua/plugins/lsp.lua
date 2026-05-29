-- LSP: nvim-lspconfig + mason
--
-- 設計方針 (把握しやすさ重視で集約):
--   * 各言語サーバの設定 (vim.lsp.config) はこのファイルにすべて列挙する。
--   * Neovim 0.11 の新 API (vim.lsp.config / vim.lsp.enable) を利用。
--   * LSP/formatter のバイナリは mason-tool-installer.nvim で自動インストールする。
--   * mason-lspconfig は automatic_enable=true にして vim.lsp.config 済みのサーバを自動 enable。
return {
  -- mason: コマンドが即時利用できるよう独立した spec にする
  -- (nvim-lspconfig の dependencies に入れるとファイルを開くまで :Mason が使えなくなる)
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonLog", "MasonUninstall" },
    build = ":MasonUpdate",
    opts = {},
  },
  -- mason-tool-installer: 起動後に裏で LSP/formatter バイナリを揃える
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    cmd = { "MasonToolsInstall", "MasonToolsInstallSync", "MasonToolsUpdate", "MasonToolsClean" },
    opts = {
      ensure_installed = {
        -- LSP
        "lua-language-server",
        "vtsls",
        "eslint-lsp",
        "gopls",
        "marksman",
        "json-lsp",
        "yaml-language-server",
        -- Formatter
        "stylua",
        "prettierd",
        "eslint_d", -- 保存時に eslint --fix を走らせるため
        "gofumpt",
        "goimports",
      },
      run_on_start = true,
    },
  },
  -- nvim-lspconfig: 実ファイルを開いたタイミングで各 LSP を構成
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp", -- 補完 capabilities を取得するため
    },
    config = function()
      -- ===== 共通 capabilities (補完エンジンの能力を LSP に通知) =====
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- ===== 言語サーバごとの設定 =====
      -- lua_ls: Neovim 設定の補完で使う
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
          },
        },
      })

      -- vtsls: TypeScript/JavaScript 用 (ts_ls 後継・高速。Expo/RN は tsconfig 解決で十分)
      vim.lsp.config("vtsls", {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              variableTypes = { enabled = false },
            },
            updateImportsOnFileMove = { enabled = "always" },
          },
          javascript = {
            updateImportsOnFileMove = { enabled = "always" },
          },
        },
      })

      -- eslint: 静的解析 (ALE 置き換え)
      vim.lsp.config("eslint", {
        settings = {
          workingDirectories = { mode = "auto" },
        },
      })

      -- gopls
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            gofumpt = true,
            usePlaceholders = true,
            staticcheck = true,
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            hints = {
              parameterNames = true,
              assignVariableTypes = true,
            },
          },
        },
      })

      -- marksman: Markdown LSP
      vim.lsp.config("marksman", {})

      -- jsonls / yamlls
      vim.lsp.config("jsonls", {})
      vim.lsp.config("yamlls", {})

      -- mason-tool-installer による LSP/formatter バイナリの ensure_installed は
      -- このファイル上部の独立 spec 側に移してある (起動時に裏で走る)。

      -- enable する LSP をリストで明示する。
      -- true だと stylua (formatter) が --lsp モードで LSP 扱いされるなど意図しない
      -- enable が起きるため、必要なものだけ列挙する。
      require("mason-lspconfig").setup({
        ensure_installed = {}, -- 実体管理は mason-tool-installer 側に集約
        automatic_enable = {
          "lua_ls",
          "vtsls",
          "eslint",
          "gopls",
          "marksman",
          "jsonls",
          "yamlls",
        },
      })

      -- ===== LspAttach 時にキーマップを設定 =====
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          -- 定義/参照/実装ジャンプ (Neovim 0.11 は gr* が既定で割当済みだが上書き)
          map("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
          map("n", "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
          map("n", "gr", vim.lsp.buf.references, "LSP: References")
          map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
          map("n", "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature help")
          map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
          map("n", "<leader>d", vim.diagnostic.open_float, "Diagnostic: Float")
          map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
          map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
        end,
      })

      -- 診断表示の見た目
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        severity_sort = true,
        float = { border = "rounded", source = true },
      })
    end,
  },
}
