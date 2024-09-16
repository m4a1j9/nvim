local M = {}

M.plugin = {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			M.setup()
		end,
	},
}

M.setup = function()
	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettierd,
		},
	})

	-- For some reason it doesn't work outside of setup
	local opts = {
		noremap = true,
		silent = true,
	}
	opts.desc = "Format current buffer"
	vim.keymap.set("n", "<Leader>gf", vim.lsp.buf.format, opts)
end

return M
