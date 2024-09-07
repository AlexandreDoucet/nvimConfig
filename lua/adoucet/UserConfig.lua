
--change leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n","<leader>pv",vim.cmd.Ex)


-- change tab settings to 2 spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Editor parameters
vim.opt.ttimeoutlen = 10




