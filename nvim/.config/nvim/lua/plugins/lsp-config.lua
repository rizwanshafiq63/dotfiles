return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities()
      )

      local lspconfig = require("lspconfig")

      -- Python LSP (Using ruff)
      lspconfig.ruff.setup({})

      -- C++ LSP (Using clangd)
      lspconfig.clangd.setup({
        capabilities = {
          offsetEncoding = { "utf-16" }
        }
      })

      -- Java LSP (Using jdtls)
      lspconfig.jdtls.setup({
        cmd = { "jdtls" },
        root_dir = vim.fs.dirname(vim.fs.find({'.git', 'mvnw', 'gradlew'}, { upward = true })[1]),
      })

      -- TailwindCSS
      lspconfig.tailwindcss.setup({
        capabilities = capabilities
      })

      -- Ruby
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
        cmd = { "/home/rizz/.asdf/shims/ruby-lsp" }
      })

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })

      -- Kotlin
      lspconfig.kotlin_language_server.setup({
        capabilities = capabilities,
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
    end,
  },
}

