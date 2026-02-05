return {
  "nvimtools/none-ls.nvim",
  lazy = false,
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        -- C++
        null_ls.builtins.formatting.clang_format,
        -- Java
        null_ls.builtins.formatting.google_java_format,
        -- Kotlin
        null_ls.builtins.formatting.ktlint,
        -- Shell
        null_ls.builtins.formatting.shellharden,
        -- Lua
        null_ls.builtins.formatting.stylua,
        -- 🌐 Web
        null_ls.builtins.formatting.prettier.with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "css",
            "scss",
            "html",
            "json",
            "yaml",
            "markdown",
          },
        }),
      },
    })

    -- Keybinding to format
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}

