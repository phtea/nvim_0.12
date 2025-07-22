vim.cmd [[
	let g:netrw_banner = 0
	let g:mapleader = " "
	set nu rnu signcolumn=yes winborder=single tabstop=4 shiftwidth=2 scrolloff=10 cursorline lazyredraw path+=**
	colo habamax
]]

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/completion') then
			vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

vim.lsp.config('*', {
	capabilities = { textDocument = { semanticTokens = { multilineTokenSupport = true, } } },
	root_markers = { '.git' },
})

vim.diagnostic.config({ virtual_text = { current_line = true } })
vim.lsp.enable({ 'clangd', 'lua_ls' })

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

vim.pack.add({
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  { src = 'https://github.com/ThePrimeagen/harpoon', version = "harpoon2", },
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/lewis6991/gitsigns.nvim',
})

require("nvim-surround").setup {}

local harpoon = require("harpoon")

harpoon:setup() -- REQUIRED

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- local telescope = require("telescope")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>/", builtin.live_grep)

require('gitsigns').setup {
  on_attach = function(bufnr)
	local gs = package.loaded.gitsigns

	local opts = { buffer = bufnr, noremap = true, silent = true }

	-- Navigation
	vim.keymap.set('n', '<leader>gn', gs.next_hunk, opts)
	vim.keymap.set('n', '<leader>gp', gs.prev_hunk, opts)

	vim.keymap.set('n', ']g', gs.next_hunk, opts)
	vim.keymap.set('n', '[g', gs.prev_hunk, opts)

	-- Reset hunk
	vim.keymap.set('n', '<leader>gr', gs.reset_hunk, opts)

	-- Preview hunk
	vim.keymap.set('n', '<leader>gh', gs.preview_hunk, opts)

	-- Stage hunk
	vim.keymap.set('n', '<leader>gs', gs.stage_hunk, opts)

	-- Stage buffer WITH confirmation prompt
	vim.keymap.set('n', '<leader>gS', function()
	  vim.ui.input({ prompt = 'Stage entire buffer? Type y to confirm: ' }, function(input)
		if input == 'y' then
		  gs.stage_buffer()
		  vim.notify('Buffer staged!', vim.log.levels.INFO)
		else
		  vim.notify('Cancelled staging buffer.', vim.log.levels.WARN)
		end
	  end)
	end, opts)
  end
}
