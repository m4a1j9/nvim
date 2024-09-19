local M = {}

M.plugin = {
	{
		"rmagatti/auto-session",
		dependencies = {
			"nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
		},
		config = function()
			require("auto-session").setup({
				lazy_support = true,
				suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},
}

return M
