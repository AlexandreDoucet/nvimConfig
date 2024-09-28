return {
  -- Mason and Mason-LSPConfig for easy LSP management
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    lazy = false,
    opts = {
      automatic_installation = true,
    },
  },
  -- Neovim's LSP configuration with Mason integration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    lazy = false,
    config = function()
      -- List of LSP servers to install and configure
      local servers = { "lua_ls", "jedi_language_server", "clangd", "rust_analyzer" }
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Setup Mason and Mason-LSPConfig
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })

      -- On_attach function for LSP key bindings
      local on_attach = function(_, bufnr)
        local buf_map = function(mode, lhs, rhs, opts)
          opts = vim.tbl_extend("force", { buffer = bufnr }, opts or {})
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        buf_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
        buf_map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
        buf_map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
        buf_map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename Symbol" })
        buf_map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      end

      -- Setup LSP servers
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
  -- Rust-specific plugin with DAP (Debug Adapter Protocol) integration
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local mason_registry = require("mason-registry")

      -- Ensure codelldb is installed or notify user
      if not mason_registry.has_package("codelldb") then
        vim.notify("codelldb not installed yet. Please restart Neovim after installation.", vim.log.levels.WARN)
        return
      end

      local codelldb = mason_registry.get_package("codelldb")
      if not codelldb:is_installed() then
        vim.notify("Installing codelldb...", vim.log.levels.INFO)
        codelldb:install()
        return
      end

      -- Setup Rust DAP with codelldb
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      local cfg = require("rustaceanvim.config")

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
  },
}
