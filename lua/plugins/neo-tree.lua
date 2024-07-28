return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		local config = {
			window = {
				width = 30,
			},
		}
		require("neo-tree").setup(config)
	end,
	-- Открыть-закрыть файловый менеджер
	vim.keymap.set("n", "<A-1>", ":Neotree filesystem reveal left<CR>", {}),
}
