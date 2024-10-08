local M = {}

M.plugin = {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		-- or                              , branch = '0.1.x',
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			M.setupTelescope()
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			M.setupUiSelect()
		end,
	},
	{
		"princejoogie/dir-telescope.nvim",
		config = function()
			M.setupDirTelescope()
		end,
	},
}

M.setupTelescope = function()
	local telescope = require("telescope")

	telescope.setup({
		defaults = {
			layout_strategy = "vertical",
		},
	})
end

M.setupUiSelect = function()
	require("telescope").setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		},
	})
	require("telescope").load_extension("ui-select")
end

M.setupDirTelescope = function()
	require("dir-telescope").setup()
end

return M
