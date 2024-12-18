local M = {}

M.plugin = {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
	},
	config = function ()
	  M.setup()
	end,
}

M.setup = function()
	require("neogit").setup({
		integrations = {
			diffview = true,
		},
	})
end

return M
