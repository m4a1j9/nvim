local M = {}

M.plugin = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		M.setup()
	end,
}

M.setup = function()
	require("neo-tree").setup({
		window = {
			width = 35,
		},
		filesystem = {
			filtered_items = {
				never_show_by_pattern = {
					".git",
					".idea",
					".vscode",
				},
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_by_name = {
					"node_modules",
				},
			},
		},
		default_component_configs = {
			indent = {
				indent_size = 1,
			},
		},
	})
end

if not pcall(debug.getlocal, 4, 1) then
	M.setup()
end

return M
