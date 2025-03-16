return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Icons support
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw = true,
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = { "node_modules" },
        },
      },
      window = {
        width = 35,
        position = "left",
        mappings = {
          ["<CR>"] = "open",          -- Open file/folder with Enter
          ["o"] = "open",             -- Open file/folder
          ["<C-v>"] = "open_vsplit",  -- Open in vertical split
          ["<C-x>"] = "open_split",   -- Open in horizontal split
          ["<C-t>"] = "open_tabnew",  -- Open in new tab
          ["q"] = "close_window",     -- Close Neo-Tree
        },
      },
      default_component_configs = {
        indent = { padding = 1 },
        icon = {
          folder_closed = "",
          folder_open = "",
          default = "",
        },
        git_status = {
          symbols = {
            added = "",
            modified = "",
            deleted = "",
          },
        },
      },
    })
  end,
}

