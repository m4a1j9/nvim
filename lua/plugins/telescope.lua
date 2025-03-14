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

-- open Telescope, then press <C-q>
M.select_one_or_multi = function(prompt_bufnr)
	local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
	local multi = picker:get_multi_selection()
	if not vim.tbl_isempty(multi) then
		require("telescope.actions").close(prompt_bufnr)
		for _, j in pairs(multi) do
			if j.path ~= nil then
				vim.cmd(string.format("%s %s", "edit", j.path))
			end
		end
	else
		require("telescope.actions").select_default(prompt_bufnr)
	end
end

M.setupTelescope = function()
	local telescope = require("telescope")

	telescope.setup({
		defaults = {
			layout_strategy = "vertical",
			mappings = {
				i = {
					["<A-CR>"] = M.select_one_or_multi,
				},
			},
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
