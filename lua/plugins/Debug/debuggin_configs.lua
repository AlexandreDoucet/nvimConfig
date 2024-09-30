return {

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },

    config = function()
      local dap_ok, dap = pcall(require, "dap")
      local dapui_ok, dapui = pcall(require, "dapui")

      if not dap_ok or not dapui_ok then
        return -- Exit early if dap or dapui isn't available
      end

      -- Setup DAP UI
      dapui.setup()

      -- Utility function to handle opening/closing DAP UI
      local function setup_dap_listeners()
        dap.listeners.before.attach.dapui_config = function()
          dapui.open()
        end

        dap.listeners.before.launch.dapui_config = function()
          dapui.open()
        end

        dap.listeners.before.event_terminated.dapui_config = function()
          -- Ensures the DAP UI is closed after the session ends
          pcall(dapui.close)
        end

        dap.listeners.before.event_exited.dapui_config = function()
          pcall(dapui.close)
        end
      end

      -- Set up DAP listeners
      setup_dap_listeners()

      -- Key mappings for DAP controls
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue Debugging" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })

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
      -- Ensures DAP adapters are installed
      ensure_installed = { "codelldb", "python" },

      -- Custom handlers for debugging adapters (can extend in the future)
      handlers = {},
    },
  },
}
