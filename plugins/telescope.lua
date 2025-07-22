local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>/", builtin.live_grep)
vim.keymap.set("n", "<leader>v", builtin.git_status)
vim.keymap.set("n", "grr", builtin.lsp_references)
