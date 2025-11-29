-- Neovim key remappings
vim.g.mapleader = " "

-- File explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)      -- Space + e (standard)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)     -- Space + p + v (alternative)
vim.keymap.set("n", "-", vim.cmd.Ex)              -- Just - (quick access)

-- Move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without losing register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete to void register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
