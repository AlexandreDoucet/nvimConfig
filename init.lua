

require("adoucet.UserConfig")
require("adoucet")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

-- colorscheme
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
vim.api.nvim_set_hl(0,"NormalFloat",{bg = "none"})
vim.api.nvim_set_hl(0,"Normal",{bg = "none"})

--vim.keymap.set('n','<C-p>', builtin.find_files,{})

-- Configure Telescope key maps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- treesitter
local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc","html","python" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },  
})

--Neotree
vim.keymap.set('n','<leader>n', ':Neotree filesystem reveal left<CR>')

