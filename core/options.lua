vim.g.netrw_banner = 0
vim.g.mapleader = " "

vim.cmd [[
  set nu rnu signcolumn=yes winborder=single
  set tabstop=4 shiftwidth=2
  set scrolloff=10 cursorline lazyredraw
  set path+=**
]]

-- Enable persistent undo
vim.opt.undofile = true

-- Set undo directory
local undodir = vim.fn.stdpath("config") .. "/undo"
vim.opt.undodir = undodir

-- Auto-create the undo directory if it doesn't exist
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end
