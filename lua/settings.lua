-- vim.opt.mapleader = " "
vim.opt.mouse = "nvi" -- Actually use the mouse
vim.opt.ignorecase = true -- Make searching case insensitive
vim.opt.smartcase = true -- ... unless the query has capital letters.
vim.opt.gdefault = true -- Use 'g' flag by default with :s/foo/bar/
vim.opt.undofile = true
vim.opt.signcolumn = "number"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.splitbelow = true
vim.keymap.set("v", ">", ">gv", { noremap = true, desc = "Indent right" })
vim.keymap.set("v", "<", "<gv", { noremap = true, desc = "Indent left" })
