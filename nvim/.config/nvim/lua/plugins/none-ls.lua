return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,  -- Python (black)
        null_ls.builtins.formatting.isort,  -- Python imports
        null_ls.builtins.formatting.clang_format, -- C++
        null_ls.builtins.formatting.google_java_format, --Java
        null_ls.builtins.formatting.shellharden, -- Shell scripts
        null_ls.builtins.formatting.stylua, -- Lua
      },
    })

    -- Keybinding to format
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}

