local M = {}

M.plugin = {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function ()
	 M.setup()
	end,
}

M.setup = function()
	local on_attach = require("plugins.lsp.utils.on_attach")

	local api = require("typescript-tools.api")
	require("typescript-tools").setup({
    on_attach = on_attach,
		handlers = {
			["typescriptTools/organizeImports"] = api.organizeImports,
		},
	})
end

return M
