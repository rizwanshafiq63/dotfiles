vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

--NeoTree File Explorer
vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { noremap = true, silent = true })

-- =======================
-- COPY/PASTE KEYBINDINGS 
-- =======================

-- vim.opt.colorcolumn = "100"; -- Highlight col 100, providing visual guide for line length
vim.opt.clipboard = "unnamedplus" -- clipboard support (wl-clipboard required or xclip)

-- Copy to system clipboard using Ctrl + Shift + C
--vim.api.nvim_set_keymap("v", "<C-S-c>", '"+y', { noremap = true, silent = true })

-- Paste from system clipboard using Ctrl + Shift + P in Neovim
--vim.api.nvim_set_keymap("n", "<C-S-p>", '"+p', { noremap = true, silent = true })

-- Paste before the cursor using Ctrl + Shift + P (Shift + Insert behavior)
--vim.api.nvim_set_keymap("n", "<C-S-P>", '"+P', { noremap = true, silent = true })


-- =======================================
-- CODE RUN KEYMAP (Java, C++, C, Python)
-- =======================================

vim.keymap.set("n", "<leader>r", function()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%:p") -- Full path to current file
  local cmd = ""

  if filetype == "python" then
    cmd = "python3 " .. filename
  elseif filetype == "cpp" then
    -- Added -std=c++17 for vector support
    cmd = "g++ -std=c++17 " .. filename .. " -o /tmp/a.out && /tmp/a.out"
  elseif filetype == "c" then
    cmd = "gcc " .. filename .. " -o /tmp/a.out && /tmp/a.out"
  elseif filetype == "java" then
    -- Single-file source code mode (Java 11+). No .class files left on disk.
    cmd = "java " .. filename
  else
    print("Unsupported file type: " .. filetype)
    return
  end

  -- Open Kitty and run the command (In case, you don't have Tmux)
  vim.cmd("silent !kitty -e sh -c '" .. cmd .. "; exec zsh' &")
end, { noremap = true, silent = true })

-- TMUX HANDLE CASE
-- local is_tmux = os.getenv("TMUX")

--  if is_tmux then
    -- Inside tmux: split horizontally and run the command
--    vim.cmd("silent !tmux split-window -h '" .. cmd .. "'")
--  else
    -- Not in tmux: Open a new Kitty terminal and execute the command
--    vim.cmd("silent !kitty -e sh -c '" .. cmd .. "; exec zsh' &") -- replace zsh' with bash' if u have bash
--  end
--end, { noremap = true, silent = true }) 

