vim.g.mapleader = " "

vim.keymap.set("n", "-", ":Ex<CR>", { silent = true })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("v", "<leader>", [["+y]])

vim.keymap.set("n", "<A-j>", ":cn<CR>")
vim.keymap.set("n", "<A-k>", ":cp<CR>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
