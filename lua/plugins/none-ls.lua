local M = {}

M.plugin = {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettierd,
				},
			})

			vim.keymap.set("n", "<Leader>gf", vim.lsp.buf.format, {})
		end,
	},
}

return M

