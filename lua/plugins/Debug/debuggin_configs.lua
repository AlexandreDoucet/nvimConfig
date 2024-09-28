return {

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dapui").setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set("n", "<leader>dc", dap.continue, {})
      vim.keymap.set("n", "<leader>do", dap.step_over, {})
      vim.keymap.set("n", "<leader>di", dap.step_into, {})
      vim.keymap.set("n", "<leader>du", dap.step_out, {})
      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, {})


    end,
  },
  {

    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    opts = {
      handlers = {},
      ensure_installed = { "codelldb", "python" },
    },
  },
}
