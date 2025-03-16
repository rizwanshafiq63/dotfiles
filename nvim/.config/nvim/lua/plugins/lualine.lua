return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Icons support
  config = function()
    require("lualine").setup({
      options = {
        theme = "dracula", -- Change theme (gruvbox, catppuccin, onedark, etc.)
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location", "" } -- Arch Linux logo added here
      },
    })
  end,
}

