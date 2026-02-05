
return {
  -- Mason core
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason ↔ LSP bridge
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "lua_ls",
          "jdtls",
          "tailwindcss",
          "kotlin_language_server",
          "ruff_lsp",
          "ruby_lsp",
        },
        automatic_installation = true,
      })
    end,
  },

  -- Native Neovim LSP config (attached to mason-lspconfig)
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      local servers = {
        clangd = {
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
        },

        jdtls = {
          cmd = { "jdtls" },
          root_dir = vim.fs.dirname(
            vim.fs.find({ ".git", "mvnw", "gradlew" }, { upward = true })[1]
          ),
        },

        tailwindcss = {},
        ruff_lsp = {},
        ruby_lsp = {
          cmd = { vim.fn.expand("~/.asdf/shims/ruby-lsp") },
        },
        lua_ls = {},
        kotlin_language_server = {},
      }

      for name, cfg in pairs(servers) do
        vim.lsp.config(name, cfg)
      end

      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
    end,
  },
}

