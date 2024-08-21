local M = {}

-- Update imports on file move
M.plugin = {
	"antosha417/nvim-lsp-file-operations",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-tree.lua",
	},
	config = function()
		require("lsp-file-operations").setup()
	end,
}

return M
