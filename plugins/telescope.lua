local telescope = require("telescope")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

telescope.setup({
	defaults = {
		vimgrep_arguments = {
			'rg', '--color=never', '--no-heading', '--with-filename', '--line-number',
			'--column', '--smart-case', '--hidden', '--glob',
			'!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock}',
		},
		prompt_prefix = '',
	},
	pickers = {
		lsp_references = { initial_mode = "normal" },
		lsp_definitions = { initial_mode = "normal" },
		lsp_type_definitions = { initial_mode = "normal" },
		git_status = { initial_mode = "normal" },
		buffers = { initial_mode = "normal" },
		grep_string = { initial_mode = "normal" },
		diagnostics = { initial_mode = "normal" },
		resume = { initial_mode = "normal" },
	},
})

-- Keymaps
vim.keymap.set("n", "<leader>f", function()
	require("telescope.builtin").find_files({
		find_command = {
			"rg", "--files", "--hidden", "--glob", '!{**/.git/*,**/node_modules/*,**/package-lock.json,**/.yarn/*}',
		},
	})
end, { desc = "Find files (.config/ but skip .git/)" })
vim.keymap.set("n", "<leader>F", function() builtin.find_files({ hidden = true }) end, { desc = "Find files (all)" })
vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "Find diagnostics" })
vim.keymap.set("n", "<leader>v", builtin.git_status, { desc = "Find git status (and see diffs)" })
vim.keymap.set("n", "<leader>j", builtin.jumplist, { desc = "Open jumplist picker" })
vim.keymap.set("n", "<leader>'", builtin.resume, { desc = "Open last picker" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live grep (all)" })
vim.keymap.set("n", "<leader>*", function() builtin.grep_string({ search = vim.fn.expand("<cword>") }) end,
	{ desc = "Grep word under cursor" })
vim.keymap.set("n", "<leader>8", function() builtin.grep_string({ search = vim.fn.expand("<cword>") }) end,
	{ desc = "Grep word under cursor" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Find help tags" })
vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "Find references" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Find definitions" })
vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { desc = "Find type definitions" })
