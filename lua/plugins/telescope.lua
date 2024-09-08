


local function find_files_and_escape()
  require('telescope.builtin').find_files()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', true)
end

return{--Telescope
  'nvim-telescope/telescope.nvim', 
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },



  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff',find_files_and_escape, {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  end


}





