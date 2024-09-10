return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },

  config = function()
    --vim.keymap.set('n','<leader>n', ':Neotree filesystem toggle left<CR>') -- toggles the file system visibility
--    vim.keymap.set("n", "<leader><leader>", ":Neotree filesystem toggle show left<CR>") -- toggles the file system visibility
    vim.keymap.set("n", "<leader>n", ":Neotree filesystem focus left<CR>")            -- toggles the file system visibility
    vim.keymap.set("n", "<leader>m", ":Neotree filesystem close left<CR>")            -- toggles the file system visibility
  end,
}
