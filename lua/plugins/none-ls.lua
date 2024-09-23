return {
	"nvimtools/none-ls.nvim",  

	config = function()
		local null_ls = require("null-ls")

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

		-- Function to check if required tools are installed
		local function check_sources(sources)
			for _, source in ipairs(sources) do
				local name = source._name or source.name
				local command = source._command or source.command  -- Get command to check

				if command and vim.fn.executable(command) == 0 then
					vim.notify(name .. " is not installed.", vim.log.levels.ERROR)
				end
			end
		end

		-- Check if any required tools are missing
		check_sources(formatting_sources)

		-- Setup null-ls with the defined sources
		null_ls.setup({
			sources = formatting_sources,
		})

		-- Key mapping to format the current buffer
		vim.keymap.set("n", "<leader>gf", function()
			vim.lsp.buf.format({ async = true })  -- Use async formatting
		end, { silent = true, desc = "Format current buffer" })
	end,
}
