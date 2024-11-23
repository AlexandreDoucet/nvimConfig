return {
	"nvimtools/none-ls.nvim",

	config = function()
		local ok, null_ls = pcall(require, "null-ls")
		if not ok then
			vim.notify("null-ls is not installed", vim.log.levels.ERROR)
			return
		end

		-- Define formatting sources
		local formatting_sources = {
			-- Lua formatting using stylua
			null_ls.builtins.formatting.stylua,

			-- Python formatting using black and isort
			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.isort,

			-- C++ formatting using clang_format
			null_ls.builtins.formatting.clang_format,
		}

		-- Function to check if required tools are installed and notify the user
		local function check_sources(sources)
			for _, source in ipairs(sources) do
				local name = source._name or source.name
				local command = source._command or source.command  -- Get command to check

				if command and vim.fn.executable(command) == 0 then
					-- Enhanced notification with instructions
					vim.notify(
						string.format("%s is not installed. Install it via your package manager or manually.", name),
						vim.log.levels.WARN
					)
				end
			end
		end

		-- Check if any required tools are missing
		check_sources(formatting_sources)

		-- Setup null-ls with the defined sources
		null_ls.setup({
			sources = formatting_sources,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					-- Enable formatting on save
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})

		-- Key mapping to format the current buffer
		vim.keymap.set("n", "<leader>gf", function()
			vim.lsp.buf.format({ async = true })  -- Use async formatting
		end, { silent = true, desc = "Format current buffer" })
	end,
}
