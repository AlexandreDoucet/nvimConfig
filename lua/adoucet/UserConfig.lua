
--change leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n","<leader>pv",vim.cmd.Ex)


-- change tab settings to 2 spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Editor parameters
vim.opt.ttimeoutlen = 10 -- helps with registering leader key and escape faster (ToTest)
vim.opt.relativenumber = true -- Uses relative numbers for easier jumping
vim.opt.cursorline = true -- Display the line number the cursor is one
vim.opt.number = true -- Show the current line number the cursor is on instead of 0.
vim.opt.scrolloff = 10 -- Keeps cursor above N lines of the enf of the screen if not at the end of the file
vim.opt.undofile = true --preserve undo after close (ToTest)

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
